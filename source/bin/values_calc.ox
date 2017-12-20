/*
This function minimizes repetitive code that is shared between multiple functions.
It calculates either the call or put value, depending on the option variable passed to the function. The
function has been adapted so it can be used in all of the american value functions by making the lower bound
in the for loop a variable, LB.
*/
values_calc(	option,			// 0 for call option, 1 for put option
				LB,				// Lower bound of the foor loop (0 for regular call or put evaluations, 2 for the partials function)
				S,				// Spot Price
				steps,			// steps
				Rinv,			// inverse of interest rate
				uu,				// square of up movement
				d,				// down movement
				p_up,			// probability of up movement
				p_down,			// probability of down movement
				values,			// address in which to place the calculated values
				inprices)		// price calculation
{
	// fill in the endnodes
	decl prices = constant(uu, steps + 1, 1);
	prices[0] = S * pow(d, steps);
	prices = cumprod(prices)';

	// calculate call value
	if (option == 0) {
		values = prices - X .> 0 .? prices - X .: 0;
		for (decl step=steps-1; step>=LB; --step)
		{
			values = (p_up * values[1 : step + 1] + p_down * values[ : step]) * Rinv;
			prices = d * prices[1 : step + 1];
			values = prices - X .> values .? prices - X .: values;
		 }
		inprices[0] = prices;
		return(values);
					  }

	// calculate put value
	if (option == 1) {
		values = X - prices .> 0 .? X - prices .: 0;
		for (decl step=steps-1; step>=LB; --step)
		{
			values = (p_up * values[1 : step + 1] + p_down * values[ : step]) * Rinv;
			prices = d * prices[1 : step + 1];
			values = X - prices .> values .? X - prices .: values;
		 }
	 inprices[0] = prices;
	 return (values);
	 				 }
}