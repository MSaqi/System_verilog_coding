// Code your design here
`timescale 1ns/100ps 

module register(
input  logic clk,
input  logic enable,
input  logic rst_,
input  logic [7:0] data,
output logic [7:0] out
);
//timeunit 1ns;
//timeprecision 1ps;

  always_ff @(posedge clk, negedge rst_)begin
    if(!rst_)
      out <=0;
    else if (enable)
      out <= data;
    else 
      out <= out;
 /* 	if(rst_==1'b1 && enable==1'bx)
			out=2'bxx;
    else if(rst_==1'b0 && enable==1'bx)
			out=0;
    else if((rst_==1 && enable==0)||(rst_ == 0 && enable ==0))
			out=out;
    else if((rst_ == 0 && enable ==1)||(rst_ == 1 && enable ==1))
			out=data;
		else
			out=out;*/
  end
endmodule 
