module lab4_2(
    input wire rst,
    input wire rd_clk,
    input wire wr_clk,
    input wire [10:0] data_in,
    output wire [10:0] data_out,
    output wire rd_empty,
    output wire wr_full
);

reg [3:0] rd_pointer, rd_sync_1, rd_sync_2;
reg [3:0] wr_pointer, wr_sync_1, wr_sync_2;

wire [3:0] rd_pointer_g, rd_pointer_sync;
wire [3:0] wr_pointer_g, wr_pointer_sync;

reg wr_en;

// dual-port memory
mem m(
	.data(data_in),
	.rdaddress(rd_pointer),
	.rdclock(rd_clk),
	.wraddress(wr_pointer),
	.wrclock(wr_clk),
	.wren(wr_en),
	.q(data_out));

// write logic
always @(negedge wr_clk or posedge rst) 
begin
	if (rst) begin
		wr_pointer <= 0;
	end
	else if (wr_full == 1'b0) begin
		wr_pointer <= wr_pointer + 1'b1;
        wr_en <= 1'b1;
	end
end

// write pointer synchronizer controled by read clock
always @(posedge rd_clk) 
begin
	wr_sync_1 <= wr_pointer_g;
	wr_sync_2 <= wr_sync_1;
end

// read logic
always @(posedge rd_clk or posedge rst) begin
	if (rst) begin
		rd_pointer <= 0;
	end
	else if (rd_empty == 1'b0) begin
		rd_pointer <= rd_pointer + 1'b1;
	end
end

// read pointer synchronizer controled by write clock
always @(posedge wr_clk) begin
	rd_sync_1 <= rd_pointer_g;
	rd_sync_2 <= rd_sync_1;
end


// full/empty logic
assign wr_full  = ((wr_pointer[2 : 0] == rd_pointer_sync[2 : 0]) && 
				(wr_pointer[3] != rd_pointer_sync[3] ));

assign rd_empty = ((wr_pointer_sync == rd_pointer) == 0) ? 1'b1 : 1'b0;


// binary code to gray code converter logic
assign wr_pointer_g = wr_pointer ^ (wr_pointer >> 1);
assign rd_pointer_g = rd_pointer ^ (rd_pointer >> 1);

// gray code to binary code converter logic
assign wr_pointer_sync = wr_sync_2 ^ (wr_sync_2 >> 1) ^ 
						(wr_sync_2 >> 2) ^ (wr_sync_2 >> 3);
assign rd_pointer_sync = rd_sync_2 ^ (rd_sync_2 >> 1) ^ 
						(rd_sync_2 >> 2) ^ (rd_sync_2 >> 3);

endmodule
