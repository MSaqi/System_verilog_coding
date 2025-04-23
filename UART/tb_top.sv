

module tb_top ();

  logic [31:0] data_in;
  logic clk,rst_n,start;
  logic tx;
  logic tx_done;
  reg   rx;
  logic rx_done;
  logic [31:0] dat_out;
  logic [3:0] parity_error;


  logic clk;

  initial begin
    clk = 0;
  end

  always #(104000/2) clk = ~clk;// 9600 BUAD RATE 9.6 Khz frequency

  uart uart_1 (
    .clk         (clk         ),
    .rst_n       (rst_n       ),
    .data_in     (data_in     ),
    .start       (start       ),
    .tx_done     (tx_done     ),
    .tx          (tx          ),
    .rx          (rx          ),
    .rx_done     (rx_done     ),
    .dat_out     (dat_out     ),
    .parity_error(parity_error)
  );

  initial begin
    force rx = tx;
  end
  initial begin
    data_in <= 0;
    start <= 0;
    rst_n <= 1;

    clk_repeat(3);

    rst_n <= 0;

    clk_repeat(5);

    rst_n <= 1;

    clk_repeat(1);

    for(int i = 0 ;i < 500 ; i++) begin 
      $write("TEST # %d    ",i);
      data_in <= $urandom_range(0,32'hFFFF_FFFF);
      start <= 1;
      @(posedge clk);
      wait(tx_done);
      $write(" SENT DATA = %h ",data_in);
      start <= 0;  
      wait(rx_done);
      @(posedge clk);
      $write(" ::  RECIEVD DATA = %h \n",dat_out);
      if((dat_out != data_in) || (parity_error != 0))begin 
        $error("EXPECTED DATA = %h WHILE RECIEVED DATA  = %h && PARITY_ERROR = %h",data_in,dat_out,parity_error);
      end 
      clk_repeat(5);
    end 
    $finish();
  end

  task clk_repeat(int a);
    repeat(a)begin
      @(posedge clk); 
    end
  endtask : clk_repeat

endmodule
