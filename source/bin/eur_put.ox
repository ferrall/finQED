// file bin_eur_put.cc
// author: Bernt A Oedegaard
// calculate the binomial option pricing formula for an european put

#include <oxstd.h>

option_price_put_european_binomial( S,     // spot price
								     X,     // exercice price
								     r,     // interest rate
								     sigma, // volatility
								     t,     // time to maturity
								     steps) // no steps in binomial tree
{
    decl R = exp(r*(t/steps));            // interest rate for each step
    decl Rinv = 1.0/R;                    // inverse of interest rate
    decl u = exp(sigma*sqrt(t/steps));    // up movement
    decl uu = u*u;
    decl d = 1.0/u;
    decl p_up = (R-d)/(u-d);
    decl p_down = 1.0-p_up;

	// fill in the endnodes.
	decl prices = constant(uu, steps + 1, 1);
	prices[0] = S * pow(d, steps);
	prices = X - cumprod(prices)';
	decl put_values = prices .> 0 .? prices .: 0;

	for (decl step=steps-1; step>=0; --step)
	{
		put_values = (p_up * put_values[1 : step + 1] + p_down * put_values[ : step]) * Rinv;
    }
    return put_values[0];
}
