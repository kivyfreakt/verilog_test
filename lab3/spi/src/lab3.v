module lab3
(
    input wire clk,
    input wire [7:0] data_in,
    input wire start,
    output wire [7:0] data_out,
    output wire ready
);

wire mosi, sclk, ss;

master m(clk, start, data_in, mosi, sclk, ss);
slave s(sclk, mosi, ss, ready, data_out);

endmodule
