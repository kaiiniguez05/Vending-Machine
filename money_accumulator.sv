module accumulator (
    input  clk,
    input  LD,
    input  reset,
    input  [7:0] D,
    input  update_total_money,
    input  [7:0] remaining_money,
    output logic [7:0] Q = 0
);
    always_ff @(posedge clk) begin
        if (reset)
            Q <= 0;
        else if (update_total_money)
            Q <= remaining_money; // Load the remaining money
        else if (LD)
            Q <= Q + D;
    end
endmodule
