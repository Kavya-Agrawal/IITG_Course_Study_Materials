module clock_gen(input clk, output s_clk);
    reg [25:0] cnt=0;
    reg x=0;
    always@(posedge clk)
    begin
        cnt=cnt+1;
        if(cnt==50_000_000)
            begin
                cnt=0;
                x=~x;
            end 
    end
    assign s_clk=x;
endmodule



module fsm(
    input  [3:0] DirectionUp, DirectionDown,
    input  [4:0] Floors,  
    input clk,reset,
    output reg [1:0] NextStopDirection,
    output reg [2:0] NextFloor 
   
);


reg [1:0] TempStopDirection,TempStopDirection2;
reg [3:0] TempDirectionUp, TempDirectionDown;
reg[4:0] TempFloors;
reg [2:0] CurrentFloor,vellaregister;
reg [2:0] FinalFloor;
reg [2:0] counter;
wire[1:0] counterVella;
reg [4:0] cState=0, nState=0;


integer i;
integer change_detector, change_detector2, change_detector3;

assign counterVella=2'b00;
always @(posedge clk)
begin
    if(!reset)
    begin
        //taking or with new inputs
        TempDirectionDown = TempDirectionDown | DirectionDown; 
        TempDirectionUp = TempDirectionUp | DirectionUp;
        TempFloors = TempFloors | Floors;
        //storing next stop direction in a temporary register
        TempStopDirection = NextStopDirection;
         //if our calculated final floor same as current floor we enter idle state
        if(FinalFloor == CurrentFloor)
        begin
            TempStopDirection = 2'b00;
        end
        
        
         //if we are currently idle
        if(NextStopDirection == 2'b00)
        begin
            
            change_detector = 1;
            for(i = 0; i < 5; i = i+1)
            begin
                if(i >= CurrentFloor) change_detector = 0;// for loop to work for below the current floor
                if(Floors[i] == 1 && change_detector == 1)
                begin
                    if(FinalFloor == CurrentFloor) FinalFloor = i; //if final floor and current floor are same, we stay there only
                    // finding the max floor number below the current floor that has floor request
                    //setting direction down
                    //giving priority to down floors and floors
                    NextFloor = i;
                    TempStopDirection = 2'b01;
                end
            end
            
            //logic block 2
            change_detector = 1;
            for(i = 4; i >= 0; i = i-1)
            begin
                if(i <= CurrentFloor) change_detector = 0; //so that loop works for floors greater than the current floor
                
                if(Floors[i] == 1 && change_detector == 1)
                begin
                    if(FinalFloor == CurrentFloor) FinalFloor = i;
                    //finding the minimum floor above the current floor jiska floor pe jaana hai 
                    NextFloor = i;
                    TempStopDirection = 2'b10;
                end
            end
            
            //till now we saw the closest floor above and below the current floor.
            //if there are no floor requests only then we enter the next if
            //if there were any floor requests, final floor would have been updated

            //no floor requests
            if(FinalFloor == CurrentFloor)
            begin
                change_detector2 = 0;
                change_detector = 1;
                for(i = 0; i<5; i = i+1)
                begin
                    if(i >= CurrentFloor) change_detector = 0; //for floors below the current floor
                    if(change_detector == 1 && (i<4 && TempDirectionUp[i] == 1) || (i>0 && TempDirectionDown[i-1] == 1)) //for any floor below the current floor up and down request has come
                    begin
                        NextFloor = i; //set the next floor to the floor jahan se request aayi
                        FinalFloor = i; // final floor 
                        if(i != CurrentFloor) TempStopDirection = 2'b01; //means we have to go down
                        change_detector2 = 1; //we set change_detector2 so that if we have a request neeche wale floorse in the next logic block we update the final floor only if it is closer than neeche wala floor request
                    end
                end
                change_detector = 0;
                change_detector3 = 0;
                for(i = 0; i <5; i = i+1)
                begin
                    if(i> CurrentFloor) change_detector = 1; //for floorsa abpove the current floor
                    if(change_detector == 1 && (i<4 && TempDirectionUp[i] == 1) || (i>0 && TempDirectionDown[i-1] == 1) && change_detector3 == 0)
                    begin
                        if(!change_detector2 || (i-CurrentFloor) < (CurrentFloor - NextFloor)) //enters blocks either there is no request from neeche wale floors of if the request from upar wale floors is closer to the neche wale floors se request
                        begin
                            NextFloor = i;
                            FinalFloor = i;
                            TempStopDirection = 2'b10; //setting direction to up
                            change_detector3 = 1; //if we update upar wale floors ki wajah se then this change_detector3 is set 1 so that we see the least floor above the current floor
                        end
                    end
                end
            end
        end


        //if we are going upwards and i have to reach the final floor 
        //
        if(TempStopDirection == 2'b10 && (FinalFloor == 4 || (FinalFloor<4 && (TempDirectionUp[FinalFloor] == 1 || TempFloors[FinalFloor] == 1))))
        begin
            change_detector = 0;
            for(i = 0; i<5; i = i+1)
            begin
                if(i == CurrentFloor) change_detector = 1; //for floors>current floor
                if(change_detector == 1 && ((TempDirectionUp[i] == 1) || (TempFloors[i] == 1)))
                begin
                    NextFloor = i; //if we recieve the request from any floor between the current floor and rthe final floor going upwards , we stop at theat floor
                    change_detector = 0;
                end
                if(i == FinalFloor) change_detector = 0; // if we reacht he final floor, change_detector=0

            end
        end

        //if we are going down and i recieve a down request from the final floor
        if(TempStopDirection == 2'b01 && (FinalFloor==0 || (FinalFloor>0 && (TempDirectionDown[FinalFloor-1] == 1 || TempFloors[FinalFloor] == 1))))
        begin
            change_detector = 0;
            for(i = 4; i >= 0; i = i-1)
            begin
                if(i == CurrentFloor) change_detector = 1; 
                //for any floor below the current floor, if i get direction down request or a stop request, i update my next floor
                if(change_detector == 1 && ((TempDirectionDown[i-1] == 1) || (TempFloors[i] == 1)))
                begin
                    NextFloor = i;
                    change_detector = 0;
                end
                if(i == FinalFloor) change_detector = 0;
            end
        end
        
        //this is done because NextStopDirection is used in the sensitivity list of our state change and is being updated multiple times in the above logic block
        //so updating the NextStopDirection using the TempStopDirection variable
        NextStopDirection = TempStopDirection;

        cState = nState; 
        //only if i am in the transition state from one floor to another, i update my counter
        if(cState == 5 ||cState == 6 ||cState == 7 ||cState == 8 ||cState == 9 ||cState == 10 ||cState == 11 ||cState == 12)
            counter = counter + 1;
        else counter = 0;
        if(counter == 4) counter = 0;

        //after reaching a floor we need to set the requests from that floor to 0 otherwise we would be stuck on the same floor forever
        if(cState==0)
            begin
                TempDirectionUp[0] = 0;
               TempFloors[0] = 0;
            end
        else if(cState==1)
            begin
               TempDirectionDown[0] = 0;
               TempDirectionUp[1] = 0;
               TempFloors[1] = 0;
            end
        else if(cState==2)
            begin
               TempDirectionDown[1] = 0;
               TempDirectionUp[2] = 0;
               TempFloors[2] = 0;
            end
        else if(cState==3)
            begin
               TempDirectionDown[2] = 0;
               TempDirectionUp[3] = 0;
               TempFloors[3] = 0;
            end
        else if(cState==4)
            begin
               TempDirectionDown[3] = 0;
               TempFloors[4] = 0;
            end
    end

    else
    begin
        FinalFloor = 0; NextFloor = 0; NextStopDirection = 0; TempStopDirection = 0;
        cState = 0; counter = 0;
        TempFloors = 0; TempDirectionDown = 0; TempDirectionUp = 0;
    end

end


always @(cState, counter, NextStopDirection)
begin
    case (cState)
        0://ground floor
            begin
               CurrentFloor = 0; 
               if(NextStopDirection == 2'b10  && FinalFloor != CurrentFloor) nState = 5;
               else nState = 0;
            end
        1://first floor
            begin
               CurrentFloor = 1;               
               if(NextStopDirection == 2'b10 && FinalFloor != CurrentFloor) nState = 7;
               else if(NextStopDirection == 2'b01 && FinalFloor != CurrentFloor) nState = 6;
               else nState = 1;
            end   
        2://second floor
            begin
               CurrentFloor = 2;
               if(NextStopDirection == 2'b10 && FinalFloor != CurrentFloor) nState = 9;
               else if(NextStopDirection == 2'b01 && FinalFloor != CurrentFloor) nState = 8;
               else nState = 2;
            end 
        3://third floor
            begin
               CurrentFloor = 3;
               if(NextStopDirection == 2'b10  && FinalFloor != CurrentFloor) nState = 11;
               else if(NextStopDirection == 2'b01  && FinalFloor != CurrentFloor) nState = 10;
               else nState = 3;
            end
        4://fourth floor
            begin
               CurrentFloor = 4;
               if(NextStopDirection == 2'b01  && FinalFloor != CurrentFloor) nState = 12;
               else nState = 4;
            end
        5://moving 0 to 1
            begin
                CurrentFloor = 0;
                if(counter == 3)
                begin
                    CurrentFloor = 1;
                    if(NextFloor == 1) nState = 1;
                    else nState = 7;
                end
                else
                begin
                    nState = 5;                    
                end
            end
        6://moving 1 to 0
            begin
                CurrentFloor = 1;
                if(counter == 3)
                begin
                    CurrentFloor = 0;
                    nState = 0;
                end
                else
                begin
                    nState = 6;
                end
            end
        
        7://moving 1 to 2
            begin
                CurrentFloor = 1;
                if(counter == 3)
                begin
                    CurrentFloor = 2;
                    if(NextFloor == 2) nState = 2;
                    else nState = 9;
                end
                else
                begin
                    nState = 7;                    
                end
            end
        8://moving 2 to 1
            begin
                CurrentFloor = 2;
                if(counter == 3)
                begin
                    CurrentFloor = 1;
                    if(NextFloor == 1) nState = 1;
                    else nState = 6;
                end
                else
                begin
                    nState = 8;
                end
            end
        
        9://moving 2 to 3
            begin
                CurrentFloor = 2;
                if(counter == 3)
                begin
                    CurrentFloor = 3;
                    if(NextFloor == 3) nState = 3;
                    else nState = 11;
                end
                else
                begin
                    nState = 9;                    
                end
            end
        10://moving 3 to 2
            begin
                CurrentFloor = 3;
                if(counter == 3)
                begin
                    CurrentFloor = 2;
                    if(NextFloor == 2) nState = 2;
                    else nState = 8;
                end
                else
                begin
                    nState = 10;
                end
            end
        
        11://moving 3 to 4
            begin
                CurrentFloor = 3;
                if(counter == 3)
                begin
                    CurrentFloor = 4;
                    nState = 4;
                end
                else
                begin
                    nState = 11;                    
                end
            end
        12://moving 4 to 3
            begin
                CurrentFloor = 4;
                if(counter == 3)
                begin
                    CurrentFloor = 3;
                    if(NextFloor == 3) nState = 3;
                    else nState = 10;
                end
                else
                begin
                    nState = 12;
                end
            end
        
       
    endcase
       
end

endmodule



module lift(
    input [3:0] DirectionUp, DirectionDown,
    // DirectionUp[3] means up request from 3rd floor, DirectionUp[0] means up request from ground floor
     // DirectionDown[3] means down request from 4th floor, DirectionDown[0] means down request from 1st floor
    input  [4:0] Floors, //Floors[4],Floors[3],Floors[2],Floors[1],Floors[0],  request for Floors 4, 3, 2, 1, ground respectively.  
    input clock,reset, // clock and reset
    output [1:0] NextStopDirection, 
    //The lift will move in up/down direction in next clock; 10 means up, 01 means down and 00 implies it will stay in the current Floors and 11 is invalid.
    output [2:0] NextFloor // next stop of the lift
    );
    wire clk;
   clock_gen cd(.clk(clock),.s_clk(clk));
   fsm FSM(DirectionUp, DirectionDown, Floors, clock, reset, NextStopDirection, NextFloor);
endmodule
