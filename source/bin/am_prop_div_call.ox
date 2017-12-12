
option_price_call_american_proportional_dividends_binomial()
{
	// given a dividend yield, the binomial tree recombines
    decl no_dividends=sizerc(dividend_times);
    if (no_dividends == 0)               // just take the regular binomial
       return option_price_call_american_binomial(S, r, sigma, time, steps, dividend_times, dividend_amounts);

    decl R;           				// interest rate for each step
    decl Rinv;                      // inverse of interest rate
    decl u;   						// up movement
    decl uu;						// square of up movement
    decl d;							// inverse of up movement
    decl p_up;						// up probability
    decl p_down;					// down probability

	initial_calcs(r, sigma, &R, &Rinv, &u, &uu, &d, &p_up, &p_down);

    decl dividend_steps = trunc(dividend_times/time*steps);
	decl prices = constant(uu, steps + 1, 1);
	prices[0] = S * pow(d, steps);
	prices[0] *= cumprod(1.0-vec(dividend_yields))[no_dividends-1];
	prices = cumprod(prices)';
	decl call_values = prices - X .> 0 .? prices - X .: 0;

	for (decl step=steps-1; step>=0; --step)
	{
		decl j = vecindex(step .== dividend_steps);
		if (sizerc(j))
        	prices /= 1.0 - dividend_yields[j];
		call_values = (p_up * call_values[1 : step + 1] + p_down * call_values[ : step]) * Rinv;
		prices = d * prices[1 : step + 1];
		call_values = prices - X .> call_values .? prices - X .: call_values;
    }
    return call_values[0];
}
