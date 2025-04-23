interface ibus();
  logic read,write;
  logic [4:0] addr;
  logic [7:0] data_out;      // data_from_mem
  logic [7:0] data_in; 
  modport mem (input read,write,addr,data_in, output data_out );
  modport tb   (output read,write,addr,data_in, input data_out );
endinterface:ibus  
