module top_module (
    input  clk,
    input  reset,
    input  one, five, ten,    // Button inputs representing coins
    input  [3:0] item_input,     // Button inputs for item selection
    input  buy_button,           // Buy button
    output  [7:0] segs, // Value to be displayed
    output  [3:0] an
);
    logic [3:0] coin_value;
    logic [2:0] item_cost;
    logic [7:0] total_money;
    logic [4:0] fsm_state;


    //coin encoder
    coin_encoder coin_encoder0 (
        .one(one),
        .five(five),
        .ten(ten),        
        .coin_value(coin_value)
    );

    //cost encoder
    item_encoder item_encoder0 (
        .item_input(item_input),
        .item_cost(item_cost)
    );

    // Instantiate accumulator
    accumulator money_accumulator (
        .clk(clk),
        .reset(reset),
        .LD(one | five | ten),
        .D({4'b0000,coin_value}),
        .Q(total_money)
    );

    // Instantiate FSM
    fsm fsm (
        .clk(clk),
        .reset(reset),
        .item_selected(item_input),
        .item_cost({5'b00000,item_cost}),
        .total_money(total_money),
        .buy_button(buy_button),
        .state(fsm_state)
    );

    //7-segment Display
    univ_sseg univ_segg0 (
        .clk(clk),
        .valid(1'b1),
        .cnt1({9'b000000000,fsm_state}),
        .ssegs(segs),
        .disp_en(an)
     );
endmodule
