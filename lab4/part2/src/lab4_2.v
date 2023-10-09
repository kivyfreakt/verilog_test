module lab4_2(
    input wire rst,
    input wire rd_clk,
    input wire wr_clk,
    input wire wr_en,
    input wire rd_en,
    input wire [10:0] data_in,
    output wire [10:0] data_out,
    output wire rd_empty,
    output wire wr_full
);

reg [3:0] wr_pointer, rd_pointer;

always @(negedge wr_clk or posedge rst) begin
	if(rst)
		wr_pointer <= 4'b1101;
	else 
		if(wr_en && !wr_full)
			wr_pointer <= wr_pointer - 1'b1;
        else
            wr_pointer <= wr_pointer;
end


always @(posedge rd_clk or posedge rst) begin
	if(rst)
		rd_pointer <= 4'b1101;
	else 
		if(rd_en && !rd_empty)
			rd_pointer <= rd_pointer - 1'b1;
        else
            rd_pointer <= rd_pointer;
end

assign wr_full = (wr_pointer == 4'b0000) ? 1'b1 : 1'b0; 
assign rd_empty = (rd_pointer == 4'b1111) ? 1'b1 : 1'b0;    

mem m(
	.data(data_in),
	.rdaddress(rd_pointer),
	.rdclock(rd_clk),
	.wraddress(wr_pointer),
	.wrclock(wr_clk),
	.wren(wr_en),
    .rden(rd_en),
	.q(data_out)
);


endmodule
