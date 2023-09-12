module uart_shift
#
(
	parameter DATA_WIDTH = 8
)
(
    input wire clk, rst,
    input wire shift_en, load,
    input wire [DATA_WIDTH - 1:0] data_in,
    output wire s_out
);
    localparam PACKAGE_WIDTH = 11;
    reg [PACKAGE_WIDTH - 1:0] data;

    assign s_out = data[DATA_WIDTH - 1];
    
    always @(posedge clk or posedge rst) 
    begin
        if (rst)
            data = 0;
        else if(load)
            // start_bit, data, parity, stop_bit(s)
            data = {1'b0, data_in, data_in%2, 1'b1};
        else if (shift_en)
            data = {data[PACKAGE_WIDTH - 1:0], 1'b0};
        else
            data = data;
    end

endmodule
