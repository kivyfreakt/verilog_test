// 3, 4, 5, 7, 8, 10, 13, 14 
// truth table - 0001110110100110


module lab1_3
(
    input  wire [3:0] x,
    output wire y
);

wire [7:0] temp;

decode (x, temp[0], temp[1], temp[2], temp[3], temp[4], temp[5], temp[6], temp[7]);

assign y = ^temp;


endmodule
