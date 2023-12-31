module master_ctrl
(
    input wire clk, // clock
    input wire rst, // async clear
    output reg shift_en, // shift enable0
    output reg load, // load data to shift reg
    output wire sclk, // serial clock
    output reg ss // slave select
);

// states for FSM
localparam [1:0]
        Init = 2'b00,
        Load = 2'b01,
        Shift = 2'b10,
        Done = 2'b11;
        
reg [1:0] current_state, next_state;
reg [3:0] count;
reg clk_en;

assign sclk = clk_en & clk; // output the clock when needed

always @(posedge clk or posedge rst)
begin
    if (rst)
        current_state <= Init;
    else
        current_state <= next_state;
end

always @(negedge clk or posedge rst) begin
    if(rst)
        count <= 4'b0000;
    else if (current_state == Load)
        count <= 4'b0000;
    else if (current_state == Shift)
        count <= count + 1'b1;
    else
        count <= 4'b0000;
end

// FSM next_state states block and output block
always @(*)
begin	
    case (current_state)
            Init : begin
                {shift_en, load, clk_en, ss} <= 4'b0001;
                next_state <= Load;
            end
            
            Load : begin
                {shift_en, load, clk_en, ss} <= 4'b0100;			 
                next_state <= Shift;
            end
            
            Shift : begin
                {shift_en, load, ss} <= 3'b101;
                
                if(count == 4'b1000)
                begin
                    next_state <= Done;
                    clk_en <= 1'b0;
                end
                else
                begin
                    clk_en <= 1'b1;
                    next_state <= current_state;
                end
            end
            
            Done : begin
                {shift_en, load, clk_en, ss} <= 4'b0001;
                next_state <= Load;
            end
            
            default : begin
                {shift_en, load, clk_en, ss} <= 4'b0001;
                next_state <= Init;
            end
    endcase
end

endmodule
