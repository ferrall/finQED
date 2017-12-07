//#include "bin.h"

option_price_american_binomial(option) {

	decl R;           				// interest rate for each step
    decl Rinv;                      // inverse of interest rate
    decl u;   						// up movement
    decl uu;						// square of up movement
    decl d;
    decl p_up;
    decl p_down;
	
	initial_calcs(r, sigma, &R, &Rinv, &u, &uu, &d, &p_up, &p_down);
	
	// fill in the endnodes.
	decl prices = constant(uu, steps + 1, 1);
	prices[0] = S * pow(d, steps);
	prices = cumprod(prices)';

	//calculate call or put value:
	decl values = prices - X .> 0 .? prices - X .: 0;
	if (option == 1) values = -1 * prices - X .> 0 .? -1 * prices - X .: 0; 

	for (decl step=steps-1; step>=0; --step) {
		values = (p_up * values[1 : step + 1] + p_down * values[ : step]) * Rinv; 
		prices = d * prices[1 : step + 1];
		if (option == 0) values = prices - X .> values .? prices - X .: values;
		if (option == 1) values = X - prices .> values .? X - prices .: values;
											 }
		return values[0];	
					  
}
