`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.02.2024 18:08:01
// Design Name: 
// Module Name: excess3toCyclic
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module excess3toCyclic(
    input A,
    input B,
    input C, 
    input D,
    input A_bar,
    input B_bar,
    input C_bar,
    input D_bar, 
    output A1,
    output B1,
    output C1,
    output D1
    );
    
    // Output A1 is the result of AND operation between A and B_bar
    assign A1=(A&B_bar);
    // Output B1 is a combination of AND and OR operations on A, B, C, D, A_bar, B_bar, C_bar, D_bar
    assign B1=(((A&C_bar)&D_bar)|((A|B)&(C&D)));
    // Output C1 is a combination of OR and AND operations on B_bar, D, C_bar, C, B
    assign C1=(((B_bar|D)&C_bar)|(C&B));
    // Output D1 is the result of AND operation between A_bar and C_bar
    assign D1=(A_bar&C_bar);
    
endmodule
