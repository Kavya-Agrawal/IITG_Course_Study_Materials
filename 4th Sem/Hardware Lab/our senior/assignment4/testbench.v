`timescale 1ns / 1ps

module upDownCounter_tb;

    // Inputs
    reg clk;
    reg reset;
    reg set;
    reg up;
    reg [3:0] value;

    // Outputs
    wire [3:0] counter; // Changed to reg

    // Instantiate the upDownCounter module
    upDownCounter uut (
        .clk(clk),
        .reset(reset),
        .set(set),
        .up(up),
        .value(value),
        .counter(counter)
    );

    // Clock generation
    always #5 clk = ~clk; // 10 ns clock period

    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        set = 0;
        up = 1;
        value = 4'b0000;

        // Apply reset for 1 clock cycle
        //reset = 1;
        #10 reset = 0;

        // Wait for a few clock cycles
        #50;

        // Set the counter value to 7
        set = 1;
        value = 4'b0111;
        #10 set = 0;

        // Wait for the counter to reach maximum value and then reset
        #200;

        // Set the counter value to 2
        set = 1;
        value = 4'b0010;
        #10 set = 0;

        // Wait for a few clock cycles
        #50;

        // Apply reset again
        reset = 1;
        #10 reset = 0;

        // Wait for a few clock cycles
        #50;
        
        // Set up control to 0 to count down
        up = 0;
        
        // Wait for a few clock cycles
        #20;
        
        reset=1;
        #10 reset=0;
        
        #100 up=1;
        // Finish simulation
        $finish;
    end

endmodule
