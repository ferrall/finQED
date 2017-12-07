//#include "bin.h"

option_price_european_binomial(option) // no steps in binomial tree
{

    decl R = exp(r*(time/steps));            // interest rate for each step
    decl Rinv = 1.0/R;                    // inverse of interest rate
    decl u = exp(sigma*sqrt(time/steps));    // up movement
    decl uu = u*u;
    decl d = 1.0/u;
    decl p_up = (R-d)/(u-d);
    decl p_down = 1.0-p_up;
	// fill in the endnodes for call.
	decl call_prices = constant(uu, steps + 1, 1);
	call_prices[0] = S * pow(d, steps);
	call_prices = cumprod(call_prices)' - X;

	// calculate call values:
	decl call_values = call_prices .> 0 .? call_prices .: 0;

	for (decl step=steps-1; step>=0; --step)
	{
		call_values = (p_up * call_values[1 : step + 1] + p_down * call_values[ : step]) * Rinv;
    }
    if (option == 0) return call_values[0];

	// fill in the endnodes for put.
	decl put_prices = constant(uu, steps + 1, 1);
	put_prices[0] = S * pow(d, steps);
	put_prices = X - cumprod(put_prices)';
	
	// calculate put values:
	decl put_values = put_prices .> 0 .? put_prices .: 0;

	for (decl step=steps-1; step>=0; --step)
	{
		put_values = (p_up * put_values[1 : step + 1] + p_down * put_values[ : step]) * Rinv;
    }
	if (option == 1) return put_values[0];	
}
