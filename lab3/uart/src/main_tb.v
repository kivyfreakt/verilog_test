module main_tb;

reg reset, clock;
reg [7:0] in_data;
wire [7:0] out_data;
wire ready;
wire error;

integer takt;

main m(clock, in_data, reset, out_data, error, ready);

initial 
begin 
    clock = 'b0;
    reset = 'b0;
    #5 reset = 'b1;
    #10 reset = 'b0;
    #5;
    for (takt = 0; takt < 40; takt = takt + 1)
    begin
        in_data = 8'b10001011;
        #5 clock = 'b1;
        #10 clock = 'b0;
        #20;
    end
    // $finish; 
end

endmodule
