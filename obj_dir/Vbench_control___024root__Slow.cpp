// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vbench_control.h for the primary calling header

#include "Vbench_control__pch.h"
#include "Vbench_control__Syms.h"
#include "Vbench_control___024root.h"

void Vbench_control___024root___ctor_var_reset(Vbench_control___024root* vlSelf);

Vbench_control___024root::Vbench_control___024root(Vbench_control__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , __VdlySched{*symsp->_vm_contextp__}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vbench_control___024root___ctor_var_reset(this);
}

void Vbench_control___024root::__Vconfigure(bool first) {
    if (false && first) {}  // Prevent unused
}

Vbench_control___024root::~Vbench_control___024root() {
}
