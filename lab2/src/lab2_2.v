module lab2_2 (
    input wire clock,
    input wire reset,
    output wire overflow,
    output wire [3:0] out
);

reg [3:0] current_state, next_state;

always @(posedge clock, posedge reset) 
begin
    if (reset)
        current_state <= 4'd0;
    else
        current_state <= next_state;
end

always @(current_state)
begin
	case (current_state)
		4'b0000: next_state <= 4'b0001;
		4'b0001: next_state <= 4'b0010;
		4'b0010: next_state <= 4'b0011;
		4'b0011: next_state <= 4'b0100;
		4'b0100: next_state <= 4'b0101;
		4'b0101: next_state <= 4'b0110;
		4'b0110: next_state <= 4'b0111;
		4'b0111: next_state <= 4'b1000;
		4'b1000: next_state <= 4'b1001;
		4'b1001: next_state <= 4'b1010;
		4'b1010: next_state <= 4'b1011;
		default: next_state <= 4'b0000;
	endcase
end

assign out = current_state;
assign overflow = (current_state == 4'd11);

endmodule
