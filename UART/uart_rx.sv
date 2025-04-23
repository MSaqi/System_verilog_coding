module uart_rx #(
  parameter PARITY_ON  = 1,
  parameter PARITY_BIT = 0  // 0 EVEN 1 ODD
  ) (
  input  logic        clk         , // Clock
  input  logic        rst_n       , // Asynchronous reset active HIGH
  input  logic        rx          , // RX for reciever
  output reg          rx_done     , // RX_DONE that DATA IS VALID NOW 
  output reg   [31:0] data_out    , // DATA RECIEVD 
  output reg   [ 3:0] parity_error  // PARITY ERROR IF ANY IN ANY BYTE 
  );
  import uart_pkg::*;

  reg   [ 7:0] byte_store ;
  reg   [31:0] rec_dat_reg;
  logic [ 2:0] byte_count ;
  logic [ 3:0] bit_count  ;

  e_fsm_state state;

  always@(posedge clk or negedge rst_n) begin
    /*------------------------------------------------------------------------------
    --  States Sequence
    -- PARITY_ON = 1
    -------------> IDLE -> DATA -> PARITY -> STOP --->|
    |_________________________________________<|
    -- PARITY_ON = 0
    -------------> IDLE -> DATA -> STOP->|
    |____________________________<|
    ------------------------------------------------------------------------------*/
    if(!rst_n) begin
      rx_done      <= 0;
      rec_dat_reg  <= 0;
      byte_store   <= 0;
      byte_count   <= 0;
      bit_count    <= 0;
      state        <= IDLE;
      parity_error <= 0;
    end
    else begin
      case(state)
        IDLE : begin
          if(!rx)begin
            state       <= DATA;
            rec_dat_reg <= rec_dat_reg >> 8;
          end
          else begin
            state <= IDLE;
          end
          rx_done <= 0;
        end
        DATA : begin  // PURE Sequential Block
          byte_store[7] = rx;
          bit_count     = bit_count + 1;
          if(bit_count[3]) begin
            bit_count = 0;
            state     = PARITY_ON ? PARITY : STOP;
          end
          else begin
            byte_store = byte_store >> 1;
          end
        end
        PARITY : begin
          if(!PARITY_BIT)begin //  EVEN Case
            parity_error[byte_count] <= (!(rx == ^byte_store)) ? `HIGH : `LOW;
          end
          else begin  //  ODD case
            parity_error[byte_count] <= (!(rx == ~^byte_store)) ? `HIGH : `LOW;
          end
          rec_dat_reg[31:24] <= byte_store;
          state              <= STOP;
          byte_count         <= byte_count + 1;
        end
        STOP : begin
          state      <= rx ? IDLE : STOP;
          rx_done    <= byte_count[2] ? `HIGH : `LOW;
          byte_count <= byte_count[2] ? 0 : byte_count;
          data_out   <= byte_count[2] ? rec_dat_reg : data_out;
        end
      endcase // status
    end
  end
endmodule