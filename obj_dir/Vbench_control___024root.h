// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vbench_control.h for the primary calling header

#ifndef VERILATED_VBENCH_CONTROL___024ROOT_H_
#define VERILATED_VBENCH_CONTROL___024ROOT_H_  // guard

#include "verilated.h"
#include "verilated_timing.h"


class Vbench_control__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vbench_control___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    CData/*0:0*/ bench_control__DOT__clk;
    CData/*3:0*/ bench_control__DOT__alu_op_o;
    CData/*1:0*/ bench_control__DOT__inst_format_o;
    CData/*0:0*/ bench_control__DOT__alu_b_imm_o;
    CData/*0:0*/ bench_control__DOT__reg_write_en_o;
    CData/*0:0*/ bench_control__DOT__illegal_inst_o;
    CData/*0:0*/ __VstlFirstIteration;
    CData/*0:0*/ __Vtrigprevexpr___TOP__bench_control__DOT__clk__0;
    CData/*0:0*/ __VactContinue;
    IData/*31:0*/ bench_control__DOT__inst_i;
    IData/*31:0*/ bench_control__DOT__pass_count;
    IData/*31:0*/ bench_control__DOT__fail_count;
    IData/*31:0*/ bench_control__DOT__unnamedblk1__DOT__i;
    IData/*31:0*/ __VactIterCount;
    VlUnpacked<IData/*31:0*/, 4> bench_control__DOT__test_inst;
    VlUnpacked<CData/*0:0*/, 5> __Vm_traceActivity;
    VlDelayScheduler __VdlySched;
    VlTriggerScheduler __VtrigSched_hf6693c5c__0;
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<2> __VactTriggered;
    VlTriggerVec<2> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vbench_control__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vbench_control___024root(Vbench_control__Syms* symsp, const char* v__name);
    ~Vbench_control___024root();
    VL_UNCOPYABLE(Vbench_control___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
