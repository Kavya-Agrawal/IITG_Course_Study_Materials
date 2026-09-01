// Testbench
module adder_tb;
    reg clk;
    reg reset;
    reg start;
    reg [3:0] in_data;
    reg [2:0] in_select;
    reg in_valid;
    wire [6:0] result;
    wire ready_for_input;
    wire done;
    
    // Instantiate the top module
    adder_top uut(
        .clk(clk),
        .reset(reset),
        .start(start),
        .in_data(in_data),
        .in_select(in_select),
        .in_valid(in_valid),
        .result(result),
        .ready_for_input(ready_for_input),
        .done(done)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // Test sequence
    initial begin
        // Initialize inputs
        reset = 1;
        start = 0;
        in_data = 0;
        in_select = 0;
        in_valid = 0;
        
        // Apply reset
        #20;
        reset = 0;
        #10;
        
        // Start the system
        start = 1;
        #10;
        start = 0;
        #10;
        
        in_data = 4'd1;
        in_select = 3'd0;
        in_valid = 1;
        #10;
        in_valid = 0;
        #10;
        
        in_data = 4'd1;
        in_select = 3'd1;
        in_valid = 1;
        #10;
        in_valid = 0;
        #10;
        
        in_data = 4'd3;
        in_select = 3'd2;
        in_valid = 1;
        #10;
        in_valid = 0;
        #10;
        
        in_data = 4'd3;
        in_select = 3'd3;
        in_valid = 1;
        #10;
        in_valid = 0;
        #10;
        
        in_data = 4'd5;
        in_select = 3'd4;
        in_valid = 1;
        #10;
        in_valid = 0;
        #10;
        
        in_data = 4'd5;
        in_select = 3'd5;
        in_valid = 1;
        #10;
        in_valid = 0;
        #10;
        
        in_data = 4'd0;
        in_select = 3'd6;
        in_valid = 1;
        #10;
        in_valid = 0;
        #10;
        
        in_data = 4'd0;
        in_select = 3'd7;
        in_valid = 1;
        #10;
        in_valid = 0;
        #10;
        
        // Start computation
        start = 1;
        #10;
        start = 0;
        
        // Wait for completion
        wait(done);
        #20;
        
        // Check result - should be 56 (0x38)
        // if (result == 7'd56)
        //     $display("Test PASSED! Result = %d (expected 56)", result);
        // else
        //     $display("Test FAILED! Result = %d (expected 56)", result);
            
        // #50;
        $finish;
    end
    
    // Optional - display signals for debugging
    initial begin
        $monitor("Time=%t: state=%d, ready=%b, done=%b, result=%d", 
                 $time, uut.ctrl.state, ready_for_input, done, result);
    end
    
endmodule