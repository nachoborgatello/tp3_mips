module instruction_fetch (
    input wire i_clk,
    input wire i_reset,
    output wire [31:0] o_program_counter,
    output reg [31:0] o_instruction
);

  wire [31:0] instruction_from_mem;
  wire [31:0] instruction_addr;

  // Program Counter simple
  program_counter pc (
      .i_clk(i_clk),
      .i_reset(i_reset),
      .o_program_counter(o_program_counter)
  );

  // Memoria de instrucciones
  xilinx_one_port_ram_async #(
      .ADDR_WIDTH(8),
      .DATA_WIDTH(8)
  ) instruction_memory (
      .i_clk(i_clk),
      .i_write_enable(1'b0),  // Solo lectura
      .i_addr(instruction_addr[7:0]),
      .i_data(8'b0),          // No se usa en lectura
      .o_data(instruction_from_mem)
  );

  // Lectura de instrucción cada ciclo
  always @(posedge i_clk) begin
    if (i_reset) begin
      o_instruction <= 32'h00000000;
    end else begin
      o_instruction <= instruction_from_mem;
    end
  end

  assign instruction_addr = o_program_counter;

endmodule
