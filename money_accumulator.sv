module accumulator(
    input clk, LD, reset,
    input [7:0] D,
    output logic [7:0] Q = 0
    );
    
    always_ff @ (posedge clk)
    begin
        if (reset)
            Q <= 0;
        else if (LD)
            Q <= D + Q;
         
    
    end
endmodule
