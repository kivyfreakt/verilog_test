module lab4_1_tb;

reg clk;
wire [2:0] A;
wire [2:0] B;
wire [6:0] result1;
// output wire [6:0] result2

integer i;

lab4_1(clk, A, B, result1);

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
