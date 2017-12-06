// file bonds_price.cc
// author: Bernt A Oedegaard.

#include <oxstd.h>

bonds_price(cashflow_times,cashflows,r)
{
    // calculate bond price when term structure is flat,
    return double(sumc(exp(-r*vec(cashflow_times)).*vec(cashflows)));
}
