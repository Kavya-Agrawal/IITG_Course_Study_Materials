// Half Adder module: adds two bits and generates the sum and carry out
module HalfAdder (
    input wire input_a,
    input wire input_b,
    output wire output_sum,
    output wire output_carry
);
    // Compute carry out and sum using bitwise AND and XOR operations
    assign output_carry = input_a & input_b; // Carry is 1 if both inputs are 1
    assign output_sum = input_a ^ input_b;    // Sum is 1 if inputs are different
endmodule

// Full Adder module: adds three bits (two inputs and a carry-in) and produces sum and carry out
module FullAdder (
    input wire input_a,
    input wire input_b,
    input wire input_carry_in,
    output wire output_sum,
    output wire output_carry_out
);
    wire internal_wire1, internal_wire2, internal_wire3;
    
    // Instantiate two Half Adders to compute intermediate results
    HalfAdder HA1(input_a, input_b, internal_wire1, internal_wire2); // Compute sum and intermediate carry
    HalfAdder HA2(input_carry_in, internal_wire1, output_sum, internal_wire3); // Compute final sum and another intermediate carry
    
    // Compute carry out by performing bitwise OR on intermediate carries
    assign output_carry_out = internal_wire2 | internal_wire3; // Output carry is 1 if either intermediate carry is 1
endmodule

// Ripple Carry Adder module: 4-bit adder composed of Full Adders
module RippleCarryAdder (
    input wire [3:0] input_A,        // 4-bit input A
    input wire [3:0] input_B,        // 4-bit input B
    input wire input_carry_in,       // Carry-in bit
    output wire [3:0] output_Sum,    // 4-bit output sum
    output wire output_carry_out     // Output carry out
);

    wire internal_carry1, internal_carry2, internal_carry3;
    
    // Instantiate four Full Adders to compute the 4-bit sum
    FullAdder FA1(input_A[0], input_B[0], input_carry_in, output_Sum[0], internal_carry1);
    FullAdder FA2(input_A[1], input_B[1], internal_carry1, output_Sum[1], internal_carry2);
    FullAdder FA3(input_A[2], input_B[2], internal_carry2, output_Sum[2], internal_carry3);
    FullAdder FA4(input_A[3], input_B[3], internal_carry3, output_Sum[3], output_carry_out);
endmodule
