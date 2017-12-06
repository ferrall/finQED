//#include "bin.h"


option_price_delta_american_call_binomial() // steps in binomial
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
	prices = cumprod(prices)';
	decl call_values = prices - X .> 0 .? prices - X .: 0;

    for (decl step=steps-1; step>=1; --step)
	{
		call_values = (p_up * call_values[1 : step + 1] + p_down * call_values[ : step]) * Rinv;
		prices = d * prices[1 : step + 1];
		call_values = prices - X .> call_values .? prices - X .: call_values;
    }
    return (call_values[1]-call_values[0])/(S*u-S*d);
}
