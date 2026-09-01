`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.02.2024 18:25:37
// Design Name: 
// Module Name: testbench
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


module testbench;
    reg A,B,C,D,A_bar,B_bar,C_bar,D_bar;
    wire A1, B1, C1, D1;
    
    excess3toCyclic dut(A,B,C,D,A_bar,B_bar,C_bar,D_bar,A1,B1,C1,D1);
    
    initial begin
        //0
        A=1'b0;
        B=1'b0;
        C=1'b1;
        D=1'b1;
        A_bar=1'b1;
        B_bar=1'b1;
        C_bar=1'b0;
        D_bar=1'b0;
        
        #100;
        //1
        A=1'b0;
        B=1'b1;
        C=1'b0;
        D=1'b0;
        A_bar=1'b1;
        B_bar=1'b0;
        C_bar=1'b1;
        D_bar=1'b1;
        
        #10;
        //2
        A=1'b0;
        B=1'b1;
        C=1'b0;
        D=1'b1;
        A_bar=1'b1;
        B_bar=1'b0;
        C_bar=1'b1;
        D_bar=1'b0;
        
        #10;
        //3
        A=1'b0;
        B=1'b1;
        C=1'b1;
        D=1'b0;
        A_bar=1'b1;
        B_bar=1'b0;
        C_bar=1'b0;
        D_bar=1'b1;
        
        #10;
        //4
        A=1'b0;
        B=1'b1;
        C=1'b1;
        D=1'b1;
        A_bar=1'b1;
        B_bar=1'b0;
        C_bar=1'b0;
        D_bar=1'b0;
        
        #10;
        //5
        
        A=1'b1;
        B=1'b0;
        C=1'b0;
        D=1'b0;
        A_bar=1'b0;
        B_bar=1'b1;
        C_bar=1'b1;
        D_bar=1'b1;
        
        #10;
        //6
        
        A=1'b1;
        B=1'b0;
        C=1'b0;
        D=1'b1;
        A_bar=1'b0;
        B_bar=1'b1;
        C_bar=1'b1;
        D_bar=1'b0;
        
        #10;
        //7
        
        A=1'b1;
        B=1'b0;
        C=1'b1;
        D=1'b0;
        A_bar=1'b0;
        B_bar=1'b1;
        C_bar=1'b0;
        D_bar=1'b1;
        
        #10;
        //8
        
        A=1'b1;
        B=1'b0;
        C=1'b1;
        D=1'b1;
        A_bar=1'b0;
        B_bar=1'b1;
        C_bar=1'b0;
        D_bar=1'b0;
        

        #10;
        //9
        
        A=1'b1;
        B=1'b1;
        C=1'b0;
        D=1'b0;
        A_bar=1'b0;
        B_bar=1'b0;
        C_bar=1'b1;
        D_bar=1'b1;
        
        #10;
        //10 for edge cases
        A=1'b1;
        B=1'b1;
        C=1'b0;
        D=1'b1;
        A_bar=1'b0;
        B_bar=1'b0;
        C_bar=1'b1;
        D_bar=1'b0;
        
        #10
        //11
        A=1'b1;
        B=1'b1;
        C=1'b1;
        D=1'b0;
        A_bar=1'b0;
        B_bar=1'b0;
        C_bar=1'b0;
        D_bar=1'b1;
        
        #10
        //12
        
        A=1'b1;
        B=1'b1;
        C=1'b1;
        D=1'b1;
        A_bar=1'b0;
        B_bar=1'b0;
        C_bar=1'b0;
        D_bar=1'b0;
        
        #10
     
        $finish;
    end
    
endmodule
