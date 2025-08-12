`timescale 1ns / 1ps

module my_abstest(

    input wire clk, rst,
    input wire [4:0] partial_sum,
    output reg [7:0] op, 
    output reg op_valid

    );

    reg [7:0] accumulator;
    reg [2:0] state, next_state;
    
    parameter IDLE = 3'b00; 
    parameter MSB = 3'b001; // Stage 1: Left Shift by 3
    parameter LSB1 = 3'b010; // Stage 1: Left Shift by 2
    parameter LSB2 = 3'b011; // Stage 1: Left Shift by 1
    parameter LSB = 3'b100; // Stage 1: No Shift (Left Shift by 0)
    
    //Sequential logic to decide when to change states and calculate Accumulator values
    always @(posedge clk or posedge rst) begin
    
        if(rst) begin
        
            state <= IDLE;
            accumulator <= 7'b0;
            op <= 7'b0;
            op_valid <= 1'b0;
        
        end
        
        else begin
        
            state <= next_state;
            op_valid <= 1'b0;
            
            case(state) 
            
                IDLE: begin
                    accumulator <= 0;
                end
                
                MSB: begin
                    accumulator <= partial_sum << 3;
                end
                
                LSB1: begin
                    accumulator <= accumulator + (partial_sum << 2);
                end
                
                LSB2: begin
                    accumulator <= accumulator + (partial_sum << 1);
                end
                
                LSB: begin
                    accumulator <= accumulator + partial_sum;
                    op <= accumulator + partial_sum;
                    op_valid <= 1'b1;
                end
                
             endcase
        
        end
    
    end
    
    //Combinational logic to decide next state when partial_sum input changes (AKA new sum calculated by Adder Tree)
    always @(*) begin
    
        case(state)
        
            IDLE: next_state = MSB;
            
            MSB: next_state = LSB1;
            
            LSB1: next_state = LSB2;
            
            LSB2: next_state = LSB;
            
            LSB: next_state = IDLE;
            
            default: next_state = IDLE;
        
        endcase
    
    end

endmodule
