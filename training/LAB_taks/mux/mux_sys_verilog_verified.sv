`timescale 1ns/1ps

module scale_mux #(parameter WIDTH=8)(
	input logic [WIDTH-1:0]in_a,
	input logic [WIDTH-1:0] in_b,
	output logic [WIDTH-1:0] out,
	input logic sel_a
);
always_comb
unique case(sel_a)
	1'b1:out=in_a;
	1'b0:out=in_b;
	default out=1'bx;
endcase
endmodule 


// passsed test 


