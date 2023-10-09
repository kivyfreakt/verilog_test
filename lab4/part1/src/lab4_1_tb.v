module lab4_1_tb;

reg clk;
reg [2:0] A;
reg [2:0] B;
wire [6:0] result1;
wire [6:0] result2;

integer i, j;

lab4_1 i1(clk, A, B, result1, result2);

initial 
begin 
    clk = 0;
    for (i = 0; i < 8; i = i + 1)
    begin
        for (j = 0; j < 8; j = j + 1)
        begin
            #10 clk = ~clk;
            A = i;
            B = j;
        end
    end
end

endmodule
