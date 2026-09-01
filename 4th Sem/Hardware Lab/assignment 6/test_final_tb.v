`timescale 1ns / 1ps

module MIN_MAX_ALGORITHM_TB;

    // Inputs
    reg s_vi;
    reg [3:0] ai;
    reg [4:0] di;
    reg clk;

    // Outputs
    wire [3:0] ao;
    wire [4:0] do;
    wire vo;
    
    // Instantiate the MIN_MAX_ALGORITHM module
    MIN_MAX_ALGORITHM uut (
        .s_vi(s_vi),
        .ai(ai),
        .di(di),
        .clk(clk),
        .ao(ao),
        .do(do),
        .vo(vo)
    );

    // Clock Generation
    always #5 clk = ~clk;

    initial begin
        // Initialize inputs
        clk = 0;
        s_vi = 0;
        ai = 4'b0000;
        di = 5'b00000;

        #2 s_vi = 1; 
        ai = 2;
        di = 16;

        #10 s_vi = 1; 
        ai = 6;
        di = 11;
        
        #10 s_vi = 1; 
          ai = 5;
          di = 17;
          
        #10 s_vi = 1; 
        ai = 9;
        di = 20;

        #10 s_vi = 1; 
        ai = 11;
        di = 13;

        #10 s_vi = 1; 
        ai = 15;
        di = 20;

        #10 s_vi = 0;

        #1000 $finish;
    end
    
    // Monitor all outputs and test wires
    initial begin
        $monitor( " ao=%d, do=%d, vo=%b,CNT=%d,MAXA=%d,MAXV=%d,MINA=%d,MINV=%d,MDR=%d,MAR=%d,ceq=%d,vd=%b,cs=%d, m0=%b, m1=%b,m2=%b,m3=%b,m4=%b,m5=%b,m11=%b,m12=%b,m13=%b,m14=%b,m15=%b", 
            ao, do, vo, uut.test_REG_CNT, uut.test_REG_MAXA, uut.test_REG_MAXV, uut.test_REG_MINA, uut.test_REG_MINV, uut.test_REG_MDR, uut.test_REG_MAR,uut.test_REG_ceq, uut.test_REG_vd, uut.test_current_state, uut.test_memory_0,uut.test_memory_1, uut.test_memory_2, uut.test_memory_3, uut.test_memory_4, uut.test_memory_5, uut.test_memory_11, uut.test_memory_12, uut.test_memory_13, uut.test_memory_14, uut.test_memory_15 );
    end

endmodule