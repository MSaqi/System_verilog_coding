// Code your testbench here //
// or browse Examples
`include "interface.sv"
`include "amba_ahb_defines.v"

`include"test.sv"

`define AW 32
`define DW 32


module tb_top;
// Clock generator
  bit hclk;
  bit hresetn;
  

always #5 hclk = ~hclk;
  //reset generation
  initial begin
    hresetn = 0;
    #5 hresetn =1;
  end

  dut_if inf(hclk,hresetn);
  amba_ahb_slave#(
    .AW(`AW),   //Memory in Bytes
    .DW(`DW) )
  inst(
    .hclk(inf.hclk),
    .hresetn(inf.hresetn),
    .hsel(1'b1),
    .haddr(inf.haddr),
    .htrans(inf.htrans),
    .hwrite(inf.hwrite),
    .hsize(inf.hsize),
    .hburst(inf.hburst),
    .hprot(inf.hprot),
    .hwdata(inf.hwdata),
    .hrdata(inf.hrdata),
    .hready(inf.hready),
    .hresp(inf.hresp),
    .error(inf.error));
  test ta(inf);
  
  
  initial begin
    
   $dumpfile("dump.vcd"); $dumpvars;
    #5000;
  end
endmodule