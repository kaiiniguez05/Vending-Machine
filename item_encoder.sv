module item_encoder (
    input logic [3:0] item_input,
    output logic [2:0] item_cost
);
    always_comb begin
        if (item_input == 4'b0001) begin
        item_cost = 3'b001;
        end
        else if (item_input == 4'b0010) begin
        item_cost = 3'b010;
        end
        else if (item_input == 4'b0100) begin
        item_cost = 3'b011;
        end
        else if (item_input == 4'b1000) begin
        item_cost = 3'b101;
        end        
    end
endmodule
