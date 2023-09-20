module main
(
    input wire clk,
    input wire [7:0] data_in,
    input wire start,
    output wire [7:0] data_out,
    output wire ready
);

wire data;

// uart_baud_rate(.clk(clk), .tx_clk(tx_clk));

tx t(clk, start, data_in, data);
rx r(clk, data, ready, data_out);

endmodule
