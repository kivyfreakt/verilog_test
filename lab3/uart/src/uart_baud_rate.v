module uart_baud_rate(
    input wire clk,
    output reg tx_clk
);

parameter CLOCK_RATE = 40_000_000;
parameter BAUD_RATE = 9600;

localparam MAX_RATE_TX = CLOCK_RATE / (2 * BAUD_RATE);
localparam TX_CNT_WIDTH = $clog2(MAX_RATE_TX);

reg [TX_CNT_WIDTH - 1:0] cntr = 0;

always @(posedge clk) 
begin
    if (cntr == MAX_RATE_TX) 
    begin
        cntr <= 0;
        tx_clk <= ~tx_clk;
    end
    else 
        cntr <= cntr + 1'b1;
end

endmodule
