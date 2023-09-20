module rx
(
    input wire clk,
    input wire s_in,
    output wire ready,
    output wire [7:0] data
);

    // reg [7:0] data_out;
    // reg [3:0] count;


    // // понизить частоту

    // assign ready = (count == 4'b1011) ? 1'b1 : 1'b0;
    // assign error = (ready == 1'b1) ? ( () ? 1'b0 : 1'b1) : 1'b0;
    // assign data = (ready == 1'b1) ? data_out : 8'b00000000;
    
    // always @(posedge sclk) 
    // begin
    //         count <= count + 1'b1;
    //         data_out <= {data_out[6:0], s_in};
    // end
endmodule