module program_counter (
    input wire i_clk,
    input wire i_reset,
    output reg [31:0] o_program_counter
);

    always @(posedge i_clk) begin
        if (i_reset) begin
            o_program_counter <= 32'h00000000;
        end else begin
            o_program_counter <= o_program_counter + 4;
        end 
    end

endmodule
