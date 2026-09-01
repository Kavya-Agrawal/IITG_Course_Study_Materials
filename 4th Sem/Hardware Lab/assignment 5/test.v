`timescale 1ns / 1ps

module funtion_tb;
    // Declare testbench signals
    reg [31:0] x, dx, a, u;
    reg clk, start;
    wire [31:0] y;

    // Instantiate the DUT (Device Under Test)
    funtion uut (
        .x(x), 
        .dx(dx), 
        .a(a), 
        .u(u), 
        .clk(clk), 
        .start(start), 
        .y(y)
    );

    // Generate Clock Signal
    always #5 clk = ~clk; // Toggle clock every 5 ns

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        start = 0;
        x = 0;
        dx = 0;
        a = 0;
        u = 0;

        // Apply Test Cases in Decimal Format
        #10 start = 1; x = 2; dx = 1; a = 400; u = 3;
        
        #2000 $finish; // Stop simulation
    end

    // Monitor the output (in Decimal Format)
    initial begin
        $monitor("Time = %0t | x = %d, dx = %d, a = %d, u = %d, start = %d | y = %d", 
                  $time, x, dx, a, u, start, y);
    end
endmodule