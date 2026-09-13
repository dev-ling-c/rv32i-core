// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vbench_control.h for the primary calling header

#include "Vbench_control__pch.h"
#include "Vbench_control___024root.h"

VL_ATTR_COLD void Vbench_control___024root___eval_initial__TOP(Vbench_control___024root* vlSelf);
VlCoroutine Vbench_control___024root___eval_initial__TOP__Vtiming__0(Vbench_control___024root* vlSelf);
VlCoroutine Vbench_control___024root___eval_initial__TOP__Vtiming__1(Vbench_control___024root* vlSelf);

void Vbench_control___024root___eval_initial(Vbench_control___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vbench_control__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vbench_control___024root___eval_initial\n"); );
    // Body
    Vbench_control___024root___eval_initial__TOP(vlSelf);
    vlSelf->__Vm_traceActivity[1U] = 1U;
    Vbench_control___024root___eval_initial__TOP__Vtiming__0(vlSelf);
    Vbench_control___024root___eval_initial__TOP__Vtiming__1(vlSelf);
    vlSelf->__Vtrigprevexpr___TOP__bench_control__DOT__clk__0 
        = vlSelf->bench_control__DOT__clk;
}

VL_INLINE_OPT VlCoroutine Vbench_control___024root___eval_initial__TOP__Vtiming__1(Vbench_control___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vbench_control__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vbench_control___024root___eval_initial__TOP__Vtiming__1\n"); );
    // Body
    while (1U) {
        co_await vlSelf->__VdlySched.delay(0xaULL, 
                                           nullptr, 
                                           "testbenches/bench_control.sv", 
                                           40);
        vlSelf->bench_control__DOT__clk = (1U & (~ (IData)(vlSelf->bench_control__DOT__clk)));
    }
}

