
values_calc(option, LB, S, steps, Rinv, uu, d, p_up, p_down, values, inprices)
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