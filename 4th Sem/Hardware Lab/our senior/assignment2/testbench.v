// Testbench for Ripple Carry Adder 4-Bit

module RippleCarryAdder4Bit_TB;

    // Define registers for input A, input B, and carry-in
    reg [3:0] reg_A, reg_B;   // 4-bit input registers
    reg reg_carry_in;         // Carry-in register

    // Define wires for output sum and carry-out
    wire [3:0] wire_Sum;      // 4-bit output sum wire
    wire wire_carry_out;      // Output carry-out wire

    // Instantiate the Unit Under Test (UUT): Ripple Carry Adder
    RippleCarryAdder dut (reg_A, reg_B, reg_carry_in, wire_Sum, wire_carry_out);

    // Initialize Inputs and Apply Test Cases
    initial begin
        // Initialize Inputs
        reg_A = 4'b0000; reg_B = 4'b0000; reg_carry_in = 1'b0;

        // Wait for global reset to finish
        #100;

        // Apply a series of test vectors

        // Test Case 1
        reg_A = 4'b0001; reg_B = 4'b0010; reg_carry_in = 1'b0;  // Expected output_sum = 4'b0011, Cout = 1'b0
        #10;  // Wait for 10 ns

        // Test Case 2
        reg_A = 4'b0101; reg_B = 4'b0101; reg_carry_in = 1'b1;  // Expected output_sum = 4'b1011, Cout = 1'b0
        #10;

        // Test Case 3
        reg_A = 4'b1111; reg_B = 4'b0001; reg_carry_in = 1'b0;  // Expected output_sum = 4'b0000, Cout = 1'b1
        #10;

        // Test Case 4
        reg_A = 4'b1010; reg_B = 4'b0101; reg_carry_in = 1'b1;  // Expected output_sum = 4'b0000, Cout = 1'b1
        #10;

        // Test Case 5
        reg_A = 4'b1111; reg_B = 4'b1111; reg_carry_in = 1'b0;  // Expected output_sum = 4'b1110, Cout = 1'b1
        #10;

        // Complete the simulation
        $finish;
    end

endmodule