module arty_top #(
    parameter string ROM_FILE = "led.mem"
) (
    input  logic clk,          // Arty 100 MHz oscillator
    input  logic reset_btn,    // BTN0, active high
    output logic led_o
);
    logic cpu_clk;
    logic locked;

    clk_wiz_0 clocks (
        .clk_in1(clk),
        .clk_out1(cpu_clk),
        .reset(reset_btn),
        .locked(locked)
    );

    // Assert reset immediately; release it after two locked CPU clock edges.
    wire reset_request = reset_btn || !locked;
    (* ASYNC_REG = "TRUE" *) logic [1:0] reset_pipe = 2'b00;
    always_ff @(posedge cpu_clk or posedge reset_request) begin
        if (reset_request)
            reset_pipe <= 2'b00;
        else
            reset_pipe <= {reset_pipe[0], 1'b1};
    end

    core_system #(.ROM_FILE(ROM_FILE)) system_i (
        .clk(cpu_clk),
        .rst_n(reset_pipe[1]),
        .led_o(led_o),
        .pc_o(),
        .illegal_inst_o(),
        .instr_addr_misaligned_o()
    );
endmodule
