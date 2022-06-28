// Code your design here
`timescale 1ns/100ps

package typedefs;
typedef enum logic [2:0]  {HLT,SKZ,ADD,AND,XOR,LDA,STO,JMP} opcode_t;
endpackage:typedefs


module alu(accum,data,opcode,clk,out,zero);
import typedefs::*;
input logic [7:0] accum,data;
output logic [7:0] out;
input logic clk;
input  opcode_t opcode;
output logic zero;


always_ff @(negedge clk or posedge accum)begin
 /*if(accum==0)
		zero=1;
	else 
		zero=0;*/
    zero=~(|accum);    //a new sstyle of writting the if else statement......
  
case(opcode)
	HLT:out=accum;
	SKZ:out=accum;
  ADD:out=(data+accum);
  AND:out=(data&accum);
  XOR:out=(data^accum);
	LDA:out=data;
	STO:out=accum;
	JMP:out=accum;
endcase
end
endmodule

