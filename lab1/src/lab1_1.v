// 3, 4, 5, 7, 8, 10, 13, 14 
// truth table - 0001110110100110


module lab1_1 
(
    input  wire [3:0] x,
    output wire y
);

assign y = (!x[0] && !x[2] && x[3]) || (!x[1] && x[2] && !x[3]) || (x[0] && x[1] && !x[3]) || (x[0] && !x[1] && x[2]) || (!x[0] && x[1] && x[3]);

endmodule