VL_INLINE_OPT void Vbench_control___024root___act_sequent__TOP__0(Vbench_control___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vbench_control__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vbench_control___024root___act_sequent__TOP__0\n"); );
    // Body
    vlSelf->bench_control__DOT__illegal_inst_o = 1U;
    vlSelf->bench_control__DOT__alu_op_o = 0U;
    vlSelf->bench_control__DOT__inst_format_o = 0U;
    vlSelf->bench_control__DOT__alu_b_imm_o = 0U;
    vlSelf->bench_control__DOT__reg_write_en_o = 0U;
    if ((0x33U == (0x7fU & vlSelf->bench_control__DOT__inst_i))) {
        if ((0x4000U & vlSelf->bench_control__DOT__inst_i)) {
            if ((0x2000U & vlSelf->bench_control__DOT__inst_i)) {
                if ((0x1000U & vlSelf->bench_control__DOT__inst_i)) {
                    if ((0U == (vlSelf->bench_control__DOT__inst_i 
                                >> 0x19U))) {
                        vlSelf->bench_control__DOT__illegal_inst_o = 0U;
                        vlSelf->bench_control__DOT__alu_op_o = 2U;
                        vlSelf->bench_control__DOT__reg_write_en_o = 1U;
                    }
                } else if ((0U == (vlSelf->bench_control__DOT__inst_i 
                                   >> 0x19U))) {
                    vlSelf->bench_control__DOT__illegal_inst_o = 0U;
                    vlSelf->bench_control__DOT__alu_op_o = 3U;
                    vlSelf->bench_control__DOT__reg_write_en_o = 1U;
                }
            } else if ((0x1000U & vlSelf->bench_control__DOT__inst_i)) {
                if ((0U == (vlSelf->bench_control__DOT__inst_i 
                            >> 0x19U))) {
                    vlSelf->bench_control__DOT__illegal_inst_o = 0U;
                    vlSelf->bench_control__DOT__alu_op_o = 8U;
                    vlSelf->bench_control__DOT__reg_write_en_o = 1U;
                } else if ((0x20U == (vlSelf->bench_control__DOT__inst_i 
                                      >> 0x19U))) {
                    vlSelf->bench_control__DOT__illegal_inst_o = 0U;
                    vlSelf->bench_control__DOT__alu_op_o = 9U;
                    vlSelf->bench_control__DOT__reg_write_en_o = 1U;
                }
            } else if ((0U == (vlSelf->bench_control__DOT__inst_i 
                               >> 0x19U))) {
                vlSelf->bench_control__DOT__illegal_inst_o = 0U;
                vlSelf->bench_control__DOT__alu_op_o = 4U;
                vlSelf->bench_control__DOT__reg_write_en_o = 1U;
            }
        } else if ((0x2000U & vlSelf->bench_control__DOT__inst_i)) {
            if ((0x1000U & vlSelf->bench_control__DOT__inst_i)) {
                if ((0U == (vlSelf->bench_control__DOT__inst_i 
                            >> 0x19U))) {
                    vlSelf->bench_control__DOT__illegal_inst_o = 0U;
                    vlSelf->bench_control__DOT__alu_op_o = 6U;
                    vlSelf->bench_control__DOT__reg_write_en_o = 1U;
                }
            } else if ((0U == (vlSelf->bench_control__DOT__inst_i 
                               >> 0x19U))) {
                vlSelf->bench_control__DOT__illegal_inst_o = 0U;
                vlSelf->bench_control__DOT__alu_op_o = 5U;
                vlSelf->bench_control__DOT__reg_write_en_o = 1U;
            }
        } else if ((0x1000U & vlSelf->bench_control__DOT__inst_i)) {
            if ((0U == (vlSelf->bench_control__DOT__inst_i 
                        >> 0x19U))) {
                vlSelf->bench_control__DOT__illegal_inst_o = 0U;
                vlSelf->bench_control__DOT__alu_op_o = 7U;
                vlSelf->bench_control__DOT__reg_write_en_o = 1U;
            }
        } else if ((0U == (vlSelf->bench_control__DOT__inst_i 
                           >> 0x19U))) {
            vlSelf->bench_control__DOT__illegal_inst_o = 0U;
            vlSelf->bench_control__DOT__alu_op_o = 0U;
            vlSelf->bench_control__DOT__reg_write_en_o = 1U;
        } else if ((0x20U == (vlSelf->bench_control__DOT__inst_i 
                              >> 0x19U))) {
            vlSelf->bench_control__DOT__illegal_inst_o = 0U;
            vlSelf->bench_control__DOT__alu_op_o = 1U;
            vlSelf->bench_control__DOT__reg_write_en_o = 1U;
        }
        vlSelf->bench_control__DOT__inst_format_o = 0U;
        vlSelf->bench_control__DOT__alu_b_imm_o = 0U;
    } else if ((0x13U == (0x7fU & vlSelf->bench_control__DOT__inst_i))) {
        if ((0x4000U & vlSelf->bench_control__DOT__inst_i)) {
            if ((0x2000U & vlSelf->bench_control__DOT__inst_i)) {
                vlSelf->bench_control__DOT__illegal_inst_o = 0U;
                vlSelf->bench_control__DOT__alu_op_o 
                    = ((0x1000U & vlSelf->bench_control__DOT__inst_i)
                        ? 2U : 3U);
                vlSelf->bench_control__DOT__reg_write_en_o = 1U;
            } else if ((0x1000U & vlSelf->bench_control__DOT__inst_i)) {
                if ((0U == (vlSelf->bench_control__DOT__inst_i 
                            >> 0x19U))) {
                    vlSelf->bench_control__DOT__illegal_inst_o = 0U;
                    vlSelf->bench_control__DOT__alu_op_o = 8U;
                    vlSelf->bench_control__DOT__reg_write_en_o = 1U;
                } else if ((0x20U == (vlSelf->bench_control__DOT__inst_i 
                                      >> 0x19U))) {
                    vlSelf->bench_control__DOT__illegal_inst_o = 0U;
                    vlSelf->bench_control__DOT__alu_op_o = 9U;
                    vlSelf->bench_control__DOT__reg_write_en_o = 1U;
                }
            } else {
                vlSelf->bench_control__DOT__illegal_inst_o = 0U;
                vlSelf->bench_control__DOT__alu_op_o = 4U;
                vlSelf->bench_control__DOT__reg_write_en_o = 1U;
            }
        } else if ((0x2000U & vlSelf->bench_control__DOT__inst_i)) {
            vlSelf->bench_control__DOT__illegal_inst_o = 0U;
            vlSelf->bench_control__DOT__alu_op_o = 
                ((0x1000U & vlSelf->bench_control__DOT__inst_i)
                  ? 6U : 5U);
            vlSelf->bench_control__DOT__reg_write_en_o = 1U;
        } else if ((0x1000U & vlSelf->bench_control__DOT__inst_i)) {
            if ((0U == (vlSelf->bench_control__DOT__inst_i 
                        >> 0x19U))) {
                vlSelf->bench_control__DOT__illegal_inst_o = 0U;
                vlSelf->bench_control__DOT__alu_op_o = 7U;
                vlSelf->bench_control__DOT__reg_write_en_o = 1U;
            }
        } else {
            vlSelf->bench_control__DOT__illegal_inst_o = 0U;
            vlSelf->bench_control__DOT__alu_op_o = 0U;
            vlSelf->bench_control__DOT__reg_write_en_o = 1U;
        }
        vlSelf->bench_control__DOT__inst_format_o = 1U;
        vlSelf->bench_control__DOT__alu_b_imm_o = 1U;
    }
}

