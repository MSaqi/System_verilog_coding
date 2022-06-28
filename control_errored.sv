///////////////////////////////////////////////////////////////////////////
// (c) Copyright 2013 Cadence Design Systems, Inc. All Rights Reserved.
//
// File name   : control.sv
// Title       : Control Module
// Project     : SystemVerilog Training
// Created     : 2013-4-8
// Description : Defines the Control module
// Notes       :
// 
///////////////////////////////////////////////////////////////////////////

// import SystemVerilog package for opcode_t and state_t
`include "type_def.sv"
import typedefs::*;
module control  (
   
                output logic      load_ac ,
                output logic      mem_rd  ,
                output logic      mem_wr  ,
                output logic      inc_pc  ,
                output logic      load_pc ,
                output logic      load_ir ,
                output logic      halt    ,
                input  opcode_t opcode  , // opcode type name must be opcode_t
                input             zero    ,
                input             clk     ,
                input             rst_   
                );
// SystemVerilog: time units and time precision specification
  
  
  //{INST_ADDR=0,INST_FETCH,INST_LOAD,IDLE,OP_ADDR,OP_FETCH,ALU_OP,STORE
timeunit 1ns;
timeprecision 100ps;
states_t lstate;
 
  
  	
		
  always_ff @(posedge clk or posedge rst_)
	begin
      if(rst_)
        begin
        lstate=INST_ADDR;
          mem_rd=1'bx;load_ir=1'bx;halt=1'bx;inc_pc=1'bx;load_ac=1'bx;load_pc=1'bx;mem_wr=1'bx;end
      else
        begin
      		mem_rd=0;load_ir=0;halt=0;inc_pc=0;load_ac=0;load_pc=0;mem_wr=0;
      case (lstate)
		INST_ADDR : ;
        			
        INST_FETCH:  mem_rd=1;
        
        INST_LOAD:  begin mem_rd=1;load_ir=1;end  
        
        IDLE:   begin mem_rd=1;load_ir=1;end 
		OP_ADDR:begin 
          	inc_pc=1;
          if(opcode==HLT)
				begin halt=1;end
        		end
		
		OP_FETCH:begin
			if(opcode==(ADD||AND||XOR||LDA))
				begin mem_rd=1;end
        		end
			 			
		ALU_OP:begin 
			if(opcode==(ADD||AND||XOR||LDA))
				begin mem_rd=1;load_pc=1;end
				
			else if((opcode==SKZ) && (zero==0))
				begin inc_pc=1;end
				
			else if((opcode == SKZ) && (zero==1) )
				begin end   //left to complete the conditions only  can be removed when optimizing
          else if(opcode == JMP)
				begin load_pc=1;end		
		  end
		 STORE: begin
		 	 if(opcode==(ADD||AND||XOR||LDA))
				begin mem_rd=1;load_ac=1;end
			else if (opcode == JMP)
				begin inc_pc=1;load_pc=1;end
			else if (opcode ==STO)
              begin mem_wr=1;end end
		
	endcase 
        end
	end

endmodule



