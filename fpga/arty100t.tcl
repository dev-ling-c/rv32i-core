# Run from Vivado batch mode. Measures the core in isolation.
set root [file dirname [file dirname [file normalize [info script]]]]
set out [file join $root build arty100t]
file mkdir $out
foreach unit {riscv_types_pkg alu register imm_gen control pc dmem core} {
    read_verilog -sv [file join $root rtl ${unit}.sv]
}
synth_design -top core -part xc7a100tcsg324-1 -mode out_of_context
create_clock -name core_clk -period 10.000 [get_ports clk]
opt_design
place_design
route_design
report_utilization -hierarchical -file [file join $out utilization.rpt]
report_timing_summary -report_unconstrained -file [file join $out timing.rpt]
