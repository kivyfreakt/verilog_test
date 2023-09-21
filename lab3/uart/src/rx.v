module rx
(
    input wire clk,
    input wire s_in,
    output wire ready,
    output wire error,
    output wire [7:0] data
);

localparam
        Init = 1'b0,
        Data = 1'b1;
        
reg current_state;
reg [3:0] count;
reg [8:0] data_;

assign ready = (count == 4'b1001) ? 1'b1 : 1'b0;
assign data = (ready == 1'b1) ? data_[8:1] : data;
assign error = (ready == 1'b1) ? (((~^data_[8:1]) == data_[0]) ? 1'b0 : 1'b1) : 1'b0;

always @(negedge clk)
begin
    case (current_state)
            Init : begin
                data_ <= 9'b000000000;
                count <= 4'b0000;

                if (s_in == 1'b0)
                    current_state <= Data;
                else
                    current_state <= Init;
            end
            
            Data : begin
                data_[4'b1000 - count] <= s_in;

                if(count == 4'b1001)
                begin
                    count <= 4'b0000;
                    current_state <= Init;
                end
                else
                begin
                    current_state <= Data;
                    count <= count + 1'b1;
                end
            end
            
            default : begin
                count <= 4'b0000;
                data_ <= data_;
                current_state <= Init;
            end
    endcase
end


endmodule
