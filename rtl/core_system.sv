// A 1 KiB, word-wide ROM on the core's instruction port.
module core_system #(
    parameter string ROM_FILE = "build/tests/led.hex"
) (
    input  logic clk,
    input  logic rst_n,
    output logic [31:0] pc_o,
    output logic illegal_inst_o,
    output logic instr_addr_misaligned_o,
    output logic led_o
);
    logic [31:0] rom [0:255];
    logic [31:0] instruction;

    initial begin
        for (int i = 0; i < 256; i++) rom[i] = '0;
        $readmemh(ROM_FILE, rom);
    end

    // Byte addresses 0, 4, 8, ... select ROM words 0, 1, 2, ...
    assign instruction = pc_o < 1024 ? rom[pc_o[9:2]] : 32'b0;

    logic [31:0] data_addr, store_data;
    logic store_valid, led_selected;

    // Only the low byte of the LED register is implemented.
    localparam logic [31:0] LED_ADDR = 32'h0000_1000;
    assign led_selected = data_addr[31:2] == LED_ADDR[31:2];
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) led_o <= 1'b0;
        else if (led_selected && store_valid && data_addr[1:0] == 0)
            led_o <= store_data[0];
    end

    core cpu (
        .clk(clk),
        .rst_n(rst_n),
        .inst_i(instruction),
        .pc_o(pc_o),
        .illegal_inst_o(illegal_inst_o),
        .instr_addr_misaligned_o(instr_addr_misaligned_o),
        .data_addr_o(data_addr), .store_data_o(store_data), .store_valid_o(store_valid),
        .io_selected_i(led_selected), .io_rdata_i({31'b0, led_o && data_addr[1:0] == 0})
    );
endmodule
