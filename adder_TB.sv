`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024
// Design Name: 
// Module Name: ADDSUB_SEGDISPLAY_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Testbench for ADDSUB_SEGDISPLAY module
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module adder_TB();

    logic [3:0] TBA;      // Testbench input A
    logic [3:0] TBB;      // Testbench input B
    logic TBSUB;          // Add/Subtract signal
    logic CLR;            // Clear signal
    logic ENTER;          // Enter signal
    logic clk;            // Clock signal
    logic [7:0] TBseg;    // Seven-segment display output
    logic TBneg;          // Negative indicator
    logic [3:0] TBAn;     // Display enable signals

    // Instantiate the design under test (DUT)
    adder_sub UUT (
        .A(TBA),
        .B(TBB),
        .SUB(TBSUB),
        .CLR(CLR),
        .ENTER(ENTER),
        .clk(clk),
        .seg(TBseg),
        .An(TBAn)
    );

    // Clock generation
    always begin
        clk = 0;
        #5 clk = ~clk; // Generate a clock with a period of 10 ns
    end

    // Generate test cases
    always begin
        CLR = 1'b0; ENTER = 1'b1;

        // Test cases

        // 0 + 0
        #10 TBA = 4'b0000;
            TBB = 4'b0000;
            TBSUB = 1'b0;

        // 0 + 5
        #10 TBA = 4'b0000;
            TBB = 4'b0101;
            TBSUB = 1'b0;

        // 6 - 5
        #10 TBA = 4'b0110;
            TBB = 4'b0101;
            TBSUB = 1'b1;

        // 4 - 6 (Invalid case, result = 0)
        #10 TBA = 4'b0100;
            TBB = 4'b0110;
            TBSUB = 1'b1;

        // 10 - 10
        #10 TBA = 4'b1010;
            TBB = 4'b1010;
            TBSUB = 1'b1;

        // 8 - 4
        #10 TBA = 4'b1000;
            TBB = 4'b0100;
            TBSUB = 1'b1;

        // 1 - 8 (Invalid case, result = 0)
        #10 TBA = 4'b0001;
            TBB = 4'b1000;
            TBSUB = 1'b1;

        // 5 + 6
        #10 TBA = 4'b0101;
            TBB = 4'b0110;
            TBSUB = 1'b0;

        // 7 - 3
        #10 TBA = 4'b0111;
            TBB = 4'b0011;
            TBSUB = 1'b1;

        // 2 - 5 (Invalid case, result = 0)
        #10 TBA = 4'b0010;
            TBB = 4'b0101;
            TBSUB = 1'b1;

        // 9 + 1
        #10 TBA = 4'b1001;
            TBB = 4'b0001;
            TBSUB = 1'b0;

        // 3 - 3
        #10 TBA = 4'b0011;
            TBB = 4'b0011;
            TBSUB = 1'b1;

    end

endmodule
