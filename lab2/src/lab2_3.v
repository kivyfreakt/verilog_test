module lab2_3 (
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
    next_state[0] <= !current_state[0];
    next_state[1] <= current_state[1] && !current_state[0] || !current_state[1] && current_state[0];
    next_state[2] <= current_state[2] && !current_state[1] || current_state[2] && !current_state[0] || !current_state[3] && !current_state[2] && current_state[1] && current_state[0];
    next_state[3] <= current_state[3] && !current_state[1] || current_state[3] && !current_state[0] || current_state[2] && current_state[1] && current_state[0];
end

assign out = current_state;
assign overflow = (current_state == 4'd11);

endmodule
