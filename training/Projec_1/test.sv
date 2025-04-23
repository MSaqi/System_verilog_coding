//A program block that creates the environment and initiate the stimulus
`include"environment.sv"
program test(dut_if vi1);
  
  //declare environment handle
  environment env;
  initial begin
    //create environment
    env=new(vi1,2);
    //initiate the stimulus by calling run of env
    env.run();	
  end

endprogram
