//Generates randomized transaction packets and put them in the mailbox to send the packets to driver 
///////////////////////////GENERATOR//////////////////////////////////////

class generator;
  //declare transaction class 
  transaction trans,trans1;
  int repeat_count;
  //create mailbox handle
  mailbox gen2driv;      //one mailbox will be transfered again and again
  //declare an event
  event OK_gen;          //this will be triggered if mail puts all data successfully 	
    bit j;// this will be 1 when gen mail putted to scrboard
    bit i;
  //constructor
    function new(  mailbox gen2driv,  int repeat_count);
      this.gen2driv=gen2driv;
      this.repeat_count=repeat_count;
    endfunction
  //main methods
     task run();
       //$display("###############Generator######################");
       repeat(repeat_count)begin
       trans=new();
        j = trans.randomize; //randomizing the transaction
       trans.hwrite=1;     			 //for writting before reading 
       trans1=new trans;  		  //copyng the transaction
         if (j)begin       		 //if randomization failes  that this will fail and returns error
        gen2driv.put(trans); 	//trans to mailbox
        trans1.hwrite=0;   		//for reading signal altered
        i=gen2driv.try_put(trans1);  //to mail box 
        //trans.display(); //just for debugging purposes
       //   trans1.display();
        end
        if(i)
            -> OK_gen;   //event triggered
        else begin	
        $display ("OK_gen not triggered");
        $display("FATAL::ERROR Line 40  generator.sv gen failed");end
        end
        //$display("####################################");
    endtask:run  
endclass