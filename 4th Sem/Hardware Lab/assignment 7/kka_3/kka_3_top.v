module LONG_CHAIN_ADDITION_PART3 (
    input [319:0] input_matrix,
    input s_vi,
    input clk,
    output [6:0] final_sum,
    output vo,
    output stop
);
    // mux signals
    wire [3:0] s_sel_MUX; 

    wire s_ld_REG0;   
    wire s_ld_REG1;   
    wire s_ld_REG2;   
    wire s_ld_REG3;   
    wire s_ld_REG4;   
    wire s_ld_REG5;   
    wire s_ld_REG6;   
    wire s_ld_REG7;   
    wire s_ld_REGX0;   
    wire s_ld_REGX1;   
    wire s_ld_REGX2;   
    wire s_ld_REGX3;   
    wire s_ld_REGY0;   
    wire s_ld_REGY1; 
    wire s_ld_REGZ;

    wire [3:0] test_r0;
    wire [3:0] test_r1;
    wire [3:0] test_r2;
    wire [3:0] test_r3;
    wire [3:0] test_r4;
    wire [3:0] test_r5;
    wire [3:0] test_r6;
    wire [3:0] test_r7;
    wire [6:0] test_x0;
    wire [6:0] test_x1;
    wire [6:0] test_x2;
    wire [6:0] test_x3;
    wire [6:0] test_y0;
    wire [6:0] test_y1;
    wire [6:0] test_z;

    CONTROLLER controller (
        .s_vi(s_vi),
        .clk(clk),
        .s_sel_MUX(s_sel_MUX),
        .s_ld_REG0(s_ld_REG0),
        .s_ld_REG1(s_ld_REG1),
        .s_ld_REG2(s_ld_REG2),
        .s_ld_REG3(s_ld_REG3),
        .s_ld_REG4(s_ld_REG4),
        .s_ld_REG5(s_ld_REG5),
        .s_ld_REG6(s_ld_REG6),
        .s_ld_REG7(s_ld_REG7),
        .s_ld_REGX0(s_ld_REGX0),
        .s_ld_REGX1(s_ld_REGX1),
        .s_ld_REGX2(s_ld_REGX2),
        .s_ld_REGX3(s_ld_REGX3),
        .s_ld_REGY0(s_ld_REGY0),
        .s_ld_REGY1(s_ld_REGY1),
        .s_ld_REGZ(s_ld_REGZ),
        .vo(vo),
        .stop(stop)
    );

    DATAPATH data_path (
        .clk(clk),
        // .stop(stop),
        .final_sum(final_sum),
        .input_matrix(input_matrix),
        .s_ld_REG0(s_ld_REG0),
        .s_ld_REG1(s_ld_REG1),
        .s_ld_REG2(s_ld_REG2),
        .s_ld_REG3(s_ld_REG3),
        .s_ld_REG4(s_ld_REG4),
        .s_ld_REG5(s_ld_REG5),
        .s_ld_REG6(s_ld_REG6),
        .s_ld_REG7(s_ld_REG7),
        .s_ld_REGX0(s_ld_REGX0),
        .s_ld_REGX1(s_ld_REGX1),
        .s_ld_REGX2(s_ld_REGX2),
        .s_ld_REGX3(s_ld_REGX3),
        .s_ld_REGY0(s_ld_REGY0),
        .s_ld_REGY1(s_ld_REGY1),
        .s_ld_REGZ(s_ld_REGZ),
        .s_sel_MUX(s_sel_MUX),
        .test_r0(test_r0),
        .test_r1(test_r1),
        .test_r2(test_r2),
        .test_r3(test_r3),
        .test_r4(test_r4),
        .test_r5(test_r5),
        .test_r6(test_r6),
        .test_r7(test_r7),
        .test_x0(test_x0),
        .test_x1(test_x1),
        .test_x2(test_x2),
        .test_x3(test_x3),
        .test_y0(test_y0),
        .test_y1(test_y1),
        .test_z(test_z)
    );

    
endmodule

