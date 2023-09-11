module slave
(
    input wire sclk,
    input wire mosi,
    input wire ss,
    output reg ready,
    // output wire error,
    output reg [8:0] data
);

// states for FSM
localparam [1:0]
        Wait = 2'b00,
        Init = 2'b01,
        Load = 2'b10,
        Done = 2'b11;

// reg [7:0] data;
reg [1:0] current_state, next_state;
reg [2:0] count;

always @(negedge sclk or negedge ss)
begin
    if (!ss)
        current_state = Init;
    else
        current_state = next_state;
end

always @(posedge sclk or negedge ss) begin
    if(!ss)
        count = 3'b000;
    else if (current_state == Load)
        count = count + 1;
    else
        count = 3'b000;
end


// FSM next_state states block and output block
always @(*)
begin	
    case (current_state)
            Wait: begin 
                ready = 1'b0;
                data = 8'b00000000;        
                next_state = Wait;
            end

            Init : begin
                ready = 1'b0;
                data = 8'b00000000;
                next_state = Load;
            end
            
            Load : begin
                ready = 1'b0;
                data[3'b111 - count] = mosi;
                
                if(count == 3'b111)
                    next_state = Done;
                else
                    next_state = current_state;
            end
            
            Done : begin
                ready = 1'b1;
                data = data;
                next_state = Wait;
            end
            
            default : begin
                ready = 1'b0;
                data = 8'b00000000;
                next_state = Wait;
            end
    endcase
end



endmodule
