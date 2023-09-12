module master
(
    input wire clk, rst,
    input wire [7:0] data_in,
    output wire mosi, sclk, ss
);
    wire shift_en, load;
    
    master_ctrl ctrl(
        .clk(clk),
        .rst(rst),
        .shift_en(shift_en),
        .load(load),
        .sclk(sclk),
        .ss(ss)
    );

    shift shift(
        .clk(clk), 
        .rst(rst), 
        .shift_en(shift_en), 
        .load(load),
        .data_in(data_in), 
        .s_out(mosi)
    );

endmodule
