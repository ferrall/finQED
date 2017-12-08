
option_price_delta_american_binomial(option) // steps in binomial
{
    decl R;           				// interest rate for each step
    decl Rinv;                      // inverse of interest rate
    decl u;   						// up movement
    decl uu;						// square of up movement
    decl d;							// inverse of up movement
    decl p_up;						// up probability
    decl p_down;					// down probability
	
	initial_calcs(r, sigma, &R, &Rinv, &u, &uu, &d, &p_up, &p_down);
	
	// fill in the endnodes
	decl prices = constant(uu, steps + 1, 1);
	prices[0] = S * pow(d, steps);
	prices = cumprod(prices)';

	// calculate call or put value
	decl values;
	if (option == 0) values = prices - X .> 0 .? prices - X .: 0;
	if (option == 1) values = X - prices .> 0 .? X - prices .: 0;

	for (decl step=steps-1; step>=1; --step)
	{
		values = (p_up * values[1 : step + 1] + p_down * values[ : step]) * Rinv;
		prices = d * prices[1 : step + 1];
		if (option == 0) values = prices - X .> values .? prices - X .: values;
		if (option == 1) values = X - prices .> values .? X - prices .: values;
	 }
	 return (values[1]-values[0])/(S*u-S*d);
}					  
