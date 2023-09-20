module shift(
    input wire clk, rst,
    input wire shift_en, load,
    input wire [7:0] data_in,
    output wire s_out
);
    reg [7:0] data;
    assign s_out = data[7];
    
    always @(negedge clk or posedge rst) 
    begin
        if (rst)
            data = 8'b00000000;
        else
        begin
            if(load)
                data = data_in; 
            else if (shift_en)
                data = {data[6:0], 1'b0};
            else
                data = data;
        end
    end

endmodule
