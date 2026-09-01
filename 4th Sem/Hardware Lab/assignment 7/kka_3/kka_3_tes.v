module test_generator(
    input clk,
    input stop,
    output reg [319:0] input_matrix,
    output reg s_vi
);
    initial begin
        input_matrix = {
            4'd1,  4'd1,  4'd1,  4'd1,  4'd1,  4'd1,  4'd1,  4'd1,
            4'd2,  4'd2,  4'd2,  4'd2,  4'd2,  4'd2,  4'd2,  4'd2,
            4'd3,  4'd3,  4'd3,  4'd3,  4'd3,  4'd3,  4'd3,  4'd3,
            4'd4,  4'd4,  4'd4,  4'd4,  4'd4,  4'd4,  4'd4,  4'd4,
            4'd5,  4'd5,  4'd5,  4'd5,  4'd5,  4'd5,  4'd5,  4'd5,
            4'd6,  4'd6,  4'd6,  4'd6,  4'd6,  4'd6,  4'd6,  4'd6,
            4'd7,  4'd7,  4'd7,  4'd7,  4'd7,  4'd7,  4'd7, 4'd7,
            4'd8,  4'd8,  4'd8,  4'd8, 4'd8, 4'd8, 4'd8, 4'd8,
            4'd9,  4'd9,  4'd9, 4'd9, 4'd9, 4'd9, 4'd9, 4'd9,
            4'd10, 4'd10, 4'd10, 4'd10, 4'd10, 4'd10, 4'd10, 4'd10
        };
        s_vi = 0;

        #3;
        s_vi = 1;
        #6;
        s_vi = 0;
        #6;
        wait(stop);
        $finish;
    end
endmodule
