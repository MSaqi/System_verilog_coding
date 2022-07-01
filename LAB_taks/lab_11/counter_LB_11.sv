`timescale 1ns/100ps
module top;

bit debug =0;

  //classes definition ////
  `include"classes.sv"
    counter a,b;
    upcounter up;
    //downcounter dn;
    int c;
    int e;
    timer time1;
    initial
    begin
        /*
      b=new(4);
      $display("simulation started");
      a = new(3);
      c = a.getcount();
      b.load(5);
      c = b.getcount();
      //c = add(a.count,b.count);
      $display("counter class obj b returned to c c=%d b==%d ",c,b.count);
      /*
      dn=new(1);
      up=new(1);
      c=dn.getcount();
      dn.next();
      c=dn.getcount();
      $display("the downcount obj.count  is c=%d  after dn count == %d ",c,dn.count);
      up.next();
      e=up.getcount();
      $display(" the upcount obj.count is c=%b  after up count == %d ",e,up.count);
      $display(" the downcount obj.count is c=%d  after dn count == %d ",c,dn.count);
      up.next();
      up.next();
      dn.next();
      dn.next();
      $display(" the upcount obj.count is c=%d  after up count == %d  down count == %d ",e,up.count,dn.count);   
        */
/*      up=new(5,1,60);  /// (count value , max_vale ,min value)
      dn=new(5,1,60);
      for (int i =1;i<=65;i++)    
        up.next();
       
      $display(" the downcount obj.count up.count = %d",up.count);
      $display(" it must be 1 if all went as expected up.carry = %b",up.carry);
      for (int i =1;i<=80;i++)
        dn.next();
      
      $display(" the downcount obj.count up.count = %d",dn.count);
      $display(" it must be 1 if all went as expected dn.borrow = %b",dn.borrow);
*/
      time1=new();
      time1.display();
      time1.load(0,0,59);
      time1.display();
      time1.dispall();
      time1.next();
      time1.next();
      time1.dispall();
      time1.display;
      




    end

 endmodule      