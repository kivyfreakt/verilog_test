module lab2_1 (
    input wire clock,
    input wire reset,
    output wire overflow,
    output wire [3:0] out
);

reg [3:0] counter;

always @(posedge clock, posedge reset) 
begin
    if (reset)
        counter <= 4'd0;
    else
        if (counter == 4'd11)
            counter <= 4'd0;
        else
            counter <= counter + 1'd1;
end

assign out = counter;
assign overflow = (counter == 4'd11);

endmodule
