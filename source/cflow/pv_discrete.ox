// file cflow_pv_discrete.cc
// author: Bernt Arne Oedegaard.

#include <oxstd.h>

/**
Calculate the present value of cash flows using discrete compounding. For discounting at discrete intervals for example, annually, semiannually. 

PV = FV0 + FV1/(1+r) + FV2/(1+r)^2 + ... + FVn/(1+r)^n

Where r is the interest rate and n is the number of periods.  

@param r Interest rate at which to discount future value of cash flows
@returns Present value of cash flows using discrete compounding 
**/
cash_flow_pv_discrete(r)
{
	return double(sumc(vec(cflow_amounts) ./ ((1+r) .^ vec(cflow_times))));
}
