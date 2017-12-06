// file bin_eur_call.cc
// author: Bernt A Oedegaard
// calculate the binomial option pricing formula for an european call

#include <oxstd.h>
#include "../../include/bin.h"
#import "set_parameters.ox"

option_price_call_european_binomial() // no steps in binomial tree
{

    decl R = exp(r*(time/steps));            // interest rate for each step
    decl Rinv = 1.0/R;                    // inverse of interest rate
    decl u = exp(sigma*sqrt(time/steps));    // up movement
    decl uu = u*u;
    decl d = 1.0/u;
    decl p_up = (R-d)/(u-d);
    decl p_down = 1.0-p_up;
	// fill in the endnodes.
	decl prices = constant(uu, steps + 1, 1);
	prices[0] = S * pow(d, steps);
	prices = cumprod(prices)' - X;
	decl call_values = prices .> 0 .? prices .: 0;

	for (decl step=steps-1; step>=0; --step)
	{
		call_values = (p_up * call_values[1 : step + 1] + p_down * call_values[ : step]) * Rinv;
    }
    return call_values[0];
}
