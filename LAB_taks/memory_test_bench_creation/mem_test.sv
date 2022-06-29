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

module mem_test ( input logic clk, 
                  output logic read, 
                  output logic write, 
                  output logic [4:0] addr, 
                  output logic [7:0] data_in,     // data TO memory
                  input  wire [7:0] data_out     // data FROM memory
                );
// SYSTEMVERILOG: timeunit and timeprecision specification
timeunit 1ns;
timeprecision 1ns;

// SYSTEMVERILOG: new data types - bit ,logic
bit         debug = 1;
logic [7:0] rdata;      // stores data read from memory for checking



//



task expect ;
    input [7:0] exp_data;
    if (data !== exp_data) begin
      $display("TEST FAILED");
      $display("At time %0d addr=%b data=%b", $time, addr, data);
      $display("data should be %b", exp_data);
      $finish;
    end
   else begin 
      $display("At time %0d addr=%b data=%b", $time, addr, data);
   end 
  endtask
  
  
// Monitor Results
  initial begin
      $timeformat ( -9, 0, " ns", 9 );
// SYSTEMVERILOG: Time Literals
      #40000ns $display ( "MEMORY TEST TIMEOUT" );
      $finish;
    end

initial
  begin: memtest
  int error_status;

    $display("Clear Memory Test");

    for (int i = 0; i< 32; i++)
    		write_0(int i)
       // Write zero data to every address location

    for (int i = 0; i<32; i++)
      begin 
       // Read every address location
	read_mem(int i)
       // check each memory location for data = 'h00

      end

   // print results of test

    $display("Data = Address Test");

    for (int i = 0; i< 32; i++)
       // Write data = address to every address location
       
       
    for (int i = 0; i<32; i++)
      begin
       // Read every address location

       // check each memory location for data = address

      end

   // print results of test

    $finish;
  end
  
  //functions
  task void write_0(int x);
  begin 
      addr=x; data=0;
    $display("Writing addr=%b data=%b",addr,data);
    wr=1; rd=0; mem_test.addr=addr; rdata=data; @(negedge clk);
  end
  endtask


function read_mem(int x);
begin
	addr=x; data=-1;
    $display("Reading addr=%b data=%b",addr,data);
    wr=0; rd=1; memory_test.addr=addr; rdata='bz; @(negedge clk) expect(data , exp_data='0);
end
endfunction


// add read_mem and write_mem tasks

// add result print function

endmodule
