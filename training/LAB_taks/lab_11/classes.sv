//classes definition ////

class counter ;
//static int count;   // for up and down counter lab task
int count;
int max;
int min;



//function  NEW 
function new (int countr,int a,int b);
    //count=countr;
    if(a==b)begin
        $display("min and max equal to each other ERROR");
        $finish;end
    else if(a>b)begin
        max=a;
        min=b;end
    else begin
        max=b;
        min=a; end

    if((countr>max)&&(countr<min))
        begin count=min;$display("you have given the wrong range count initialized with min");end 
    else
        count=countr;
endfunction:new  
//////////////////funciton limit .//////
/*function void check_limit(int a.int b);
if(a==b)
$display("min and max equal to each other ERROR");
else if(a>b)begin
max=a;
min=b;end
else begin
max=b;
min=a; end
endfunction:check_limit*/
//function //SETTER 
function void load(int i);
    count=i;
endfunction:load
//FUCNITON getter ////
function int getcount();
   if(debug==1)begin $display("COUNT returned == %d",this.count);end
    return count;
endfunction:getcount
endclass:counter 


class upcounter extends counter;
bit carry=0;
function new(int i,int a,int b);
    super.new(i,a,b);
    if(debug==1)begin $display("new instance created");end
endfunction:new 

function void getall;
$display("count = %d , max = %d , min = %d ",this.count,this.max,this.min);
endfunction

function void next;
 if(debug==1)$display("count incremented");
 if(this.count==1) this.carry=0;
 if((this.count>=this.min)&&(this.count<this.max))begin
    this.count=this.count+1;end
 else
   begin $display("WARNING :: count out of range so count set to min");
   this.count=this.min;this.carry=1;end 

endfunction:next

/*function int carry_check;
if(this.carry==1)
return 1;
else return 0;
endfunction*/


endclass:upcounter

/*class downcounter extends counter;
bit borrow=0;

function void getall;
$display("count = %d , max = %d , min = %d , carry =%d  ",this.count,this.max,this.min,this.borrow);
endfunction

function new(int i,int a,int b);
  super.new(i,a,b);
  if(debug==1)begin $display("count added in instance");end
  this.count=count;
endfunction

function void next;
    if((count>=min)&&(count<=max))begin
    count=count-1;end
    else if(count<min)begin
      if(debug==1) $display("count reset to max");
    count=max;borrow=1;end
    else
    begin $display("count out of range so count set to min");
    count=min;end 
    if(debug==1)begin $display("counter decremented");end
endfunction    
endclass:downcounter*/

class timer;
upcounter hrs,mins,sec;
function new ();
 hrs=new(0,0,24);
 mins=new(0,0,60);
 sec=new(0,0,60);
endfunction

function void load(int a,int b, int c);
 hrs.count=a;
 mins.count=b;
 sec.count=c;
endfunction

function void display;
$display("CUrrent time :: %d hrs:%d min:%d sec",hrs.getcount(),mins.getcount(),sec.getcount());
endfunction

function void dispall;
hrs.getall();
mins.getall();
sec.getall();
endfunction

function void next;
sec.next();
$display("you are upcounting the sec");
if(sec.carry==1)begin
mins.next();$display("mins added");end
if(mins.carry==1)begin
hrs.count=hrs.count+1;$display("hrs added added");end
endfunction


endclass:timer



