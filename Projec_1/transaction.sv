//Fields required to generate the stimulus are declared in the transaction class
///////////////////////////TRANSACTION//////////////////////////////////////

class transaction;
  parameter AW =`AW;   // address bus width
  parameter DW =`DW;  // data bus width
  parameter DE =`DE;    // endianess
  parameter RW =`RW;
  //declare transaction items
  ////excluding the hwrite signal so that it would be configured after wards in the different sections// Transfer direction    // for writting first then reading all the data 
  rand bit [DW-1:0] hwdata;
  bit [DW-1:0] hrdata;   // Read data bus
  bit           hready;   // Transfer done
  bit  [RW-1:0] hresp;    // Transfer response
  rand bit [2:0] hsize;    //randomness removed in constraints
  rand bit [2:0] hburst;    //
  rand bit [3:0] hprot;
  randc bit  [AW-1:0] haddr;            
  rand bit    [1:0] htrans;  
  bit hwrite;
//////////////////////////////////////////////////////////////
  //Add Constraints

 constraint c1 {htrans == 2;}     //only non seq transfer
 constraint c2 {hsize inside {2};} //  32 bit size 
  constraint c3 {if(hsize==1)haddr%2==0;             
                else if(hsize==2)haddr%4==0;
                 else haddr%1==0;}   // for allignmetn of data adress
  constraint c4 {haddr<=1023;}      // to make the addrersses under 1024
  constraint c5 {hwdata<=255;}   //to make data under 8bits
  constraint c6 {hprot == 4'b0001;}     // protetion set according to 
  constraint c7 {hburst == 0;}   //single burst data 
  
  //Add print transaction method(optional)
  function void display;
    $display("Transaction  haddr= %d ,htrans= %d ,hwrite= %d , hsize= %d ,hburst= %d ,hprot= %d ,hwdata= %d ,hrdata= %d , hready= %d ,hresp= %d ",haddr,htrans,hwrite,hsize,hburst,hprot,hwdata,hrdata,hready,hresp);
  endfunction
   
endclass
