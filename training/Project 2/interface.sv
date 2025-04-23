//modport mon(//Interface groups the design signals, specifies the direction (Modport) and Synchronize the signals(Clocking Block)

interface dut_if#( parameter AW =`AW,    // address bus width
  parameter DW =`DW,    // data bus width
  parameter DE = `DE,    // endianess
                  parameter RW =`RW    )(input bit hclk ,hresetn);
    // Add design signals here
  // AMBA AHB decoder signal
  // AMBA AHB master signals
  logic  [AW-1:0] haddr;    // Address bus
  logic   [1:0] htrans;   // Transfer type
  logic   hwrite;   // Transfer direction
  logic    [2:0] hsize;    // Transfer size
  logic     [2:0] hburst;   // Burst type
  logic    [3:0] hprot;    // Protection control
  logic  [DW-1:0] hwdata;   // Write data bus
  // AMBA AHB slave signals
  logic  [DW-1:0] hrdata;   // Read data bus
  logic        hready;   // Transfer done
  logic   [RW-1:0] hresp;    // Transfer response
  // slave control signal
  wor  error;     // request an error response
    
  
  
    //Master Clocking block - used for Drivers                    //clocking for monitor so that we can acatually configure the timming of the block.
    clocking drv_cb @(posedge hclk);
    default input #1 output #1;
    output haddr;      //bus width addr
    output htrans;     // transfer type
    output hwrite;     //write signal
    output  hsize;     
    output hburst;
    output hprot;   // type of protection
    output hwdata;  // data writting bus
    input hrdata;   //read data from the DUT
    input hready;   
    input hresp;
    output error;         //requesting a response 
  endclocking
    //Monitor Clocking block - For sampling by monitor components
  clocking mon_cb @(posedge hclk);
    default input #1 output #1;    // signal timing settings   as such it wll get the data after 1ns delay
    input haddr;
    input htrans;
    input hwrite;
    input  hsize;        // all signals same as above.
    input hburst;
    input hprot;
    input hwdata;
    input hrdata;
    input hready;
    input hresp;
    input error; 
  endclocking
    //Add modports here
  modport drv(clocking drv_cb,input hclk,hresetn);
  modport mon(clocking mon_cb ,input  hclk, hresetn );
endinterface