// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vbench_control__Syms.h"


void Vbench_control___024root__trace_chg_0_sub_0(Vbench_control___024root* vlSelf, VerilatedVcd::Buffer* bufp);

void Vbench_control___024root__trace_chg_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vbench_control___024root__trace_chg_0\n"); );
    // Init
    Vbench_control___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vbench_control___024root*>(voidSelf);
    Vbench_control__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    Vbench_control___024root__trace_chg_0_sub_0((&vlSymsp->TOP), bufp);
}

void Vbench_control___024root__trace_chg_0_sub_0(Vbench_control___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Vbench_control__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vbench_control___024root__trace_chg_0_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    // Body
    if (VL_UNLIKELY((vlSelf->__Vm_traceActivity[1U] 
                     | vlSelf->__Vm_traceActivity[2U]))) {
        bufp->chgIData(oldp+0,(vlSelf->bench_control__DOT__inst_i),32);
        bufp->chgIData(oldp+1,(vlSelf->bench_control__DOT__test_inst[0]),32);
        bufp->chgIData(oldp+2,(vlSelf->bench_control__DOT__test_inst[1]),32);
        bufp->chgIData(oldp+3,(vlSelf->bench_control__DOT__test_inst[2]),32);
        bufp->chgIData(oldp+4,(vlSelf->bench_control__DOT__test_inst[3]),32);
        bufp->chgIData(oldp+5,(vlSelf->bench_control__DOT__pass_count),32);
        bufp->chgIData(oldp+6,(vlSelf->bench_control__DOT__fail_count),32);
        bufp->chgCData(oldp+7,((0x7fU & vlSelf->bench_control__DOT__inst_i)),7);
        bufp->chgCData(oldp+8,((7U & (vlSelf->bench_control__DOT__inst_i 
                                      >> 0xcU))),3);
        bufp->chgCData(oldp+9,((vlSelf->bench_control__DOT__inst_i 
                                >> 0x19U)),7);
        bufp->chgIData(oldp+10,(vlSelf->bench_control__DOT__unnamedblk1__DOT__i),32);
    }
    if (VL_UNLIKELY((vlSelf->__Vm_traceActivity[3U] 
                     | vlSelf->__Vm_traceActivity[4U]))) {
        bufp->chgCData(oldp+11,(vlSelf->bench_control__DOT__alu_op_o),4);
        bufp->chgCData(oldp+12,(vlSelf->bench_control__DOT__inst_format_o),2);
        bufp->chgBit(oldp+13,(vlSelf->bench_control__DOT__alu_b_imm_o));
        bufp->chgBit(oldp+14,(vlSelf->bench_control__DOT__reg_write_en_o));
        bufp->chgBit(oldp+15,(vlSelf->bench_control__DOT__illegal_inst_o));
    }
    bufp->chgBit(oldp+16,(vlSelf->bench_control__DOT__clk));
}

void Vbench_control___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vbench_control___024root__trace_cleanup\n"); );
    // Init
    Vbench_control___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vbench_control___024root*>(voidSelf);
    Vbench_control__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    vlSymsp->__Vm_activity = false;
    vlSymsp->TOP.__Vm_traceActivity[0U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[1U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[2U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[3U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[4U] = 0U;
}
