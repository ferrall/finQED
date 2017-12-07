//#include "bin.h"

option_price_european_binomial(option) // no steps in binomial tree
{

    decl R;           				// interest rate for each step
    decl Rinv;                      // inverse of interest rate
    decl u;   						// up movement
    decl uu;						// square of up movement
    decl d;
    decl p_up;
    decl p_down;
	
	initial_calcs(&R, &Rinv, &u, &uu, &d, &p_up, &p_down);
	
	// fill in the endnodes.
	decl prices = constant(uu, steps + 1, 1);
	prices[0] = S * pow(d, steps);


	// calculate call values:
	if (option == 0) {
		prices = cumprod(prices)' - X;
		decl call_values = prices .> 0 .? prices .: 0;
	
		for (decl step=steps-1; step>=0; --step)
		{
			call_values = (p_up * call_values[1 : step + 1] + p_down * call_values[ : step]) * Rinv;
	    }
	    return call_values[0];
					 }
	
	// calculate put values:
	if (option == 1) {
		prices = X - cumprod(prices)';
		decl put_values = prices .> 0 .? prices .: 0;
	
		for (decl step=steps-1; step>=0; --step)
		{
			put_values = (p_up * put_values[1 : step + 1] + p_down * put_values[ : step]) * Rinv;
	    }
		return put_values[0];
					  }
}
