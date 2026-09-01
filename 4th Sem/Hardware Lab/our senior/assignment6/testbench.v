module lift2tb;
        reg clk;
        reg reset;
        reg [3:0] DirectionUp; // 1 means up request, 0 means no request for up direction
        reg [3:0] DirectionDown; // 1 means request for going down, 0 means no request for going down (ignore DirectionDown[0])
       
        reg [4:0] Floors;
        wire [1:0] NextStopDirection; //2'b00 1 means up, 0 means down
        wire [2:0] NextFloor; // Next stop of the lift
        //wire [0:6] seg;
        initial
            begin
            clk = 1;
            reset=1;
            end
        always #10 clk = ~clk;
        lift dut(DirectionUp,DirectionDown,Floors,clk,reset,NextStopDirection,NextFloor);
        initial
            begin
                DirectionUp = 4'b0000;
                DirectionDown = 4'b0000;
                Floors = 5'b00000;
                #100
                reset=0;
                DirectionUp = 4'b0100;
                DirectionDown = 4'b0000;
                Floors = 5'b00000;
                 #40
           //reset=0;
           DirectionUp = 4'b0100;
           DirectionDown = 4'b1000;
           Floors = 5'b00000;
               #40
             //reset=0;
             DirectionUp = 4'b0100;
             DirectionDown = 4'b1000;
             Floors = 5'b00000;
             #100
              DirectionUp = 4'b0000;
             DirectionDown = 4'b1000;
             Floors = 5'b01000;
         #80
                       DirectionUp = 4'b0000;
                      DirectionDown = 4'b1000;
                      Floors = 5'b00000;
              #80
            DirectionUp = 4'b0000;
           DirectionDown = 4'b1000;
           Floors = 5'b00100;
           #160
           DirectionUp = 4'b0000;
                           DirectionDown = 4'b0000;
                           Floors = 5'b00000;
         #40
         DirectionUp = 4'b1000;
                         DirectionDown = 4'b0001;
                         Floors = 5'b00000;
        
         
//                 #80
//                 DirectionUp = 4'b0100;
//                 DirectionDown = 4'b0000;
//                 Floors = 5'b00000;
//                 #80
//                 DirectionUp = 4'b0000;
//                 DirectionDown = 4'b0000;
////                 Floors = 5'b10000;
//                 #400
//                 DirectionUp = 4'b0000;
//                 DirectionDown = 4'b0000;
//                 Floors = 5'b00001;
                 
//                 #40
//                 DirectionDown = 4'b0010;
//                 Floors = 0;

                // #40
                // DirectionUp = 4'b1100;
                // DirectionDown = 4'b0000;
                // Floors = 5'b00000;
                // #80
                // DirectionUp = 4'b1000;
                // DirectionDown = 4'b0000;
                // Floors = 5'b10000;
                // #40
                // DirectionUp = 4'b0000;
                // DirectionDown = 4'b0000;
                // Floors = 5'b10000;
                // #40
                // DirectionUp = 4'b0000;
                // DirectionDown = 4'b0000;
                // Floors = 5'b00000;
                // #200
               
               
               
                // DirectionUp = 4'b0010;
                // DirectionDown = 4'b0000;
                // Floors = 5'b00000;
                // #20
                // DirectionUp = 4'b0010;
                // DirectionDown = 4'b0100;
                // Floors = 5'b00000;
                // #20
                // DirectionUp = 4'b0010;
                // DirectionDown = 4'b0000;
                // Floors = 5'b00100;
                // #40
                // DirectionUp = 4'b0010;
                // DirectionDown = 4'b0000;
                // Floors = 5'b00000;
                // #40
                // DirectionUp = 4'b0000;
                // DirectionDown = 4'b0000;
                // Floors = 5'b10000;
                #500
               
                $finish;
            end
//            initial begin
//                $monitor("At time %t, s1 = %b",
//                    $time, s1);
//            end
   
endmodule