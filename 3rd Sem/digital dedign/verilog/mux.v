module mux2to1(out, outbar, a , b, sel);
    output out, outbar;
    input a,b,sel;

    //Each of the following statements executes in parallel
    //ORDER DOES NOT MATTER 
    assign out = sel ? a : b; //concurrent execution unit so work in similar way as non blocking assignments
    assign outbar = ~out;   

endmodule

//concurrent exec units : assign , instantiation , intial , always

module mux2to1_gate(out, outbar, a , b, sel);
    output out, outbar;
    input a, b, sel;

    wire out1, out2, selbar;

    not i1 (selbar, sel);  //concurrent execution unit so work in similar way as non blocking assignments
    and a1 (out1, a, sel);
    and a2 (out2, b, selbar);
    or o1 (out, out1, out2);
    not i2 (outbar, out);
    
endmodule

module mux2to1_procedural(out, outbar, a , b, sel);
    output out, outbar;
    input a, b, sel;

    //Assignment inside an always block must be declared as 
    //variable data type such as reg
    reg out, outbar;

    //Statements inside the always block are executed sequentially
    //ORDER MATTERS
    always @(a or b or sel)
        begin
            if (sel) out = a;
            else out = b;

            outbar = ~out;
        end
endmodule


//Mixing procedural and continuous assignments
module mux2to1_mixed(out, outbar, a , b, sel);
    output out, outbar;
    input a, b, sel;

    //NOTE: only out is reg
    reg out;

    //procedural description
    always @(a or b or sel)
    begin
      if (sel) out = a;
      else out = b;
    end
    
    assign outbar = ~out;  //continuous description
    
endmodule

module mux_incompete(out,a,b,c,sel);
input [1:0] sel;
input a,b,c;
output out;
reg out;

always@(a or b or c or sel)
begin
    case (sel)
        2'b00: out = a;
        2'b01: out = b;
        2'b10: out = c;
        default: out  = 0; //completion
    endcase
end
endmodule