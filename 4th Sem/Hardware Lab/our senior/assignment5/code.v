module ADDER (
  input wire [14:0] a,
  input wire [14:0] b,
  input wire subtract,  // Control input: 0 for addition, 1 for subtraction
  output wire [14:0] sum
);

assign sum = (subtract == 1) ? (a - b) : (a + b);


endmodule

module multiplier(
    input wire [14:0] a,
    input wire [14:0] b,
    output wire [14:0] c
);
    assign c=a*b;
    
endmodule

module mux8v1(
    input wire [14:0] input_data1,
    input wire [14:0] input_data2,
    input wire [14:0] input_data3,
    input wire [14:0] input_data4,
    input wire [14:0] input_data5,
    input wire [14:0] input_data6,
    input wire [14:0] input_data7,
    input wire [14:0] input_data8,
    input wire [2:0] select,      
    output reg [14:0] out
);      
    always @* begin
        case (select)
            3'b000: out = input_data1;
            3'b001: out = input_data2;
            3'b010: out = input_data3;
            3'b011: out = input_data4;   
            3'b100: out = input_data5;
            3'b101: out = input_data6;
            3'b110: out = input_data7;
            3'b111: out = input_data8;
            default: out = 15'b0; // Default case
        endcase
    end
endmodule

module mux4v1(
    input wire [14:0] input_data1,
    input wire [14:0] input_data2,
    input wire [14:0] input_data3,
    input wire [14:0] input_data4,
    input wire [1:0] select,      
    output reg [14:0] out
);
    always @* begin
        case (select)
            2'b00: out = input_data1;
            2'b01: out = input_data2;
            2'b10: out = input_data3;
            2'b11: out = input_data4;   
            default: out = 15'b0; // Default case
        endcase
    end
endmodule

module comparing(
    input wire [14:0] a,
    input wire [14:0] b,
    output wire out
);
    assign out = a<b;
    
endmodule

module register15i(
    output reg [14:0] out,
    input [14:0] in,
    input clock,writing_enable
);
    always @(posedge clock)
        if(writing_enable)
            out<=in;
endmodule

module register15(
    output reg [14:0] out,
    input [14:0] mul1,
    input [14:0] mul2,
    input [14:0] add1,
    input [14:0] add2,
    input clock,writing_enable,
    input [1:0] select
);
    always @(posedge clock)
        if(writing_enable)
            begin
                case(select)
                    2'b00: out<=mul1;
                    2'b01: out<=mul2;
                    2'b10: out<=add1;
                    2'b11: out<=add2;
                endcase
            end
endmodule



