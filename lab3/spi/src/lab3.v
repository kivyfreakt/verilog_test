module lab3
(
	input clk,
	input wire [7:0] data_in,
	input wire start,
    output wire mosi, sclk, ss,
	output wire [7:0] data_out,
	output wire ready
);


//wire mosi, sclk, ss;

master(clk, start, data_in, mosi, sclk, ss);
slave(sclk, mosi, ss, ready, data_out);

endmodule
