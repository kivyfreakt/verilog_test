module uart_tx
#
(
    parameter DATA_WIDTH = 8,
    PARITY_BIT = 1,
    STOP_BITS = 1,
    BAUD_RATE = 9600
)
(
    input wire clk, rst,
    input wire [DATA_WIDTH - 1 : 0] data_in,
    output wire tx_data, done
);
    wire shift_en, load;
    wire tx_clk;

    uart_baud_rate baud(
        .clk(clk),
        .tx_clk(tx_clk)
    );

    uart_shift shift(
        .clk(tx_clk), 
        .rst(rst),
        .shift_en(shift_en),
        .load(load),
        .data_in(data_in), 
        .s_out(tx_data)
    );

    uart_ctrl ctrl(
        .clk(clk),
        .rst(rst),
        .shift_en(shift_en),
        .done(done),
        .load(load)
    );

endmodule
