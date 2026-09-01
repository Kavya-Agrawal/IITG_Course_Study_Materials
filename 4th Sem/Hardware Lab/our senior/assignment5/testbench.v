module testbench;
    reg clk=0;
    reg ready=0;
    reg s1=0;
    reg s2=0;
    reg s3=0;
    reg s4=0;
    reg [3:0] in=4'b0000;
    wire [14:0] outta;
    wire valid;
   
    always #5 clk = ~clk;
    
    finalDesign DUT(
        .clock(clk),
        .ready(ready),
        .in(in),
        .s1(s1),
        .s2(s2),
        .s3(s3),
        .s4(s4),
        .outta(outta),
        .valid(valid)  
    );
    
    initial begin
        //giving input
        in <= 4'b0001;
        s1<=1;
        #10
        in<=4'b0010;
        s1<=0;
        s2<=1;
        #10
        in<=4'b0011;
        s2<=0;
        s3<=1;
        #10
        in<=4'b0100;
        s3<=0;
        s4<=1;
        
        #10
        ready <=1;
        s4<=0;
        
        #120
        
        #10
        ready<=0;
        in<=4'b0001;
        
        #10
        s1<=1;
        
        #10
        s1<=0; 
        s2<=1;
        
        #10
        s2<=0;
        s3<=1;
        
        #10
        s3<=0;
        s4<=1;
        
        #10
        ready=1;
        
        #120
        
        $finish;
    end
    
endmodule