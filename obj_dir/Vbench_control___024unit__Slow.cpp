// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vbench_control.h for the primary calling header

#include "Vbench_control__pch.h"
#include "Vbench_control__Syms.h"
#include "Vbench_control___024unit.h"

void Vbench_control___024unit___ctor_var_reset(Vbench_control___024unit* vlSelf);

Vbench_control___024unit::Vbench_control___024unit(Vbench_control__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vbench_control___024unit___ctor_var_reset(this);
}

void Vbench_control___024unit::__Vconfigure(bool first) {
    if (false && first) {}  // Prevent unused
}

Vbench_control___024unit::~Vbench_control___024unit() {
}
