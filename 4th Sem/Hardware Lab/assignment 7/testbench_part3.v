`timescale 1ns / 1ps

module LONG_CHAIN_ADDITION_PART3_tb;

    // Inputs
    reg [319:0] input_matrix;
    reg clk;
    reg s_vi;

    // Outputs
    wire [6:0] final_sum;
    wire vo;
    wire stop;

    // Instantiate the Unit Under Test (UUT)
    LONG_CHAIN_ADDITION_PART3 uut (
        .input_matrix(input_matrix),
        .s_vi(s_vi),
        .clk(clk),
        .final_sum(final_sum),
        .vo(vo),
        .stop(stop)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns clock period
    end

    // Test sequence
    initial begin
        // Fill the 10x8 matrix = 80 4-bit numbers = 320 bits
        input_matrix = {
            4'd1,  4'd1,  4'd1,  4'd2,  4'd1,  4'd1,  4'd2,  4'd2,   // Row 1 → Sum = 10
            4'd2,  4'd2,  4'd2,  4'd3,  4'd2,  4'd2,  4'd4,  4'd4,   // Row 2 → Sum = 20
            4'd3,  4'd3,  4'd3,  4'd4,  4'd4,  4'd4,  4'd5,  4'd5,   // Row 3 → Sum = 30
            4'd4,  4'd4,  4'd5,  4'd6,  4'd5,  4'd5,  4'd6,  4'd6,   // Row 4 → Sum = 40
            4'd5,  4'd5,  4'd6,  4'd7,  4'd6,  4'd6,  4'd8,  4'd8,   // Row 5 → Sum = 50
            4'd6,  4'd6,  4'd7,  4'd8,  4'd8,  4'd8,  4'd9,  4'd9,   // Row 6 → Sum = 60
            4'd7,  4'd7,  4'd8,  4'd9,  4'd9,  4'd9,  4'd11, 4'd11,  // Row 7 → Sum = 70
            4'd8,  4'd8,  4'd9,  4'd10,  4'd11, 4'd11, 4'd12, 4'd12,  // Row 8 → Sum = 80
            4'd9,  4'd9,  4'd10, 4'd12, 4'd12, 4'd12, 4'd14, 4'd14,  // Row 9 → Sum = 90
            4'd10, 4'd10, 4'd11, 4'd13, 4'd14, 4'd14, 4'd15, 4'd15   // Row 10 → Sum = 100

        };

        s_vi = 0;
        #5;

        // Start operation
        s_vi = 1;
        #15;
        s_vi = 0;

        #120;
        $finish;
    end

    // Debug display at each clock edge
    always @(posedge clk) begin
        $monitor("%t | r0=%d r1=%d r2=%d r3=%d r4=%d r5=%d r6=%d r7=%d | x0=%d x1=%d x2=%d x3=%d | y0=%d y1=%d | z=%d | final_sum=%d | valid=%b",
                 $time,
                 uut.test_r0, uut.test_r1, uut.test_r2, uut.test_r3,
                 uut.test_r4, uut.test_r5, uut.test_r6, uut.test_r7,
                 uut.test_x0, uut.test_x1, uut.test_x2, uut.test_x3,
                 uut.test_y0, uut.test_y1,
                 uut.test_z, final_sum, vo );
    end

endmodule
