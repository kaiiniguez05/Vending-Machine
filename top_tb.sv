module top_tb();
    logic  clk_tb;
    logic  reset_tb;
    logic  one_tb, five_tb, ten_tb;    // Button inputs representing coins
    logic  [3:0] item_input_tb;    // Button inputs for item selection
    logic  buy_button_tb;           // Buy button
    logic  [7:0] segs_tb; // Value to be displayed
    logic  [3:0] an_tb;
    
    
     top_module UUT(
    .clk(clk_tb), 
    .reset(reset_tb),
    .one(one_tb),
    .five(five_tb),
    .ten(ten_tb),
    .item_input(item_input_tb),
    .buy_button(buy_button_tb),
    .segs(segs_tb),
    .an(an_tb)
    );
    
    always begin//creates clock
    
    clk_tb = 0;
    #5;
    clk_tb = 1;
    #5;
    end
    
    always begin//beginning of test cases
    reset_tb = 0;
    buy_button_tb = 0;
    #20//tests one dollar deposit
    one_tb = 1;
    #20
    one_tb = 0;
    
    #10//tests five dollar deposit
    five_tb = 1;
    #10
    five_tb = 0;
    
    #10//tests 10 dollar deposit
    ten_tb = 1;
    #10
    ten_tb = 0;
    
    #10//
    item_input_tb = 3'b001;
    
    #10
    item_input_tb = 3'b010;
    
    #10
    item_input_tb = 3'b100;
    
    #10
    item_input_tb = 3'b010;

    end
    
    

endmodule