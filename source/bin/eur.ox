
option_price_european_binomial(option)
{
    decl R;           				// interest rate for each step
    decl Rinv;                      // inverse of interest rate
    decl u;   						// up movement
    decl uu;						// square of up movement
    decl d;							// inverse of up movement
    decl p_up;						// up probability
    decl p_down;					// down probability

	initial_calcs(r, sigma, &R, &Rinv, &u, &uu, &d, &p_up, &p_down);
	
	// fill in the endnodes.
	decl prices = constant(uu, steps + 1, 1);
	prices[0] = S * pow(d, steps);
	if (option == 0) prices = cumprod(prices)' - X;
	if (option == 1) prices = X - cumprod(prices)';

	// calculate call or put value
	decl values = prices .> 0 .? prices .: 0;
	for (decl step=steps-1; step>=0; --step)
	{
		values = (p_up * values[1 : step + 1] + p_down * values[ : step]) * Rinv;
    }
    return values[0];
}
