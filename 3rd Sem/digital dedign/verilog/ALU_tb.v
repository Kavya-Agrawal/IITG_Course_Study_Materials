module ALU_tb;
    reg [3:0] A, B;
    reg [1:0] ALUctl;
    wire [3:0] result;

    //module instantiation
    ALU CUT (.ALUout(result), .ALUctl(ALUctl), .A(A), .B(B));

    initial
    begin
        $dumpfile("ALU.vcd");
        $dumpvars(0,CUT);
        A = 4'b0101; B = 4'b0110; ALUctl = 2'b00;
        #10;
        ALUctl = 2'b01;
        #10;
        ALUctl = 2'b10;
        #10;
        ALUctl = 2'b11;
        #10;

        A = 4'b0100; B = 4'b1100; ALUctl = 2'b00;
        #10;
        ALUctl = 2'b01;
        #10;
        ALUctl = 2'b10;
        #10;

        A = 4'b1010; B = 4'b0101; ALUctl = 2'b00;
        #10;
        ALUctl = 2'b01;
        #10;
        ALUctl = 2'b10;
        #10;
        

        #50 $finish; 	
    end
    initial
        $monitor("time=%0t : A=%b B=%b AlUctl=%b : Result = %b", $time, A, B, ALUctl, result);

endmodule