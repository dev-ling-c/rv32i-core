// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vbench_control__pch.h"
#include "verilated_vcd_c.h"

//============================================================
// Constructors

Vbench_control::Vbench_control(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Vbench_control__Syms(contextp(), _vcname__, this)}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

Vbench_control::Vbench_control(const char* _vcname__)
    : Vbench_control(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Vbench_control::~Vbench_control() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void Vbench_control___024root___eval_debug_assertions(Vbench_control___024root* vlSelf);
#endif  // VL_DEBUG
void Vbench_control___024root___eval_static(Vbench_control___024root* vlSelf);
void Vbench_control___024root___eval_initial(Vbench_control___024root* vlSelf);
void Vbench_control___024root___eval_settle(Vbench_control___024root* vlSelf);
void Vbench_control___024root___eval(Vbench_control___024root* vlSelf);

void Vbench_control::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vbench_control::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vbench_control___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_activity = true;
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        Vbench_control___024root___eval_static(&(vlSymsp->TOP));
        Vbench_control___024root___eval_initial(&(vlSymsp->TOP));
        Vbench_control___024root___eval_settle(&(vlSymsp->TOP));
    }
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    Vbench_control___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

void Vbench_control::eval_end_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+eval_end_step Vbench_control::eval_end_step\n"); );
#ifdef VM_TRACE
    // Tracing
    if (VL_UNLIKELY(vlSymsp->__Vm_dumping)) vlSymsp->_traceDump();
#endif  // VM_TRACE
}

//============================================================
// Events and timing
bool Vbench_control::eventsPending() { return !vlSymsp->TOP.__VdlySched.empty(); }

uint64_t Vbench_control::nextTimeSlot() { return vlSymsp->TOP.__VdlySched.nextTimeSlot(); }

//============================================================
// Utilities

const char* Vbench_control::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void Vbench_control___024root___eval_final(Vbench_control___024root* vlSelf);

VL_ATTR_COLD void Vbench_control::final() {
    Vbench_control___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Vbench_control::hierName() const { return vlSymsp->name(); }
const char* Vbench_control::modelName() const { return "Vbench_control"; }
unsigned Vbench_control::threads() const { return 1; }
void Vbench_control::prepareClone() const { contextp()->prepareClone(); }
void Vbench_control::atClone() const {
    contextp()->threadPoolpOnClone();
}
std::unique_ptr<VerilatedTraceConfig> Vbench_control::traceConfig() const {
    return std::unique_ptr<VerilatedTraceConfig>{new VerilatedTraceConfig{false, false, false}};
};

//============================================================
// Trace configuration

void Vbench_control___024root__trace_decl_types(VerilatedVcd* tracep);

void Vbench_control___024root__trace_init_top(Vbench_control___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD static void trace_init(void* voidSelf, VerilatedVcd* tracep, uint32_t code) {
    // Callback from tracep->open()
    Vbench_control___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vbench_control___024root*>(voidSelf);
    Vbench_control__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (!vlSymsp->_vm_contextp__->calcUnusedSigs()) {
        VL_FATAL_MT(__FILE__, __LINE__, __FILE__,
            "Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vlSymsp->__Vm_baseCode = code;
    tracep->pushPrefix(std::string{vlSymsp->name()}, VerilatedTracePrefixType::SCOPE_MODULE);
    Vbench_control___024root__trace_decl_types(tracep);
    Vbench_control___024root__trace_init_top(vlSelf, tracep);
    tracep->popPrefix();
}

VL_ATTR_COLD void Vbench_control___024root__trace_register(Vbench_control___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD void Vbench_control::trace(VerilatedVcdC* tfp, int levels, int options) {
    if (tfp->isOpen()) {
        vl_fatal(__FILE__, __LINE__, __FILE__,"'Vbench_control::trace()' shall not be called after 'VerilatedVcdC::open()'.");
    }
    if (false && levels && options) {}  // Prevent unused
    tfp->spTrace()->addModel(this);
    tfp->spTrace()->addInitCb(&trace_init, &(vlSymsp->TOP));
    Vbench_control___024root__trace_register(&(vlSymsp->TOP), tfp->spTrace());
}
