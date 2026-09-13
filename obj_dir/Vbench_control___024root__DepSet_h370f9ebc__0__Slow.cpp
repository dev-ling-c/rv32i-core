// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vbench_control.h for the primary calling header

#include "Vbench_control__pch.h"
#include "Vbench_control__Syms.h"
#include "Vbench_control___024root.h"

VL_ATTR_COLD void Vbench_control___024root___eval_initial__TOP(Vbench_control___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vbench_control__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vbench_control___024root___eval_initial__TOP\n"); );
    // Init
    VlWide<5>/*159:0*/ __Vtemp_1;
    // Body
    __Vtemp_1[0U] = 0x2e766364U;
    __Vtemp_1[1U] = 0x74726f6cU;
    __Vtemp_1[2U] = 0x5f636f6eU;
    __Vtemp_1[3U] = 0x656e6368U;
    __Vtemp_1[4U] = 0x62U;
    vlSymsp->_vm_contextp__->dumpfile(VL_CVT_PACK_STR_NW(5, __Vtemp_1));
    vlSymsp->_traceDumpOpen();
    vlSelf->bench_control__DOT__clk = 0U;
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vbench_control___024root___dump_triggers__stl(Vbench_control___024root* vlSelf);
#endif  // VL_DEBUG

VL_ATTR_COLD void Vbench_control___024root___eval_triggers__stl(Vbench_control___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vbench_control__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vbench_control___024root___eval_triggers__stl\n"); );
    // Body
    vlSelf->__VstlTriggered.set(0U, (IData)(vlSelf->__VstlFirstIteration));
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vbench_control___024root___dump_triggers__stl(vlSelf);
    }
#endif
}
