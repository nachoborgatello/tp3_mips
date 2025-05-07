module instruction_execute (
    input wire i_clk,
    input wire i_reset,
    input wire [31:0] i_RA,
    input wire [31:0] i_RB,
    input wire [4:0] i_rt,
    input wire [4:0] i_rd,
    input wire [5:0] i_funct,
    input wire [5:0] i_opcode,
    input wire [31:0] i_inmediato,
    input wire [4:0] i_shamt,
    input wire i_EX_alu_src,       // 1: inmediato, 0: RB
    input wire i_EX_reg_dst,       // 1: rd, 0: rt
    input wire [1:0] i_EX_alu_op,  // 00: load/store, 10: tipo R, 11: inmediato

    output reg [4:0] o_write_reg,
    output reg [31:0] o_ALU_result
);

    reg [31:0] ALU_data_B;
    reg [5:0] ALU_op;
    wire [31:0] ALU_result_wire;

    // Elegir operando B: inmediato o RB
    always @(*) begin
        if (i_EX_alu_src)
            ALU_data_B = i_inmediato;
        else
            ALU_data_B = i_RB;
    end

    // Elegir operación ALU
    localparam ADD_OP   = 6'b100000;
    localparam IDLE_OP  = 6'b111111;
    localparam OPCODE_R = 6'b000000;

    always @(*) begin
        case (i_EX_alu_op)
            2'b00: ALU_op = ADD_OP;          // load/store
            2'b10: ALU_op = i_funct;         // tipo R
            2'b11: ALU_op = i_opcode;        // inmediato
            default: ALU_op = IDLE_OP;
        endcase
    end

    // Resultado ALU
    always @(posedge i_clk) begin
        if (i_reset) begin
            o_ALU_result <= 0;
        end else begin
            o_ALU_result <= ALU_result_wire;
        end
    end

    // Registro destino
    always @(posedge i_clk) begin
        if (i_reset) begin
            o_write_reg <= 0;
        end else begin
            o_write_reg <= i_EX_reg_dst ? i_rd : i_rt;
        end
    end

    // ALU real
    alu #(
        .NB_OP(6),
        .NB_DATA(32)
    ) alu_inst (
        .i_op(ALU_op),
        .i_data_A(i_RA),
        .i_data_B(ALU_data_B),
        .i_shamt(i_shamt),
        .o_data(ALU_result_wire)
    );

endmodule
