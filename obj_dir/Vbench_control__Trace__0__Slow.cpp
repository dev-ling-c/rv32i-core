// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vbench_control__Syms.h"


VL_ATTR_COLD void Vbench_control___024root__trace_init_sub__TOP__riscv_types_pkg__0(Vbench_control___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD void Vbench_control___024root__trace_init_sub__TOP__0(Vbench_control___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vbench_control__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vbench_control___024root__trace_init_sub__TOP__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->pushPrefix("riscv_types_pkg", VerilatedTracePrefixType::SCOPE_MODULE);
    Vbench_control___024root__trace_init_sub__TOP__riscv_types_pkg__0(vlSelf, tracep);
    tracep->popPrefix();
    tracep->pushPrefix("bench_control", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+17,0,"clk",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+1,0,"inst_i",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+12,0,"alu_op_o",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBus(c+13,0,"inst_format_o",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBit(c+14,0,"alu_b_imm_o",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+15,0,"reg_write_en_o",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+16,0,"illegal_inst_o",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->pushPrefix("test_inst", VerilatedTracePrefixType::ARRAY_UNPACKED);
    for (int i = 0; i < 4; ++i) {
        tracep->declBus(c+2+i*1,0,"",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, true,(i+0), 31,0);
    }
    tracep->popPrefix();
    tracep->declBus(c+6,0,"pass_count",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::INT, false,-1, 31,0);
    tracep->declBus(c+7,0,"fail_count",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::INT, false,-1, 31,0);
    tracep->pushPrefix("control", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+1,0,"inst_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+12,0,"alu_op_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBus(c+13,0,"inst_format_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBit(c+14,0,"alu_b_imm_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+15,0,"reg_write_en_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+16,0,"illegal_inst_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+8,0,"opcode",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 6,0);
    tracep->declBus(c+9,0,"funct3",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+10,0,"funct7",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 6,0);
    tracep->popPrefix();
    tracep->pushPrefix("unnamedblk1", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+11,0,"i",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::INT, false,-1, 31,0);
    tracep->popPrefix();
    tracep->popPrefix();
}

VL_ATTR_COLD void Vbench_control___024root__trace_init_sub__TOP__riscv_types_pkg__0(Vbench_control___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vbench_control__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vbench_control___024root__trace_init_sub__TOP__riscv_types_pkg__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBus(c+18,0,"XLEN",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::INT, false,-1, 31,0);
    tracep->declBus(c+19,0,"REG_ADDR_WIDTH",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::INT, false,-1, 31,0);
}

VL_ATTR_COLD void Vbench_control___024root__trace_init_top(Vbench_control___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vbench_control__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vbench_control___024root__trace_init_top\n"); );
    // Body
    Vbench_control___024root__trace_init_sub__TOP__0(vlSelf, tracep);
}

VL_ATTR_COLD void Vbench_control___024root__trace_const_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
VL_ATTR_COLD void Vbench_control___024root__trace_full_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Vbench_control___024root__trace_chg_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Vbench_control___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/);

VL_ATTR_COLD void Vbench_control___024root__trace_register(Vbench_control___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vbench_control__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vbench_control___024root__trace_register\n"); );
    // Body
    tracep->addConstCb(&Vbench_control___024root__trace_const_0, 0U, vlSelf);
    tracep->addFullCb(&Vbench_control___024root__trace_full_0, 0U, vlSelf);
    tracep->addChgCb(&Vbench_control___024root__trace_chg_0, 0U, vlSelf);
    tracep->addCleanupCb(&Vbench_control___024root__trace_cleanup, vlSelf);
}

VL_ATTR_COLD void Vbench_control___024root__trace_const_0_sub_0(Vbench_control___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void Vbench_control___024root__trace_const_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vbench_control___024root__trace_const_0\n"); );
    // Init
    Vbench_control___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vbench_control___024root*>(voidSelf);
    Vbench_control__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    Vbench_control___024root__trace_const_0_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Vbench_control___024root__trace_const_0_sub_0(Vbench_control___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Vbench_control__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vbench_control___024root__trace_const_0_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    // Body
    bufp->fullIData(oldp+18,(0x20U),32);
    bufp->fullIData(oldp+19,(5U),32);
}

VL_ATTR_COLD void Vbench_control___024root__trace_full_0_sub_0(Vbench_control___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void Vbench_control___024root__trace_full_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vbench_control___024root__trace_full_0\n"); );
    // Init
    Vbench_control___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vbench_control___024root*>(voidSelf);
    Vbench_control__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    Vbench_control___024root__trace_full_0_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Vbench_control___024root__trace_full_0_sub_0(Vbench_control___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Vbench_control__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vbench_control___024root__trace_full_0_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    // Body
    bufp->fullIData(oldp+1,(vlSelf->bench_control__DOT__inst_i),32);
    bufp->fullIData(oldp+2,(vlSelf->bench_control__DOT__test_inst[0]),32);
    bufp->fullIData(oldp+3,(vlSelf->bench_control__DOT__test_inst[1]),32);
    bufp->fullIData(oldp+4,(vlSelf->bench_control__DOT__test_inst[2]),32);
    bufp->fullIData(oldp+5,(vlSelf->bench_control__DOT__test_inst[3]),32);
    bufp->fullIData(oldp+6,(vlSelf->bench_control__DOT__pass_count),32);
    bufp->fullIData(oldp+7,(vlSelf->bench_control__DOT__fail_count),32);
    bufp->fullCData(oldp+8,((0x7fU & vlSelf->bench_control__DOT__inst_i)),7);
    bufp->fullCData(oldp+9,((7U & (vlSelf->bench_control__DOT__inst_i 
                                   >> 0xcU))),3);
    bufp->fullCData(oldp+10,((vlSelf->bench_control__DOT__inst_i 
                              >> 0x19U)),7);
    bufp->fullIData(oldp+11,(vlSelf->bench_control__DOT__unnamedblk1__DOT__i),32);
    bufp->fullCData(oldp+12,(vlSelf->bench_control__DOT__alu_op_o),4);
    bufp->fullCData(oldp+13,(vlSelf->bench_control__DOT__inst_format_o),2);
    bufp->fullBit(oldp+14,(vlSelf->bench_control__DOT__alu_b_imm_o));
    bufp->fullBit(oldp+15,(vlSelf->bench_control__DOT__reg_write_en_o));
    bufp->fullBit(oldp+16,(vlSelf->bench_control__DOT__illegal_inst_o));
    bufp->fullBit(oldp+17,(vlSelf->bench_control__DOT__clk));
}
