module xilinx_one_port_ram_async #(
    parameter ADDR_WIDTH = 12,
    parameter DATA_WIDTH = 8
) (
    input wire [ADDR_WIDTH-1:0] i_addr,
    output wire [DATA_WIDTH*4-1:0] o_dout
);

  // Memoria: 2^ADDR_WIDTH direcciones de DATA_WIDTH bits (por defecto 8 bits)
  reg [DATA_WIDTH-1:0] ram[0:(1 << ADDR_WIDTH)-1];

  // Lectura asíncrona de 4 bytes consecutivos (una instrucción de 32 bits)
  assign o_dout = {ram[i_addr], ram[i_addr+1], ram[i_addr+2], ram[i_addr+3]};

endmodule
