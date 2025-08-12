`timescale 1ns / 1ps

module design_1_tb;

    // Inputs to the DUT (Device Under Test)
    reg [3:0] a_tb;
    reg [3:0] b_tb;
    reg clk_tb;
    reg rst_tb;

    // Outputs from the DUT
    wire [7:0] final_op_tb;
    wire op_valid_tb;

    // Instantiate the wrapper module
    design_1_wrapper DUT (
        .a(a_tb),
        .b(b_tb),
        .clk(clk_tb),
        .op(final_op_tb),
        .op_valid(op_valid_tb),
        .rst(rst_tb)
    );

    // Clock generation: A 10ns period (100 MHz) clock is used to provide
    // multiple clock cycles between each 20ns input change.
    always begin
        #5 clk_tb = ~clk_tb;
    end

    // Stimulus block
    initial begin
        // 1. Initialize all signals and assert reset.
        clk_tb = 0;
        rst_tb = 1; // Assert reset to initialize the design
        a_tb   = 4'b0;
        b_tb   = 4'b0;
        
        // Use $monitor to print the values whenever a signal changes.
        $display("Time(ns)\t| clk | rst | a\t | b\t | op_valid | final_op");
        $display("--------------------------------------------------------------------");
        $monitor("%0t\t| %b   | %b   | %b | %b | %b        | %h", 
                 $time, clk_tb, rst_tb, a_tb, b_tb, op_valid_tb, final_op_tb);

        // Hold reset for a few cycles to ensure proper initialization
        #30;
        rst_tb = 0; // De-assert reset so the FSM can start

        // 2. Apply the specified input sequence.
        
        // After 20ns, apply the next set of inputs
        #20;
        a_tb = 4'b1101; // a = 13
        b_tb = 4'b1100; // b = 12

        // After another 20ns, apply the next set
        #10;
        a_tb = 4'b1101; // a = 13
        b_tb = 4'b0000; // b = 0

        // After another 20ns, apply the final set (values are the same as previous)
        #10;
        a_tb = 4'b1101; // a = 13
        b_tb = 4'b0000; // b = 0

        // 3. Let the simulation run for a bit longer to observe the final state.
        #40;
        
        // 4. End the simulation.
        $display("\n--- Testbench Finished ---");
        $finish;
    end

endmodule
