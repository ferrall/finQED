// file bonds_price_discrete.cc
// author: Bernt A Oedegaard.

#include <oxstd.h>

bonds_price_discrete(cashflow_times,cashflows,r)
{
    // calculate bond price when term structure is flat,
	return double(sumc(vec(cashflows) ./ ((1+r).^vec(cashflow_times))));
}