module finite_state_machine(
    input clk,
    input ready,
    input comparingarator,
    output reg [1:0] multSelect,
    output reg [2:0] addSelect,
    output reg sub1,
    output reg sub2,
    output reg [1:0] regSelect_op1,
    output reg [1:0] regSelect_op2,
    output reg [1:0] regSelect_op3,
    output reg [1:0] regSelect_op4,
    output reg [1:0] regSelect_op5,
    output reg [1:0] regSelect_op6,
    output reg [1:0] regSelect_op7,
    output reg [1:0] regSelect_op8,
    output reg [1:0] regSelect_op11,
    output reg [1:0] regSelect_o1,
    output reg [1:0] regSelect_o2,
    output reg [1:0] regSelect_o3,
    output reg [1:0] regSelect_o4,
    output reg [1:0] regSelect_out,
    output reg regEnable1,
    output reg regEnable2,
    output reg regEnable3,
    output reg regEnable4,
    output reg regEnable5,
    output reg regEnable6,
    output reg regEnable7,
    output reg regEnable8,
    output reg regEnable11,
    output reg finalEnable1,
    output reg finalEnable2,
    output reg finalEnable3,
    output reg finalEnable4,
    output reg finalEnableut,
    output reg valid
);
    reg [3:0] current_state=4'b0000;
    reg [3:0] next_state;
    always @(posedge clk)
    begin
        current_state<=next_state;
        $display("[%t] State: %b", $time, next_state);
    end
    
    always @(current_state,ready)
        case(current_state)
            4'b0000 : begin 
                valid=0;
                regEnable1 = 0;
                regEnable2 = 0;
                regEnable3 = 0;
                regEnable4 = 0;
                regEnable5 = 0;
                regEnable6 = 0;
                regEnable7 = 0;
                regEnable8 = 0;
                regEnable11 = 0;
                finalEnable1 = 0;
                finalEnable2 = 0;
                finalEnable3 = 0;
                finalEnable4 = 0;
                finalEnableut = 0;
                if(ready) next_state<=4'b0001;
                if(!ready) next_state<=4'b0000;
            end
            4'b0001 : begin 
                regEnable1 = 1;
                regEnable2 = 1;
                regEnable3 = 0;
                regEnable4 = 0;
                regEnable5 = 0;
                regEnable6 = 0;
                regEnable7 = 0;
                regEnable8 = 0;
                regEnable11 = 0;
                finalEnable1 = 0;
                finalEnable2 = 0;
                finalEnable3 = 0;
                finalEnable4 = 0;
                finalEnableut = 0;
                regSelect_op1 = 2'b00;
                regSelect_op2 = 2'b01;
                next_state<=4'b0010;
                multSelect=2'b00;
            end
            4'b0010 : begin
                regEnable1 = 0;
                regEnable2 = 0;
                regEnable3 = 1;
                regEnable4 = 1;
                regEnable5 = 0;
                regEnable6 = 0;
                regEnable7 = 0;
                regEnable8 = 0;
                regEnable11 = 0;
                finalEnable1 = 0;
                finalEnable2 = 0;
                finalEnable3 = 1;
                finalEnable4 = 0;
                finalEnableut = 0;
                regSelect_op3 = 2'b00;
                regSelect_op4 = 2'b01;
                regSelect_o3 = 2'b10;
                next_state<=4'b0011;
                multSelect=2'b01;
                addSelect=3'b000;
                sub1=0;
                sub2=0;
            end
            4'b0011 : begin 
                regEnable1 = 0;
                regEnable2 = 1;
                regEnable3 = 0;
                regEnable4 = 0;
                regEnable5 = 1;
                regEnable6 = 0;
                regEnable7 = 0;
                regEnable8 = 0;
                regEnable11 = 0;
                finalEnable1 = 0;
                finalEnable2 = 0;
                finalEnable3 = 0;
                finalEnable4 = 1;
                finalEnableut = 0;
                regSelect_op2 = 2'b00;
                regSelect_op5 = 2'b01;
                regSelect_o4 = 2'b10;
                multSelect=2'b10;
                addSelect=3'b001;
                sub1=0;
                sub2=0;
                if(!comparingarator) next_state<=4'b0100;
                if(comparingarator) next_state<=4'b0101;
            end
            4'b0100 : begin 
                regEnable1 = 0;
                regEnable2 = 0;
                regEnable3 = 0;
                regEnable4 = 0;
                regEnable5 = 1;
                regEnable6 = 1;
                regEnable7 = 0;
                regEnable8 = 0;
                regEnable11 = 0;
                finalEnable1 = 0;
                finalEnable2 = 0;
                finalEnable3 = 0;
                finalEnable4 = 0;
                finalEnableut = 0;
                regSelect_op5 = 2'b10;
                regSelect_op6 = 2'b11;
                next_state<=4'b0110;
                addSelect=3'b010;
                sub1=0;
                sub2=1;
            end
            4'b0101 : begin 
                regEnable1 = 0;
                regEnable2 = 0;
                regEnable3 = 0;
                regEnable4 = 0;
                regEnable5 = 0;
                regEnable6 = 1;
                regEnable7 = 0;
                regEnable8 = 0;
                regEnable11 = 0;
                finalEnable1 = 0;
                finalEnable2 = 0;
                finalEnable3 = 0;
                finalEnable4 = 0;
                finalEnableut = 0;
                regSelect_op6 = 2'b10;
                next_state<=4'b0110;
                addSelect=3'b011;
                sub1=1;
                sub2=0;
            end
            4'b0110 : begin 
                regEnable1 = 0;
                regEnable2 = 0;
                regEnable3 = 0;
                regEnable4 = 0;
                regEnable5 = 0;
                regEnable6 = 0;
                regEnable7 = 1;
                regEnable8 = 1;
                regEnable11 = 1;
                finalEnable1 = 0;
                finalEnable2 = 0;
                finalEnable3 = 0;
                finalEnable4 = 0;
                finalEnableut = 1;
                regSelect_op7 = 2'b00;
                regSelect_op8 = 2'b01;
                regSelect_op11 = 2'b10;
                regSelect_out = 2'b11;
                next_state<=4'b0111;
                multSelect=2'b11;
                addSelect=3'b100;
                sub1=0;
                sub2=0;
            end
            4'b0111 : begin 
                regEnable1 = 0;
                regEnable2 = 0;
                regEnable3 = 0;
                regEnable4 = 0;
                regEnable5 = 0;
                regEnable6 = 0;
                regEnable7 = 0;
                regEnable8 = 0;
                regEnable11 = 0;
                finalEnable1 = 1;
                finalEnable2 = 1;
                finalEnable3 = 0;
                finalEnable4 = 0;
                finalEnableut = 0;
                regSelect_o1 = 2'b10;
                regSelect_o2 = 2'b11;
                next_state<=4'b1000;
                addSelect = 3'b101;
                sub1 = 0;
                sub2 = 0;
            end
            4'b1000 : begin 
                regEnable1 = 0;
                regEnable2 = 1;
                regEnable3 = 0;
                regEnable4 = 0;
                regEnable5 = 0;
                regEnable6 = 0;
                regEnable7 = 0;
                regEnable8 = 0;
                regEnable11 = 0;
                finalEnable1 = 0;
                finalEnable2 = 0;
                finalEnable3 = 0;
                finalEnable4 = 0;
                finalEnableut = 0;
                regSelect_op2 = 2'b10;
                next_state<=4'b1001;
                addSelect=3'b110;
                sub1=0;
                sub2=0;
            end
            4'b1001 : begin 
                regEnable1 = 0;
                regEnable2 = 0;
                regEnable3 = 0;
                regEnable4 = 0;
                regEnable5 = 0;
                regEnable6 = 0;
                regEnable7 = 0;
                regEnable8 = 0;
                regEnable11 = 0;
                finalEnable1 = 0;
                finalEnable2 = 0;
                finalEnable3 = 0;
                finalEnable4 = 0;
                finalEnableut = 1;
                regSelect_out = 2'b11;
                next_state<=4'b1010;
                addSelect=3'b111;
                sub1=0;
                sub2=0;
            end
            4'b1010 : begin
                regEnable1 = 0;
                regEnable2 = 0;
                regEnable3 = 0;
                regEnable4 = 0;
                regEnable5 = 0;
                regEnable6 = 0;
                regEnable7 = 0;
                regEnable8 = 0;
                regEnable11 = 0;
                finalEnable1 = 0;
                finalEnable2 = 0;
                finalEnable3 = 0;
                finalEnable4 = 0;
                finalEnableut = 0; 
                valid=1;
                if(ready) next_state<=4'b1010; 
                if(!ready) next_state<=4'b0000;
            end
            default : begin
                next_state<=4'b1010;
            end
    endcase
