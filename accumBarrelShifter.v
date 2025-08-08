`timescale 1ns / 1ps

module abstest(

    input wire clk_1MHz, rst,
    input wire [4:0] partialSum,
    output reg [7:0] op

    );

    reg [7:0] macOp;
    reg [2:0] state, next_state;
    
    parameter RESET = 3'b000, MSB = 3'b001, STAGETWO = 3'b010, STAGETHREE = 3'b011, FINALMAC = 3'b100;

    initial begin
        
        state = RESET;
        macOp = 0;
        
    end

    always @(posedge clk_1MHz or posedge rst) begin

        if(rst) begin
            state <= RESET;
        end

        else begin
            if(state != next_state) begin
                state <= next_state;
            end
        end

    end

    always @(partialSum) begin

        case(state)

            RESET: begin
                macOp = 0;
                next_state = MSB;
            end

            MSB: begin
                macOp = partialSum << 3;
                next_state = STAGETWO;
            end

            STAGETWO: begin
                macOp = macOp + (partialSum << 2);
                next_state = STAGETHREE;
            end            

            STAGETHREE: begin
                macOp = macOp + (partialSum << 1);
                next_state = FINALMAC;
            end

            FINALMAC: begin
                macOp = macOp + partialSum;
                op = macOp;
                next_state = RESET;
            end

            default: begin
                next_state = RESET;
            end

        endcase

    end

endmodule
