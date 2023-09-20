module slave
(
    input wire sclk,
    input wire mosi,
    input wire ss,
    output wire ready,
    output wire [7:0] data
);

    reg [7:0] data_out;
    reg [3:0] count;

    assign ready = (count == 4'b1000) ? 1'b1 : 1'b0;
    assign data = (ready == 1'b1) ? data_out : 8'b00000000;
    
    always @(posedge sclk or negedge ss) 
    begin
        if (!ss) begin
            count <= 4'b0000;
            data_out <= 8'b00000000;
        end
        else begin
            count <= count + 1'b1;
            data_out <= {data_out[6:0], mosi};
        end
    end
endmodule