endmodule


module finalDesign(
    input clock,ready,s1,s2,s3,s4,
    input [3:0] in,
    output [14:0] outta,
    output valid
);

// input taken
wire [14:0] i1out,i2out,i3out,i4out;

register15i i1(.out(i1out),.in({11'b00000000000,in}),.clock(clock),.writing_enable(s1 & (~s2) & (~s3) & (~s4) &(~ready))),
          i2(.out(i2out),.in({11'b00000000000,in}),.clock(clock),.writing_enable((~s1) & s2 & (~s3) & (~s4) &(~ready))),
          i3(.out(i3out),.in({11'b00000000000,in}),.clock(clock),.writing_enable((~s1) & (~s2) & s3 & (~s4) &(~ready))),
          i4(.out(i4out),.in({11'b00000000000,in}),.clock(clock),.writing_enable((~s1) & (~s2) & (~s3) & s4 &(~ready)));

// internal registers
wire [14:0] op1out,op2out,op3out,op4out,op5out,op6out,op11out,o2out,o3out,o4out,op7out,op8out,o1out,outout;
wire [14:0] op1in1,op2in1,op3in1,op4in1,op5in1,op6in1,op11in1,o2in1,o3in1,o4in1,op7in1,op8in1,o1in1,outin1;
wire [14:0] op1in2,op2in2,op3in2,op4in2,op5in2,op6in2,op11in2,o2in2,o3in2,o4in2,op7in2,op8in2,o1in2,outin2;
wire [14:0] op1in3,op2in3,op3in3,op4in3,op5in3,op6in3,op11in3,o2in3,o3in3,o4in3,op7in3,op8in3,o1in3,outin3;
wire [14:0] op1in4,op2in4,op3in4,op4in4,op5in4,op6in4,op11in4,o2in4,o3in4,o4in4,op7in4,op8in4,o1in4,outin4;
wire op1load,op2load,op3load,op4load,op5load,op6load,op11load,o2load,o3load,o4load,op7load,op8load,o1load,outload;

wire [1:0] op1select,op2select,op3select,op4select,op5select,op6select,op11select,o2select,o3select,o4select,op7select,op8select,o1select,outselect;
wire [14:0] mul1awire,mul1bwire,mul1owire,mul2awire,mul2bwire,mul2owire;
wire [14:0] add1awire,add1bwire,add1owire,add2awire,add2bwire,add2owire;


register15 op1(.out(op1out),.mul1(mul1owire),.mul2(mul2owire),.add1(add1owire),.add2(add2owire),.clock(clock),.writing_enable(op1load),.select(op1select)),
           op2(.out(op2out),.mul1(mul1owire),.mul2(mul2owire),.add1(add1owire),.add2(add2owire),.clock(clock),.writing_enable(op2load),.select(op2select)),
           op3(.out(op3out),.mul1(mul1owire),.mul2(mul2owire),.add1(add1owire),.add2(add2owire),.clock(clock),.writing_enable(op3load),.select(op3select)),
           op4(.out(op4out),.mul1(mul1owire),.mul2(mul2owire),.add1(add1owire),.add2(add2owire),.clock(clock),.writing_enable(op4load),.select(op4select)),
           op5(.out(op5out),.mul1(mul1owire),.mul2(mul2owire),.add1(add1owire),.add2(add2owire),.clock(clock),.writing_enable(op5load),.select(op5select)),
           op6(.out(op6out),.mul1(mul1owire),.mul2(mul2owire),.add1(add1owire),.add2(add2owire),.clock(clock),.writing_enable(op6load),.select(op6select)),
           op7(.out(op7out),.mul1(mul1owire),.mul2(mul2owire),.add1(add1owire),.add2(add2owire),.clock(clock),.writing_enable(op7load),.select(op7select)),
           op8(.out(op8out),.mul1(mul1owire),.mul2(mul2owire),.add1(add1owire),.add2(add2owire),.clock(clock),.writing_enable(op8load),.select(op8select)),
           op11(.out(op11out),.mul1(mul1owire),.mul2(mul2owire),.add1(add1owire),.add2(add2owire),.clock(clock),.writing_enable(op11load),.select(op11select)),
           o1(.out(o1out),.mul1(mul1owire),.mul2(mul2owire),.add1(add1owire),.add2(add2owire),.clock(clock),.writing_enable(o1load),.select(o1select)),
           o2(.out(o2out),.mul1(mul1owire),.mul2(mul2owire),.add1(add1owire),.add2(add2owire),.clock(clock),.writing_enable(o2load),.select(o2select)),
           o3(.out(o3out),.mul1(mul1owire),.mul2(mul2owire),.add1(add1owire),.add2(add2owire),.clock(clock),.writing_enable(o3load),.select(o3select)),
           o4(.out(o4out),.mul1(mul1owire),.mul2(mul2owire),.add1(add1owire),.add2(add2owire),.clock(clock),.writing_enable(o4load),.select(o4select)),
           out(.out(outout),.mul1(mul1owire),.mul2(mul2owire),.add1(add1owire),.add2(add2owire),.clock(clock),.writing_enable(outload),.select(outselect));

// comparingarator
wire comparingwire;
comparing lessten(.a(i1out),.b(4'b1010),.out(comparingwire));

// multiplication stage
wire [1:0] mulselectwire;

mux4v1 mul1a(.input_data1(i1out),.input_data2(i2out),.input_data3(i1out),.input_data4(op5out),.select(mulselectwire),.out(mul1awire)),
        mul1b(.input_data1(i2out),.input_data2(i3out),.input_data3(i3out),.input_data4(i4out),.select(mulselectwire),.out(mul1bwire)),
        // mul1o(.input_data1(),.input_data2(),.input_data3(),.input_data4(),.select(),.out()),
        mul2a(.input_data1(i2out),.input_data2(i1out),.input_data3(i3out),.input_data4(i3out),.select(mulselectwire),.out(mul2awire)),
        mul2b(.input_data1(i4out),.input_data2(i1out),.input_data3(i4out),.input_data4(op5out),.select(mulselectwire),.out(mul2bwire));
        // mul2o(.input_data1(),.input_data2(),.input_data3(),.input_data4(),.select(),.out());

multiplier mul1(.a(mul1awire),.b(mul1bwire),.c(mul1owire)),
           mul2(.a(mul2awire),.b(mul2bwire),.c(mul2owire));

//decoder for result



// addition stage
wire [2:0] addselectwire;
wire sub1,sub2;
mux8v1 add1a(.input_data1(op1out),.input_data2(op3out),.input_data3(op1out),.input_data4(op5out),.input_data5(op6out),.input_data6(op7out),.input_data7(o1out),.input_data8(),.select(addselectwire),.out(add1awire)),
        add1b(.input_data1(op2out),.input_data2(op4out),.input_data3(op2out),.input_data4(op3out),.input_data5(op4out),.input_data6(op8out),.input_data7(o2out),.input_data8(),.select(addselectwire),.out(add1bwire)),
        // add1o(.input_data1(),.input_data2(),.input_data3(),.input_data4(),.input_data5(),.input_data6(),.input_data7(),.input_data8(),.select(),.out(add1owire)),
        add2a(.input_data1(),.input_data2(),.input_data3(op2out),.input_data4(),.input_data5(o3out),.input_data6(i3out),.input_data7(),.input_data8(op2out),.select(addselectwire),.out(add2awire)),
        add2b(.input_data1(),.input_data2(),.input_data3(op4out),.input_data4(),.input_data5(o4out),.input_data6(op11out),.input_data7(),.input_data8(outout),.select(addselectwire),.out(add2bwire));
        // add2o(.input_data1(),.input_data2(),.input_data3(),.input_data4(),.input_data5(),.input_data6(),.input_data7(),.input_data8(),.select(),.out(add2owire));

ADDER add1(.a(add1awire),.b(add1bwire),.subtract(sub1),.sum(add1owire)),
                 add2(.a(add2awire),.b(add2bwire),.subtract(sub2),.sum(add2owire));
// decoder for result

assign outta = outout;
finite_state_machine controller(
    .clk(clock),
    .ready(ready),
    .comparingarator(comparingwire),
    .multSelect(mulselectwire),
    .addSelect(addselectwire),
    .sub1(sub1),
    .sub2(sub2),
    .valid(valid),
    .regSelect_op1(op1select),
    .regSelect_op2(op2select),
    .regSelect_op3(op3select),
    .regSelect_op4(op4select),
    .regSelect_op5(op5select),
    .regSelect_op6(op6select),
    .regSelect_op7(op7select),
    .regSelect_op8(op8select),
    .regSelect_op11(op11select),
    .regSelect_o1(o1select),
    .regSelect_o2(o2select),
    .regSelect_o3(o3select),
    .regSelect_o4(o4select),
    .regSelect_out(outselect),
    .regEnable1(op1load),
    .regEnable2(op2load),
    .regEnable3(op3load),
    .regEnable4(op4load),
    .regEnable5(op5load),
    .regEnable6(op6load),
    .regEnable7(op7load),
    .regEnable8(op8load),
    .regEnable11(op11load),
    .finalEnable1(o1load),
    .finalEnable2(o2load),
    .finalEnable3(o3load),
    .finalEnable4(o4load),
    .finalEnableut(outload)
);

endmodule