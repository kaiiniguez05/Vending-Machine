module adder_sub(
    input [3:0] A,
    input [3:0] B,
    input SUB,
    input CLR,
    input ENTER,
    input clk,
    output [7:0] seg,
    output [3:0] An
);

    logic [3:0] t1;          // Adjusted B for subtraction
    logic [3:0] t3;          // Result from RCA
    logic [3:0] t4;          // Alternative result (for invalid cases)
    logic [3:0] t5;          // Final result to display
    logic t6;                // Validity flag
    logic t7;                // Indicates invalid subtraction
    logic t8;                // Stored validity
    logic t9;                // Sign indicator
    logic [3:0] t10;         // Stored result for display

    // Adjust B for subtraction
    MUX2 MUX1 (
        .MUX_A(B),
        .MUX_B(~B),         // ~B for subtraction
        .MUX_SEL(SUB),
        .MUX_OUT(t1)
    );

    // Perform addition or subtraction using RCA
    RCA_FAONLY RCA1 (
        .RCA_A(A),
        .RCA_B(t1),
        .RCA_Ci(SUB),       // Carry-in is 1 for subtraction
        .RCA_S(t3)
    );

    // Compute alternative result for invalid cases
    RCA_FAONLY RCA2 (
        .RCA_A(~t3),
        .RCA_B(4'b0000),
        .RCA_Ci(1'b1),
        .RCA_S(t4)
    );

    // Check validity of subtraction
    VALIDITY1 ValidityChecker (
        .V_A(A[3]),         // MSB of A
        .V_B(t1[3]),        // MSB of Adjusted_B
        .V_S(t3[3]),        // MSB of Result
        .V_OUT(t6)
    );

    // Determine if subtraction is invalid
    assign t7 = t3[3] & t6;

    // Select correct result for display
    MUX2 MUX2 (
        .MUX_A(t3),         // Use RCA result if valid
        .MUX_B(t4),         // Use alternative result if invalid
        .MUX_SEL(t7),
        .MUX_OUT(t5)
    );

    // Store validity and result
    DFF ValidityDFF (
        .clk(clk),
        .EN(ENTER),
        .RST(1'b0),
        .D(t6),
        .SET(CLR),
        .Q(t8)
    );
    DFF SignDFF (
        .clk(clk),
        .EN(ENTER),
        .RST(CLR),
        .D(t7),
        .SET(1'b0),
        .Q(t9)
    );
    FOURREG ResultReg (
        .clk(clk),
        .EN(ENTER),
        .RST(CLR),
        .D(t5),
        .SET(1'b0),
        .Q(t10)
    );

    // Display result on seven-segment display
    univ_sseg UNISEG (
        .clk(clk),
        .cnt1(t10),
        .sign(t9),
        .valid(t8),
        .cnt2(7'b0000000),
        .dp_en(1'b0),
        .dp_sel(2'b00),
        .mod_sel(2'b00),
        .ssegs(seg),
        .disp_en(An)
    );

endmodule
