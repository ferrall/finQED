//#include "bin.h"


option_price_delta_american_binomial(option) // steps in binomial
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
	call_prices = cumprod(call_prices)';

	// calculate call values:
	decl call_values = call_prices - X .> 0 .? call_prices - X .: 0;

    for (decl step=steps-1; step>=1; --step)
	{
		call_values = (p_up * call_values[1 : step + 1] + p_down * call_values[ : step]) * Rinv;
		call_prices = d * call_prices[1 : step + 1];
		call_values = call_prices - X .> call_values .? call_prices - X .: call_values;
    }
    if (option == 0) return (call_values[1]-call_values[0])/(S*u-S*d);

	// fill in the endnodes for put.
	decl put_prices = constant(uu, steps + 1, 1);
	put_prices[0] = S * pow(d, steps);
	put_prices = cumprod(put_prices)';
	
	// calculate put values:
	decl put_values = X - put_prices .> 0 .? X - put_prices .: 0;

	for (decl step=steps-1; step>=1; --step)
	{
		put_values = (p_up * put_values[1 : step + 1] + p_down * put_values[ : step]) * Rinv;
		put_prices = d * put_prices[1 : step + 1];
		put_values = X - put_prices .> put_values .? X - put_prices .: put_values;
    }
    if (option == 1) return (put_values[1]-put_values[0])/(S*u-S*d);
}