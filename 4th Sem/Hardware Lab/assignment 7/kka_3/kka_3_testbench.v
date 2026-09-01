module testbench_top;
    wire [319:0] input_matrix;
    wire clk;
    wire s_vi;
    wire [6:0] final_sum;
    wire vo;
    wire stop;

    // Instantiate the DUT
    clock_gen clk_gen (
        .clk(clk)
    );

    test_generator generator (
        .stop(stop),
        .clk(clk),
        .input_matrix(input_matrix),
        .s_vi(s_vi)
    );

    LONG_CHAIN_ADDITION_PART3 uut (
        .input_matrix(input_matrix),
        .s_vi(s_vi),
        .clk(clk),
        .final_sum(final_sum),
        .vo(vo),
        .stop(stop)
    );

    always @(posedge clk) begin
        $monitor("%t | r0=%d r1=%d r2=%d r3=%d r4=%d r5=%d r6=%d r7=%d | x0=%d x1=%d x2=%d x3=%d | y0=%d y1=%d | z=%d | final_sum=%d | valid=%b",
                 $time,
                 uut.test_r0, uut.test_r1, uut.test_r2, uut.test_r3,
                 uut.test_r4, uut.test_r5, uut.test_r6, uut.test_r7,
                 uut.test_x0, uut.test_x1, uut.test_x2, uut.test_x3,
                 uut.test_y0, uut.test_y1, uut.test_z, final_sum, vo);
    end

endmodule