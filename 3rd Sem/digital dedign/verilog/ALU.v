module full_adder_1bit(sum, cout, a, b, cin);
    input a, b, cin;
    output sum, cout;

    reg sum, cout;

    always @(a or b or cin)
    begin
        sum  = a ^ b ^ cin;
        cout = (a & b) | (a & cin) | (b & cin);
    end
endmodule

//---------------------------------------------------------

module mux4to1(mux_op, a, b, c, d, sel);
    output reg mux_op;
    input a,b,c,d;
    input [1:0] sel;

    always @(a or b or c or d or sel)
    begin
        case (sel)
            2'b00 : mux_op <= a;
            2'b01 : mux_op <= b;
            2'b10 : mux_op <= c;
            2'b11 : mux_op <= d;
        endcase
    end
endmodule

//---------------------------------------------------------

module alu_1bit(res, cout, a, b, cin, ALUop);
    input a, b, cin;
    input [1:0] ALUop;
    output res, cout;
    wire and_op, or_op, sum;

    assign and_op = a & b;
    assign or_op = a | b;

    full_adder_1bit FA (.sum(sum), .cout(cout), .a(a), .b(b), .cin(cin));
    mux4to1 mux (.mux_op(res), .a(and_op), .b(or_op), .c(sum), .d(1'bx), .sel(ALUop));
endmodule

//---------------------------------------------------------


module ALU (ALUout, ALUctl, A, B);
input [3:0] A, B;
input [1:0] ALUctl;
output [3:0] ALUout;

wire c1,c2,c3;

alu_1bit ALU0(.res(ALUout[0]), .cout(c1), .a(A[0]), .b(B[0]), .cin(1'b0), .ALUop(ALUctl));
alu_1bit ALU1(.res(ALUout[1]), .cout(c2), .a(A[1]), .b(B[1]), .cin(c1), .ALUop(ALUctl));
alu_1bit ALU2(.res(ALUout[2]), .cout(c3), .a(A[2]), .b(B[2]), .cin(c2), .ALUop(ALUctl));
alu_1bit ALU3(.res(ALUout[3]), .cout(), .a(A[3]), .b(B[3]), .cin(c3), .ALUop(ALUctl));

endmodule