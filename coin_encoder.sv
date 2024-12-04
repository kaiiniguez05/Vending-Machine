module coin_encoder (
    input logic one,
    input logic five,
    input logic ten,
    output logic [3:0] coin_value
);
    always_comb begin
        if (one) begin
            coin_value = 4'b0001;
            end
        else if(five) begin
            coin_value = 4'b0101;
            end
        else if (ten) begin
            coin_value = 4'b1010;
            end    
    end
endmodule
