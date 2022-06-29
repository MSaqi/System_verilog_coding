///////////////////////////////////////////////////////////////////////////
// (c) Copyright 2013 Cadence Design Systems, Inc. All Rights Reserved.
//
// File name   : mem_test.sv
// Title       : Memory Testbench Module
// Project     : SystemVerilog Training
// Created     : 2013-4-8
// Description : Defines the Memory testbench module
// Notes       :
// 
///////////////////////////////////////////////////////////////////////////



module mem_test (input clk, ibus.tb tb_bus );
//modport tb   (output read,write,addr,data_in input data_out );
// SYSTEMVERILOG: timeunit and timeprecision specification
timeunit 1ns;
timeprecision 1ns;
// SYSTEMVERILOG: new data types - bit ,logic
bit         debug = 0; 
logic [7:0] rdata = 0;      // stores data read from memory for checking   edited
int error_status=0;
  
  
// Monitor Results
  initial begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      $timeformat ( -9, 0, " ns", 9 );
// SYSTEMVERILOG: Time Literals ////
      #40000ns $display ( "MEMORY TEST TIMEOUT" );
      $finish;
    end

initial
  begin: memtest
    $display("Clear Memory Test");
////////////////////////////////////////////////////////////////////	
    for (int i = 0; i< 32; i++)  // Write zero data to every address location
	    write_dat(i,0);  //addrs,data
/////////////////////////READ MEM//////////////////////////////////////////////
    for (int i = 0; i<32; i++)  
      begin 
       // Read every address location
	      read_mem_check(i,'h00);     // (addrs,expected value)
       // check each memory location for data = 'h00
      end
////////////////////////////////////////////////////////////////////
   // print results of test
    if(error_status==0)
      $display("Memory clearing with zero done with ZERO error code");
      $display("Data = Address Test");
////////////////////////////////////////////////////////////////////////////////
    for (int i = 0; i< 32; i++)
      write_dat(i,i);// Write data = address to every address location
  /////////////////////////////////////////////////////////////////    ////////// 
     //#10;
    for (int i = 0; i<32; i++)
      begin
       // Read every address location
        read_mem_check(i,i);
       // check each memory location for data = address
      end
  ////////////////////////////////////////////////////////////////////  
     if(error_status==0)
      $display("Memory clearing with zero done with ZERO error code");

   // print results of test

    $finish;
  end
  /////////////////////////////////////////////////////////////////
  //functions
// write function with data and address arguments///////////////////
  task write_dat(int addrs,bit [7:0] data_in_usr);
  begin 
    @(negedge clk)
    begin
      tb_bus.write=1; tb_bus.read=0;tb_bus.addr=addrs;tb_bus.data_in=data_in_usr;end   
    end
    if(debug==1)	  
      $display("Writing addr=%d data=%d",tb_bus.addr,data_in_usr);
  endtask
///////////////////////READ FUNCTION with data and expected value..//////////////////////////////////

 task read_mem_check(int addrs,bit [7:0] exp_data);
   @(negedge clk);
   tb_bus.write <= 0;tb_bus.read  <= 1;tb_bus.addr  <= addrs;
	  
   @(posedge clk);
   #1ns;   // so to be more precise about the data 
   rdata = tb_bus.data_out;tb_bus.data_in=0;
	  
   if(debug==1)
   $display("Reading addr=%d data=%b EXP_data= %b",tb_bus.addr,rdata,exp_data);  
	  //$display("rdata = %b",rdata);  // if you want to see the data input to testbench
  	
  @(negedge clk);
  exp(rdata,exp_data);

 endtask
////////////////////////////////////////////////////////////
  
  
function void exp(bit [7:0] data,bit [7:0] exp_data);      // function taken from verilog test_bench LAB of memory lab 9..
    
    if (data !== exp_data) begin
      $display("TEST FAILED");
      $display("At time %0d addr=%b data=%b", $time, tb_bus.addr, data);
      $display("data should be %b", exp_data);
      error_status+=1;
      $finish;
    end
   else begin 
   if(debug==1)
    $display("At time %0d addr=%d data=%d", $time, tb_bus.addr, data);
    $display("THE TEST Passed");
   end 
 endfunction
  
//////////////////////////////////////////////////////////////////
// add read_mem and write_mem tasks

// add result print function

endmodule


