module memory(clk,reset ,write_enable ,read_enable,data_input ,data_input_i ,data_input_min ,address_input, address_input_i ,address_input_j,address_input_min,data_out,address_out);
    input[1:0] write_enable;
    input[1:0] read_enable;
    input reset,clk;
    input [5:0]data_input,data_input_i,data_input_min;
    input [3:0]address_input, address_input_i ,address_input_j,address_input_min;
    output reg [5:0]data_out;
    output  reg [3:0] address_out;

    reg [5:0] memarr [15:0];
    always@(reset ,write_enable ,read_enable)
        begin
        
        if(reset)
        begin
            memarr[0]=6'b000000;
            memarr[1]=6'b000000;
            memarr[2]=6'b000000;
            memarr[3]=6'b000000;
            memarr[4]=6'b000000;
            memarr[5]=6'b000000;
            memarr[6]=6'b000000;
            memarr[7]=6'b000000;
            memarr[8]=6'b000000;
            memarr[9]=6'b000000;
            memarr[10]=6'b000000;
            memarr[11]=6'b000000;
            memarr[12]=6'b000000;
            memarr[13]=6'b000000;
            memarr[14]=6'b000000;
            memarr[15]=6'b000000;
        end        
        else if(write_enable==2'b01)
        begin
            memarr[address_input]=data_input;
            $display("input fed: %d",memarr[address_input]);
            
        end
        else if(write_enable==2'b10)
        begin
            memarr[address_input_i]=data_input_i;
            
            
            
        end
        else if(write_enable==2'b11)
        begin
            memarr[address_input_min]=data_input_min;
            
        end  
        else if(read_enable==2'b01)
        begin
            data_out=memarr[address_input_i];
            address_out=address_input_i;
            
        end
        else if(read_enable==2'b10)
        begin
            data_out=memarr[address_input_j];
            address_out=address_input_j;
            $display("adddress_input_j: %d memarr[address_input_j]: %d",address_input_j,memarr[address_input_j]);
        end
        else if(read_enable==2'b11)
        begin
            data_out=memarr[address_input_min];
            address_out=address_input_min;
        end 
        
        
        $display("read_enable %d memory read %d",read_enable,data_out);
    end
    
endmodule

module half_add(a,b,s,c); 
  input a,b;
  output s,c; 
  xor x1(s,a,b);
  and a1(c,a,b);
endmodule

module FullAdder(a,b,cin,sum_sum,cout);
  input a,b,cin;
  output sum_sum,cout;
  wire x,y,z;
  half_add h1(.a(a),.b(b),.s(x),.c(y));
  half_add h2(.a(x),.b(cin),.s(sum_sum),.c(z));
  or o1(cout,y,z);
endmodule





module five_bit_Adder(a,b,cin,sum_sum,cout);
input [4:0]a,b;
input cin;
output wire [4:0]sum_sum;
output cout;
wire cout1,cout2,cout3,cout4;
FullAdder FA1(a[0],b[0],cin,sum_sum[0],cout1);
FullAdder FA2(a[1],b[1],cout1,sum_sum[1],cout2);
FullAdder FA3(a[2],b[2],cout2,sum_sum[2],cout3);
FullAdder FA4(a[3],b[3],cout3,sum_sum[3],cout4);
FullAdder FA5(a[4],b[4],cout4,sum_sum[4],cout);
endmodule


module comparator(data,data2,signal);
input [4:0] data,data2;
output signal;
assign signal=data<data2;

endmodule


module fsm(clk,DataValid,compare_i_c,compare_j_c,d1_d2_compare,
mreset,outValid,cClear,cLoad,iClear,iLoad,jLoad,jSelect,jClear,minLoad,minSelect,minClear,mem_write_enable,mem_read_enable,d1Load,d2Load,d3Load);
input clk;
input DataValid;
input compare_i_c,compare_j_c,d1_d2_compare;
output reg mreset,outValid;
output reg cClear,cLoad;
output reg iClear,iLoad;
output reg jLoad,jSelect,jClear;
output reg minLoad,minSelect,minClear;
output reg [1:0] mem_write_enable,mem_read_enable;
output reg d1Load,d2Load,d3Load;


reg [4:0] cstate=0,nstate=0;

always@(posedge clk)
begin
    cstate<=nstate;
    
end

always@(posedge clk)
begin
    
  $display("cstate: %d nstate: %d datavalid: %d d1_d2_compare:%d time %0t \n" ,cstate,nstate,DataValid,compare_i_c, $time);
end
always@(cstate or DataValid)
begin
    case(cstate)
    0: //start state
    begin 
        mreset=1;
        iClear<=1;
        cClear<=1;
        outValid<=0;
        jClear<=1;
        minClear<=1;
        if(DataValid)
        begin
            nstate<=13;
        end
        else
            nstate<=0;
        
    end
      13 :
        begin 
          jClear<=0;
        minClear<=0;
        cLoad<=0;
        cClear<=0;
        mreset<=0;
        iClear<=0;
        iLoad<=0;
          mem_write_enable<=1;
          nstate<=1;
        end
    1: //taking input
    begin
//         jClear<=0;
//         minClear<=0;
//         cLoad<=0;
//         cClear<=0;
//         mreset<=0;
//         iClear<=0;
//         iLoad<=0;
        mem_write_enable<=0;
      //memory mein store ke liye
      if(DataValid)
        begin 
          nstate<=1;
        end
        else 
          begin
             nstate<=17;
          end 
       
    end
      17:
    begin
//         mem_write_enable<=0; 
        cLoad<=1;
        if(DataValid)
        nstate<=13;
        else
        nstate<=2;
    end
    2://begin sorting
    begin
        iClear<=0;
        jClear<=1;
        cLoad<=0;
        mem_write_enable<=0;
        iLoad<=0;
        if(compare_i_c)
        begin
            nstate<=3;
        end        
        else
        begin
            nstate<=15;
        end    
    end
    3:
    begin
        jClear<=0;
        minLoad<=1;
        minSelect<=0;
        jLoad<=1;
        jSelect<=1;
       nstate<=4;

    end
    4:
    begin 
        minLoad<=0;
        jLoad<=0;
        if(compare_j_c)
        nstate<=5;
        else
        nstate<=9; 
    end

    5: //read mem[j]
    begin
        mem_read_enable=2;
        nstate<=6;
        $display("in state 5 trying to read mem[j]");
    end

    6: //read mem[j]
    begin
        mem_read_enable=0;
        d1Load=1;
        nstate<=18;
    end

    18:
    begin
        $display("dataOut value is mem[j]");
        $display("in state 5 trying to read mem[min]");        
        d1Load=0;
        mem_read_enable=3;      
        nstate<=22;
    end

    22:
    begin
        mem_read_enable<=0;
        d2Load<=1;
        nstate<=7;
    end

    7:
    begin
        d2Load<=0;
        $display("dataOut value is mem[min]");
        if(d1_d2_compare)
        begin
            minSelect=1;
            minLoad=1;
        end
        nstate<=8;
    end

    8:
    begin 
        jSelect=0;
        jLoad=1;
        minLoad=0;
        minSelect=0;
        nstate<=4;
    end

    9: //read mem[i]
    begin
        mem_read_enable=1;
        nstate<=10;
    end

    10: //read mem[min]
    begin
        mem_read_enable=0;
        d3Load=1;
        nstate<=23;
    end

    23:
    begin
       d3Load=0;
       mem_read_enable=3; 
       nstate<=24;
    end

    24:
    begin
        mem_read_enable=0;
        d2Load=1;
        nstate<=11;
    end

    11: //memarr[i]=mem[min]
    begin
        d2Load=0;
        mem_read_enable=0;
        nstate<=25;
    end

    25:
    begin
        mem_write_enable=2;
        nstate<=12;    
    end

    12: //memarr[min]=memarr[i]
    begin
        mem_write_enable=3;
        nstate<=20;
    end

    20:
    begin

        iLoad=1;
        mem_write_enable=0;
        
        nstate<=2;
    end
    
    15:
    begin
        outValid=1;
        jClear=0;
        jLoad=0;
        mem_read_enable=2;
        if(compare_j_c)
        begin
        nstate<=16;
        end
        else
        nstate<=0;
    end
    16:
    begin
        jLoad=1;
        mem_read_enable=0;
        jSelect=0;     
        nstate<=15;
    end
    
    default:
    nstate<=0;
    endcase
end
endmodule


module register(input clk,input reset, input load_signal,input [4:0] data_in,output reg [4:0] data_out);
always@(reset or load_signal)
begin
    if(reset)
    data_out=0;
    else if (load_signal)
    data_out=data_in;
    $display("in reg reset:%d load_signal %d data_in %d  data_out %d",reset,load_signal,data_in,data_out);

end

endmodule
module register_i(input clk,input [1:0] reset, input load_signal,input [4:0] data_in,input [4:0] data_in2,output reg [4:0] data_out);
always@(reset or load_signal)
begin
    if(reset==1)
    data_out=0;
    else if (reset==2)
    data_out=data_in;
    else if(reset==3)
    data_out=data_in2;
    else
    data_out=0;
    // $display("in reg_i reset:%d load_signal %d data_in %d data_in2 %d data_out %d",reset,load_signal,data_in,data_in2,data_out);

end

endmodule

module register6(input clk,input reset, input load_signal,input [5:0] data_in,output reg [5:0] data_out);
always@(reset or load_signal)
begin
    if(reset)
    data_out=0;
    else if (load_signal)
    data_out=data_in;
    $display("in reg6  reset:%d  load_signal %d data_in %d data_out %d",reset,load_signal,data_in,data_out);

end
endmodule


module register_select(input clk,input reset, input select_signal, input load_signal,input [4:0] data_in_1, input [4:0] data_in_2, output reg [4:0] data_out);
always@(reset or load_signal or select_signal)
begin
    if(reset)
    data_out=0;
    else if (load_signal)
    begin 
        if(!select_signal) data_out=data_in_1;
        else data_out=data_in_2;
    end
     $display("in reg_select reset:%d select_signal %d load_signal %d data_in %d data_in2 %d data_out %d",reset,select_signal,load_signal,data_in_1,data_in_2,data_out);
end
endmodule

module  Sort(clk,wAddress, DataIn, dataValid, outValid, outAddress, dataOut,c);
input clk;
input [3:0]wAddress;//address where dataIn to be written  
input [5:0] DataIn; //data to be written at wAddress location 
input dataValid; //will be on when we want to write input data to the memory 
output outValid; //is 1 when sorting is done and valid data is showing at output 
output [3:0] outAddress; //address corresponding to dataOut 
output [5:0] dataOut; 
output [4:0] c;//output data corresponding to outAddress location.

wire [4:0] i,j,min;
//assign i=0;

wire [4:0] i_plus_1,j_plus_1,c_plus_1,i_plus_0;
wire i_carry,j_carry,c_carry,i_carry2;
wire compare_i_c,compare_j_c,d1_d2_compare;
wire mreset;
wire cClear,cLoad;
wire iClear;
wire iLoad;
wire jLoad,jSelect,jClear;
wire minLoad,minSelect,minClear;
wire [1:0] mem_write_enable,mem_read_enable;
wire d1Load,d2Load,d3Load;
wire [5:0] d1Out,d2Out,d3Out;


always@(*)
begin
$display("j:%d i: %d min %d   c %d",j,i,min,c);
$display("d1Out:%d d2Out: %d   d3Out %d",d1Out,d2Out,d3Out);
end


five_bit_Adder iAdder(.a(i),
                   .b(1),
                   .cin(0),
                   .sum_sum(i_plus_1),
                   .cout(i_carry));
five_bit_Adder iAdder2(.a(i),
                   .b(0),
                   .cin(0),
                   .sum_sum(i_plus_0),
                   .cout(i_carry2));                   
five_bit_Adder jAdder(.a(j),
                   .b(1),
                   .cin(0),
                   .sum_sum(j_plus_1),
                   .cout(j_carry));
five_bit_Adder cAdder(.a(c),
                   .b(1),
                   .cin(0),
                   .sum_sum(c_plus_1),
                   .cout(c_carry));

register counter(.clk(clk),.reset(cClear),
           .load_signal(cLoad),
           .data_in(c_plus_1),
           .data_out(c));
register i_reg(.clk(clk),.reset(iClear),
           .load_signal(iLoad), 
           .data_in(i_plus_1),
           
           .data_out(i));


register_select j_reg(.reset(jClear),
                  .select_signal(jSelect),
                  .load_signal(jLoad), 
                  .data_in_1(j_plus_1),
                  .data_in_2(i_plus_1),
                  .data_out(j));

register_select min_reg(.reset(minClear),
                  .select_signal(minSelect),
                  .load_signal(minLoad), 
                  .data_in_1(i),
                  .data_in_2(j),
                  .data_out(min));

comparator comp_iplus1_c(i_plus_1,c,compare_i_c); // add this compare_i_c in input of fsm
comparator comp_j_c(j,c,compare_j_c); // add this compare_j_c in input of fsm
comparator d1_d2(d1Out,d2Out,d1_d2_compare);//give input to fsm

memory MEM(.clk(clk),.reset(mreset),
            .write_enable(mem_write_enable),
            .read_enable(mem_read_enable),
            .data_input(DataIn),
            .data_input_i(d2Out),
            .data_input_min(d3Out),
            .address_input(wAddress),
            .address_input_i(i),
            .address_input_j(j),
            .address_input_min(min), 
            .data_out(dataOut),
            .address_out(outAddress));
//reading mem[j]  
register6 d1(.clk(clk),.reset(0),
             .load_signal(d1Load), 
                  .data_in(dataOut),
                  .data_out(d1Out)
                  );
//reading mem[min]                  
register6 d2(.clk(clk),.reset(0),
             .load_signal(d2Load), 
                  .data_in(dataOut),
                  .data_out(d2Out)
                  );
//reading mem[i]                  
register6 d3(.clk(clk),.reset(0),
             .load_signal(d3Load), 
                  .data_in(dataOut),
                  .data_out(d3Out)
                  );
//always@(posedge clk)
//// $display("data_out %d min %d",dataOut,min);
//$display("outValid %d dataOut %d",outValid,dataOut);
fsm FSM(.clk(clk),
    .DataValid(dataValid),
    .compare_i_c(compare_i_c),
    .compare_j_c(compare_j_c),
    .d1_d2_compare(d1_d2_compare),
    .mreset(mreset),
    .outValid(outValid),
    .cClear(cClear),
    .cLoad(cLoad),
    .iClear(iClear),
    .iLoad(iLoad),
    .jLoad(jLoad),
    .jSelect(jSelect),
    .jClear(jClear),
    .minLoad(minLoad),
    .minSelect(minSelect),
    .minClear(minClear),
    .mem_write_enable(mem_write_enable),
    .mem_read_enable(mem_read_enable),
    .d1Load(d1Load),
    .d2Load(d2Load),
    .d3Load(d3Load));
endmodule