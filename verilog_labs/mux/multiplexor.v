/*module mux #(parameter WIDTH=5) (sel,in0,in1,mux_out);
	input  sel;
	input [WIDTH-1] in0,in1;
	output [WIDTH-1] mux_out ;
	reg [WIDTH-1] mux_out ;
*/	
	
module multiplexor #(parameter WIDTH=5)
	(
		input 		  sel,
		input  [WIDTH-1:0] in0,
		input  [WIDTH-1:0] in1,
		output reg [WIDTH-1:0] mux_out
	);
	
always @(sel,in_1,in_0)
begin
  mux_out=sel?in1:in0;
end 
endmodule		 
		 /*case(sel)
		 	1'b0:mux_out=in0;
		 	1'b1:mux_out=in1;
		 	default : mux_out=0;
		 endcase*/

	
//endmodule

/*
module mux (sel ,in0,in1,mux_out);
	parameter width=5;
	input 	sel;
	input [width-1:0] in0,in1;
	output [width-1:0] mux_out;
	reg [width-1:0] mux_out;
*/	




	
