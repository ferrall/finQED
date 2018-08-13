/*
Calculates the derivative of the call or put option using binomial approximation.
*/
option_price_delta_american_binomial(option)
{
    decl R;           				// interest rate for each step
    decl Rinv;                      // inverse of interest rate
    decl u;   						// up movement
    decl uu;						// square of up movement
    decl d;							// inverse of up movement
    decl p_up;						// up probability
    decl p_down;					// down probability

	initial_calcs(r, sigma, &R, &Rinv, &u, &uu, &d, &p_up, &p_down);  // call function to calculate above identifiers

	// calculate call or put value
	decl LB = 1; 		// set the lowerbound of the for loop in values_calc function
	decl prices;

	// call values_calc function to calculate the american binomial
	decl values = values_calc(option, LB, S, steps, Rinv, uu, d, p_up, p_down, &values, &prices);
	return (values[1]-values[0])/(S*u-S*d); //return final call or put value 
}