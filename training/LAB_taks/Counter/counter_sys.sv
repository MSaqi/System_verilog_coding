module counter#(parameter WIDTH = 5)(
input logic rst_,
input logic clk,
input  logic  load,
input   logic  enable,
output  logic  [WIDTH-1:0] count,
input  logic  [WIDTH-1:0] data
);


always_ff @(posedge clk or negedge rst_)
begin 
  if(load==1)
		count<=data;
  else if(enable==1)
		count+=1;
  else if(!rst_)
		count<=0;
	else 
		count=count;
end
endmodule 	

