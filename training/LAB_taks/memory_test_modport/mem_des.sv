///////////////////////////////////////////////////////////////////////////
// (c) Copyright 2013 Cadence Design Systems, Inc. All Rights Reserved.
//
// File name   : mem.sv
// Title       : Memory Module
// Project     : SystemVerilog Training
// Created     : 2013-4-8
// Description : Defines the memory module
// Notes       :
// Synchronous 8x32 Memory Design
// Specification:
//  Memory is 8-bits wide and address range is 0 to 31.
//  Memory access is synchronous.
//  Write data into the memory on posedge of clk when write=1
//  Place memory[addr] onto data bus on posedge of clk when read=1
//  The read and write signals should not be simultaneously high.
// 
///////////////////////////////////////////////////////////////////////////

module mem (input clk,ibus.mem bus_mem);
// SYSTEMVERILOG: timeunit and timeprecision specification
timeunit 1ns;
timeprecision 1ns;
// SYSTEMVERILOG: logic data type
logic [7:0] memory [0:31] ;
  
  always @(posedge clk)
    if (bus_mem.write && !bus_mem.read)
// SYSTEMVERILOG: time literals
      #1 memory[bus_mem.addr] <= bus_mem.data_in;

// SYSTEMVERILOG: always_ff and iff event control
  always_ff @(posedge clk iff ((bus_mem.read == '1)&&(bus_mem.write == '0)) )
    bus_mem.data_out <= memory[bus_mem.addr];

endmodule


