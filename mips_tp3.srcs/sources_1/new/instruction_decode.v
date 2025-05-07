module instruction_decode (
    input wire i_clk,
    input wire i_reset,
    input wire [31:0] i_instruction,
    input wire [31:0] i_data_WB,
    input wire [4:0] i_register_WB,
    input wire i_write_enable_WB,

    output reg [31:0] o_RA,
    output reg [31:0] o_RB,
    output reg [4:0] o_rs,
    output reg [4:0] o_rt,
    output reg [4:0] o_rd,
    output reg [5:0] o_funct,
    output reg [5:0] o_opcode,
    output reg [31:0] o_inmediato,
    output reg [4:0] o_shamt
);

    wire [4:0] rs = i_instruction[25:21];
    wire [4:0] rt = i_instruction[20:16];
    wire [4:0] rd = i_instruction[15:11];
    wire [4:0] shamt = i_instruction[10:6];
    wire [5:0] funct = i_instruction[5:0];
    wire [5:0] opcode = i_instruction[31:26];
    wire [31:0] inmediato = {{16{i_instruction[15]}}, i_instruction[15:0]};  // extensión de signo

    wire [31:0] RA_wire;
    wire [31:0] RB_wire;

    regfile #(
        .NB_REGISTER(32),
        .NB_ADDR(5)
    ) regfile_inst (
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_wr_enable(i_write_enable_WB),
        .i_w_addr(i_register_WB),
        .i_w_data(i_data_WB),
        .i_r_addr1(rs),
        .i_r_addr2(rt),
        .o_r_data1(RA_wire),
        .o_r_data2(RB_wire)
    );

    always @(posedge i_clk) begin
        if (i_reset) begin
            o_RA <= 0;
            o_RB <= 0;
            o_rs <= 0;
            o_rt <= 0;
            o_rd <= 0;
            o_funct <= 0;
            o_opcode <= 0;
            o_inmediato <= 0;
            o_shamt <= 0;
        end else begin
            o_RA <= RA_wire;
            o_RB <= RB_wire;
            o_rs <= rs;
            o_rt <= rt;
            o_rd <= rd;
            o_funct <= funct;
            o_opcode <= opcode;
            o_inmediato <= inmediato;
            o_shamt <= shamt;
        end
    end

endmodule
