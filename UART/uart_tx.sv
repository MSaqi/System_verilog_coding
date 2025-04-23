/*------------------------------------------------------------------------------
--  TX transaction FLOW START WOrks on TOggle only IF TX_ASSERTED we need to  
START _________
_____|         |____  2 cycles to actually start the TX for SLave from TX module
      ____      ____      ____      ____
CLK  |    |____|    |____|    |____|    |___
------------------------------------------------------------------------------*/
module uart_tx #(
  parameter PARITY_ON  = 1,
  parameter PARITY_BIT = 0
  ) (
  input  logic        clk, rst_n, start,
  input  logic [31:0] data_in,
  output reg          tx     ,
  output reg          tx_done
  );
  /*------------------------------------------------------------------------------
  --  PACKAGE IMPORT
  ------------------------------------------------------------------------------*/
  import uart_pkg::*;
  /*------------------------------------------------------------------------------
  --  Internal Registers
  ------------------------------------------------------------------------------*/
  reg [31:0] data_to_send      ;
  reg [ 7:0] shift_reg         ;
  reg [ 2:0] byte_count        ;
  reg [ 3:0] tx_dat_bit_count  ;
  reg [ 7:0] byte_for_prity_gen;
  /*------------------------------------------------------------------------------
  --  State Register Enum
  ------------------------------------------------------------------------------*/
  e_fsm_state state;
  /*------------------------------------------------------------------------------
  --  Assign Statement
  ------------------------------------------------------------------------------*/
  assign data_to_send = data_in;
  /*------------------------------------------------------------------------------
  --  Main Module Logic
  ------------------------------------------------------------------------------*/
  always_ff@(posedge clk or negedge rst_n)begin
    /*------------------------------------------------------------------------------
    --  States Sequence
    -- PARITY_ON = 1
    -------------> IDLE -> START -> DATA -> PARITY -> STOP --->|
    |_________________________________________<|
    -- PARITY_ON = 0
    -------------> IDLE -> START -> DATA -> STOP->|
    |____________________________<|
    ------------------------------------------------------------------------------*/
    if(!rst_n) begin
      tx               <= `HIGH;
      shift_reg        <= `LOW;
      state            <= IDLE;
      byte_count       <= `LOW;
      tx_dat_bit_count <= `LOW;
      tx_done          <= `LOW;
      state            <= IDLE;
    end
    else begin
      case(state)
        IDLE : begin
          if(start && !byte_count[2]) begin
            shift_reg  <= data_to_send >> byte_count*8;
            state      <= START;
            byte_count <= byte_count + 1;
            byte_for_prity_gen <= data_to_send >> byte_count*8;
          end
          else begin
            state         <= IDLE;
            byte_count[2] <= 0;
          end
          tx_done    <= 0;
        end// : IDLE
        START : begin
          tx    <= 0;
          state <= DATA;
        end// : START
        DATA : begin
          tx               <= shift_reg[0];
          shift_reg        = shift_reg >> 1;
          tx_dat_bit_count = tx_dat_bit_count + 1;
          if(tx_dat_bit_count[3]) begin
            state               <= PARITY_ON ? PARITY:STOP;
            tx_dat_bit_count[3] = 0;
          end
        end// : DATA
        PARITY : begin
          tx    <= PARITY_BIT ? ~^byte_for_prity_gen : ^byte_for_prity_gen;
          state <= STOP;
        end// : PARITY
        STOP : begin
          tx    <= 1;
          state = IDLE;
          if(!byte_count[2]) begin
            tx_done <= 0;
            byte_count <= byte_count;
          end
          else begin
            tx_done <= 1;
            byte_count <= 0;
          end
        end// : STOP
      endcase // state
    end
  end
endmodule
