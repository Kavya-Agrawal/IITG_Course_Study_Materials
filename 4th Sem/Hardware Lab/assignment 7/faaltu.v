
/////////////////////////// best to learn race conditions and synthesizability.

module testbench;
    wire w1;
    wire [3:0] r1, r2;
    wire clk;
    
    clock_gen clock(clk);
    DUT U1(clk, r1, r2, w1);
    Test T1(clk, w1, r1, r2);

    initial $monitor("%t: r1 = %d, r2 = %d, w1 = %d , reg1=%d , reg2 = %d , acc = %d", $time, r1, r2, w1 , T1.in_1 , T1.in_2 , U1.acc );
endmodule

module DUT(clk, in_1, in_2, out);

    input clk;
    input [3:0] in_1, in_2;
    output out;
    reg [3:0] acc = 0;  // 4-bit accumulator

    assign out = & (in_1 & in_2); // bitwise AND then reduce to 1 bit

    always @(posedge clk) begin
        $display("%t: in222222222 %d , acccccccccc %d", $time,  in_2 , acc );
        acc <= acc + in_2;
        #1 $display("%t: in2222222222%d , accccccccccc%d",$time, in_2 , acc );
    end

endmodule

module Test(clk, out, in_1, in_2);
    input clk, out;
    output reg [3:0] in_1, in_2;

    initial begin
        in_1 = 4'b0001; in_2 = 4'b0000;
        #50 $finish;
    end

    always @(posedge clk) begin
        $display("%t: in222222222%d",$time, in_2 );
        in_2 <= in_2 + 1;  // Increment in_2 every clock edge
        #1 $display("%t: in22222222%d",$time, in_2 );
    end

endmodule

module clock_gen(output reg clk);
    initial clk = 0;
    always #5 clk = ~clk;
endmodule
