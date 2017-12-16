/*
This is a function to calculate the American Option using the binomial pricing model.

A call option is the right to buy a given quantity of the underlying security
at a given price and a put option is the right to sell a given quantity of the underlying security to an agreed excercise
price within a given time interval. If the option can be used in a whole time period up to a given date, the option is called American.
An option will only be used if it is valuable to the option holder. In the case of a call option, this is when the exercise price "K"
is lower than the price one alternatively could buy the underlying security for, which is the current price of the underlying security.
Hence, options never have negative cash flows at maturity.Thus, for anybody to be willing to offer an option, they must have a cost when
entered into.
*/
option_price_american_binomial(option)
{
    decl R;           				// interest rate for each step
    decl Rinv;                      // inverse of interest rate
    decl u;   						// up movement
    decl uu;						// square of up movement
    decl d;							// inverse of up movement
    decl p_up;						// up probability
    decl p_down;					// down probability

	initial_calcs(r, sigma, &R, &Rinv, &u, &uu, &d, &p_up, &p_down); // call function to calculate above identifiers

	decl LB = 0; // set the lowerbound of the for loop in values_calc function
	decl prices;

	// call values_calc function to calculate the american binomial
	decl values = values_calc(option, LB, S, steps, Rinv, uu, d, p_up, p_down, &values, &prices);
	return values[0];
}
