// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vbench_control.h for the primary calling header

#ifndef VERILATED_VBENCH_CONTROL___024UNIT_H_
#define VERILATED_VBENCH_CONTROL___024UNIT_H_  // guard

#include "verilated.h"
#include "verilated_timing.h"


class Vbench_control__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vbench_control___024unit final : public VerilatedModule {
  public:

    // INTERNAL VARIABLES
    Vbench_control__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vbench_control___024unit(Vbench_control__Syms* symsp, const char* v__name);
    ~Vbench_control___024unit();
    VL_UNCOPYABLE(Vbench_control___024unit);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