void Vbench_control___024root___eval_act(Vbench_control___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vbench_control__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vbench_control___024root___eval_act\n"); );
    // Body
    if ((1ULL & vlSelf->__VactTriggered.word(0U))) {
        Vbench_control___024root___act_sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[3U] = 1U;
    }
}

void Vbench_control___024root___eval_nba(Vbench_control___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vbench_control__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vbench_control___024root___eval_nba\n"); );
    // Body
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vbench_control___024root___act_sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[4U] = 1U;
    }
}

void Vbench_control___024root___timing_resume(Vbench_control___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vbench_control__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vbench_control___024root___timing_resume\n"); );
    // Body
    if ((1ULL & vlSelf->__VactTriggered.word(0U))) {
        vlSelf->__VtrigSched_hf6693c5c__0.resume("@(posedge bench_control.clk)");
    }
    if ((2ULL & vlSelf->__VactTriggered.word(0U))) {
        vlSelf->__VdlySched.resume();
    }
}

void Vbench_control___024root___timing_commit(Vbench_control___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vbench_control__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vbench_control___024root___timing_commit\n"); );
    // Body
    if ((! (1ULL & vlSelf->__VactTriggered.word(0U)))) {
        vlSelf->__VtrigSched_hf6693c5c__0.commit("@(posedge bench_control.clk)");
    }
}

void Vbench_control___024root___eval_triggers__act(Vbench_control___024root* vlSelf);

bool Vbench_control___024root___eval_phase__act(Vbench_control___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vbench_control__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vbench_control___024root___eval_phase__act\n"); );
    // Init
    VlTriggerVec<2> __VpreTriggered;
    CData/*0:0*/ __VactExecute;
    // Body
    Vbench_control___024root___eval_triggers__act(vlSelf);
    Vbench_control___024root___timing_commit(vlSelf);
    __VactExecute = vlSelf->__VactTriggered.any();
    if (__VactExecute) {
        __VpreTriggered.andNot(vlSelf->__VactTriggered, vlSelf->__VnbaTriggered);
        vlSelf->__VnbaTriggered.thisOr(vlSelf->__VactTriggered);
        Vbench_control___024root___timing_resume(vlSelf);
        Vbench_control___024root___eval_act(vlSelf);
    }
    return (__VactExecute);
}

bool Vbench_control___024root___eval_phase__nba(Vbench_control___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vbench_control__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vbench_control___024root___eval_phase__nba\n"); );
    // Init
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = vlSelf->__VnbaTriggered.any();
    if (__VnbaExecute) {
        Vbench_control___024root___eval_nba(vlSelf);
        vlSelf->__VnbaTriggered.clear();
    }
    return (__VnbaExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vbench_control___024root___dump_triggers__nba(Vbench_control___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Vbench_control___024root___dump_triggers__act(Vbench_control___024root* vlSelf);
#endif  // VL_DEBUG

void Vbench_control___024root___eval(Vbench_control___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vbench_control__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vbench_control___024root___eval\n"); );
    // Init
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
            Vbench_control___024root___dump_triggers__nba(vlSelf);
#endif
            VL_FATAL_MT("testbenches/bench_control.sv", 2, "", "NBA region did not converge.");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        __VnbaContinue = 0U;
        vlSelf->__VactIterCount = 0U;
        vlSelf->__VactContinue = 1U;
        while (vlSelf->__VactContinue) {
            if (VL_UNLIKELY((0x64U < vlSelf->__VactIterCount))) {
#ifdef VL_DEBUG
                Vbench_control___024root___dump_triggers__act(vlSelf);
#endif
                VL_FATAL_MT("testbenches/bench_control.sv", 2, "", "Active region did not converge.");
            }
            vlSelf->__VactIterCount = ((IData)(1U) 
                                       + vlSelf->__VactIterCount);
            vlSelf->__VactContinue = 0U;
            if (Vbench_control___024root___eval_phase__act(vlSelf)) {
                vlSelf->__VactContinue = 1U;
            }
        }
        if (Vbench_control___024root___eval_phase__nba(vlSelf)) {
            __VnbaContinue = 1U;
        }
    }
}

#ifdef VL_DEBUG
void Vbench_control___024root___eval_debug_assertions(Vbench_control___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vbench_control__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vbench_control___024root___eval_debug_assertions\n"); );
}
#endif  // VL_DEBUG
