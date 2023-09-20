module tx
#
(
    parameter DATA_WIDTH = 8
)
(
    input wire clk, rst,
    input wire [DATA_WIDTH - 1 : 0] data_in,
    output wire tx_data
);
    wire shift_en, load;
    wire tx_clk;

    assign tx_clk = clk;

    // uart_baud_rate baud(
    //     .clk(clk),
    //     .tx_clk(tx_clk)
    // );

    tx_shift shift(
        .clk(tx_clk), 
        .rst(rst),
        .shift_en(shift_en),
        .load(load),
        .data_in(data_in), 
        .s_out(tx_data)
    );

    tx_ctrl ctrl(
        .clk(clk),
        .rst(rst),
        .shift_en(shift_en),
        .load(load)
    );

endmodule
