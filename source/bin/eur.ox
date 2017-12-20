/*
This is a function to calculate the European Option using the binomial pricing model.

A call option is the right to buy a given quantity of the underlying security
at a given price and a put option is the right to sell a given quantity of the underlying security to an agreed excercise
price within a given time interval. If an option can only be exercised (used) at a given date (the time interval is one day),
the option is called an European Option. An option will only be used if it is valuable to the option holder. In the case of a call option,
this is when the exercise price "K" is lower than the price one alternatively could buy the underlying security for, which is the current
price of the underlying security. Hence, options never have negative cash flows at maturity.Thus, for anybody to be willing to offer an option,
they must have a cost when entered into.
*/
option_price_european_binomial(option)
{
    decl R;           				// interest rate for each step
    decl Rinv;                      // inverse of interest rate
    decl u;   						// up movement
    decl uu;						// square of up movement
    decl d;							// inverse of up movement
    decl p_up;						// up probability
    decl p_down;					// down probability

	initial_calcs(r, sigma, &R, &Rinv, &u, &uu, &d, &p_up, &p_down); // call function to calculate above identifiers
	
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
