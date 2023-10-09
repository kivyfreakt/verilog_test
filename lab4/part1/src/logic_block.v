module logic_block(
    input wire clk,
    input wire [2:0] A,
    input wire [2:0] B,
    output reg [6:0] result
);

wire [3:0] temp;
wire [6:0] temp_result;

adder i1(A, B, temp[3], temp[2:0]);
mult i2(~temp, A, temp_result);

always @(posedge clk)
    result <= temp_result;

endmodule
