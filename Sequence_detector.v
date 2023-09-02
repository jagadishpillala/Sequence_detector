`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// COLLEGE NAME: NATIONAL INSTITUTE OF TECHNOLOGY , DURGAPUR
// STUDENT NAME: PILLALA JAGADISH SAI KUMAR 
// 
// Create Date: 10.04.2023 16:15:41
// Design Name: 
// Module Name: sequence_detector
// Project Name: Verilog code for Sequence Detector using Moore FSM
// Target Devices: 
// Tool Versions: Xilinx Vivado 2022.2
// Description: 
// The sequence being detected is "1011" or One Zero One One 
// It is an overlapping sequence detector 
// This type of sequence detector allows overlap
//  It means the final bits of one sequence can be the start of another sequence 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
 


module sequence_detector(sequence_in ,clock,reset,detector_out);
input sequence_in;// binary input
input clock;//clock signal
input reset;//reset input
output reg detector_out;// output of  sequence_detector
parameter s0=3'b000,//reset or zero state
         s1=3'b001,//one state
         s2=3'b010,//one zero state
         s3=3'b011,//one zero one state
         s4=3'b100;//one zero one one state
   reg[2:0] current_state, next_state;//current state and next state
   //sequential  Moore FSM memory
   always@(posedge clock, posedge reset)
   begin
   if(reset==1)
   current_state <= s0;// If reset is high then state of the Moore FSM goes to zero state
   else 
   current_state <= next_state;//otherwise state of the Moore FSM goes to next_state
   end
   //combinational logic of the Moore FSM to determine next_state
   always @(current_state , sequence_in )
   begin
   case(current_state)
     s0 : begin
          if(sequence_in==1)
          next_state = s1;//If sequence_in =1 ,the next_state is s1
          else
          next_state =s0;// If sequence_in =0 ,the next_state is s0
          end
     s1 : begin
            if(sequence_in==1)
            next_state = s1; // If sequence_in =1 ,the next_state is s1
            else
            next_state = s2; //If sequence_in =0 ,the next_state is  s2
            end     
     s2 : begin
          if(sequence_in==1)
           next_state = s3;// If sequence_in =1 ,the next_state is s3
           else
           next_state = s0;// If sequence_in =0 ,the next_state is s0
           end 
     s3 : begin
          if(sequence_in==1)
           next_state = s4;// If sequence_in =1 ,the next_state is s4
           else
           next_state = s2;// If sequence_in =0 ,the next_state is s2
           end 
     s4 : begin
           if(sequence_in==1)
            next_state = s1;// If sequence_in =1 ,the next_state is s1
            else
            next_state =s2;// If sequence_in =0 ,the next_state is s2
            end 
      default : next_state = s0;
      endcase
    end  
   // combinational logic to determine the output of the Moore FSM
//  In moore FSM output only depends on current state        
  always @(current_state)
  begin
   case(current_state)
    s0 :  detector_out =0; // detector_out will be 0 till the "1011" sequence is detected
    s1 : detector_out =0;
    s2 : detector_out =0;
    s3 : detector_out =0;
    s4 : detector_out =1; // detector_out will be 1 when the FSM detects "1011"
    default : detector_out =0;
   endcase
  end           
endmodule
