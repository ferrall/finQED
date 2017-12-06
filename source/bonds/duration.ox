// file bonds_duration.cc
// author: Bernt Arne Odegaard

#include <oxstd.h>

bonds_duration(cashflow_times,cashflows,r)
{
	// calculate the duration of a bond, simple case where the term
	// structure is flat, interest rate r.
	decl t = vec(cashflows) .* exp(-r .* vec(cashflow_times));
	return double(sumc(t .* vec(cashflow_times)) / sumc(t));
}
