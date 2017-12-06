// file bonds_convexity.cc
// author: Bernt A Oedegaard.
// calculate convexity of a bond.

#include <oxstd.h>

bonds_convexity(cashflow_times,cashflow_amounts,y)
{
	decl t = vec(cashflow_times);
	return double(sumc(vec(cashflow_amounts) .* sqr(t) .* exp(-y*t)));
}
