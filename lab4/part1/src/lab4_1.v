module lab4_1(
    input wire clk,
    input wire [2:0] A,
    input wire [2:0] B,
    output wire [6:0] result1,
    output wire [6:0] result2
);

lpm_rom_block mem_func({A, B}, clk, result1);
logic_block func(clk, A, B, result2);

endmodule
