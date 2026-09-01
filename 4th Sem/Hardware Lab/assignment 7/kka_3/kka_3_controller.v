module CONTROLLER(
    input s_vi,        
    input clk,    

    output reg [3:0] s_sel_MUX,

    output reg s_ld_REG0,   
    output reg s_ld_REG1,   
    output reg s_ld_REG2,   
    output reg s_ld_REG3,   
    output reg s_ld_REG4,   
    output reg s_ld_REG5,   
    output reg s_ld_REG6,   
    output reg s_ld_REG7,   

    output reg s_ld_REGX0,   
    output reg s_ld_REGX1,   
    output reg s_ld_REGX2,   
    output reg s_ld_REGX3,   

    output reg s_ld_REGY0,   
    output reg s_ld_REGY1, 

    output reg s_ld_REGZ,

    output reg vo,
    output reg stop
);
    
    reg [2:0] current_state = 3'b000; 
    reg [2:0] next_state;    
    reg [3:0] i = 4'b1111;          
    reg [3:0] counter = 4'b0000;          

    always @(posedge clk) begin
        if(next_state == 2 ) current_state = next_state;
        else current_state <= next_state;
        // $display("%t , Currstate=%b, nextstate=%b, svi=%b", $time, current_state , next_state , s_vi);
        #1 $display("%t , Currstate=%b, nextstate=%b, svi=%b", $time, current_state , next_state , s_vi);
    end
        
    always @(posedge clk) begin
        // $display("%t , currstate=%b, nextstate=%b, vo=%b", $time, current_state , next_state , vo);
        case (current_state)
            3'b000: begin // start state
                if (s_vi) next_state = 3'b001; 
                    else next_state = 3'b000;    
            end

            3'b001: begin // input state
                // $display("%t ,i=%b", $time, i);
                if (i == 4'b1011) next_state = 3'b010; 
                else begin next_state = 3'b001; i = i+1; end
            end

            3'b010: begin 
                    next_state = 3'b011; 
                    // else begin next_state = 3'b010; counter = counter+1; end
            end

            3'b011: begin
                next_state = 3'b011;
            end

            default: begin
                next_state = 3'b000;           
            end
        endcase


        // State transition logic for different states
        case(current_state) 
            // Start state
            3'b000 : begin 
                s_sel_MUX <= 4'b0000;

                s_ld_REG0 <= 1;   
                s_ld_REG1 <= 1;   
                s_ld_REG2 <= 1;   
                s_ld_REG3 <= 1;   
                s_ld_REG4 <= 1;   
                s_ld_REG5 <= 1;   
                s_ld_REG6 <= 1;   
                s_ld_REG7 <= 1;   

                s_ld_REGX0 <= 1;   
                s_ld_REGX1 <= 1;   
                s_ld_REGX2 <= 1;   
                s_ld_REGX3 <= 1;   

                s_ld_REGY0 <= 1;  
                s_ld_REGY1 <= 1;

                s_ld_REGZ <= 1;

                vo = 0;
                stop  = 0;

            end

            // input state
            3'b001 : begin 
                
                s_sel_MUX <= i+1;

                s_ld_REG0 <= 1;   
                s_ld_REG1 <= 1;   
                s_ld_REG2 <= 1;   
                s_ld_REG3 <= 1;   
                s_ld_REG4 <= 1;   
                s_ld_REG5 <= 1;   
                s_ld_REG6 <= 1;   
                s_ld_REG7 <= 1;   

                s_ld_REGX0 <= 1;   
                s_ld_REGX1 <= 1;   
                s_ld_REGX2 <= 1;   
                s_ld_REGX3 <= 1;   

                s_ld_REGY0 <= 1;  
                s_ld_REGY1 <= 1;

                s_ld_REGZ <= 1;

                if (i>=4'b0011) vo = 1;
                // else if (i><=4'b0011) vo <= 1;
                else vo = 0;
                stop = 0;

            end

            3'b010 : begin 
                s_sel_MUX <= 4'b1010;

                s_ld_REG0 <= 1;   
                s_ld_REG1 <= 1;   
                s_ld_REG2 <= 1;   
                s_ld_REG3 <= 1;   
                s_ld_REG4 <= 1;   
                s_ld_REG5 <= 1;   
                s_ld_REG6 <= 1;   
                s_ld_REG7 <= 1;   

                s_ld_REGX0 <= 1;   
                s_ld_REGX1 <= 1;   
                s_ld_REGX2 <= 1;   
                s_ld_REGX3 <= 1;   

                s_ld_REGY0 <= 1;  
                s_ld_REGY1 <= 1;

                s_ld_REGZ <= 1;

                vo = 0;
                stop = 0;

            end

            3'b011 : begin 
                s_sel_MUX <= 4'b1010;

                s_ld_REG0 <= 0;   
                s_ld_REG1 <= 0;   
                s_ld_REG2 <= 0;   
                s_ld_REG3 <= 0;   
                s_ld_REG4 <= 0;   
                s_ld_REG5 <= 0;   
                s_ld_REG6 <= 0;   
                s_ld_REG7 <= 0;   

                s_ld_REGX0 <= 0;   
                s_ld_REGX1 <= 0;   
                s_ld_REGX2 <= 0;   
                s_ld_REGX3 <= 0;   

                s_ld_REGY0 <= 0;  
                s_ld_REGY1 <= 0;

                s_ld_REGZ <= 0;

                vo = 0;
                stop = 1;

            end

        endcase
        // $display("%t , currstate=%b, nextstate=%b, vo=%b", $time, current_state , next_state , vo);
    end
        
       
endmodule
