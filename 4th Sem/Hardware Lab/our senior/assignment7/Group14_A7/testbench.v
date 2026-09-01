////////////////////////////////////////////////////////////////////////

module testbench;

reg clock;
reg [3:0] waddress;
reg [5:0] dataIn;
reg dataValid;
wire outValid;
wire [3:0] outAddress;
wire [5:0] dataOut;
wire [4:0] c;


Sort dut(clock, waddress, dataIn, dataValid, outValid, outAddress, dataOut,c);

initial begin
    clock = 0;
   
    waddress = 0;
    dataIn = 0;
    dataValid = 0;
end

always #5 clock = ~clock;

always@(clock) begin
    // Input data
   #5;
    
    #20;
    dataValid = 1;
    waddress=4'b0000;
    dataIn = 7;
  	#20 
  	dataValid =0;
   #10; // or 10
  	dataValid =1;
  
    waddress=4'b0001;
    dataIn = 8;

    #30;
  	dataValid =0;
  	#10
  	dataValid =1;
    waddress=4'b0010;
    dataIn = 1;
     #30;
         dataValid =0;
         #10
         dataValid =1;
       waddress=4'b0011;
       dataIn = 5;
 	#30;
//    waddress=4'b0100;
//    dataIn = 6'b001101;
// #20;
    // End of input data
    dataValid = 0;
    #3000;
    $finish;
end

endmodule