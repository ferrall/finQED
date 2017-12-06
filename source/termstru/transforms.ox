// file termstru_transforms.cc
// author: Bernt A Oedegaard

#include <oxstd.h>

term_structure_yield_from_discount_factor(dfact,t) {
    return (-log(dfact)/t);
}

term_structure_discount_factor_from_yield(r,t) {
    return exp(-r*t);
}

term_structure_forward_rate_from_disc_facts(d_t,d_T,time) {
    return (log (d_t/d_T))/time;
}

term_structure_forward_rate_from_yields(r_t1,r_T,t1,T) {
    return (r_T*(T/(T-t1))-r_t1*(t1/T));
}
