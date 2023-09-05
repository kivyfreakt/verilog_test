// 3, 4, 5, 7, 8, 10, 13, 14 
// truth table - 0001110110100110


module lab1_2
(
    input  wire [3:0] x,
    output wire y
);

wire [3:0] temp;

mux_ m1('b0, 'b0, 'b0, 'b1, {x[0], x[1]}, temp[0]);
mux_ m2('b1, 'b1, 'b0, 'b0, {x[0], x[1]}, temp[1]);
mux_ m3('b1, 'b0, 'b1, 'b1, {x[0], x[1]}, temp[2]);
mux_ m4('b0, 'b1, 'b1, 'b0, {x[0], x[1]}, temp[3]);

mux_ m5(temp[0], temp[1], temp[2], temp[3], {x[2], x[3]}, y);


endmodule
