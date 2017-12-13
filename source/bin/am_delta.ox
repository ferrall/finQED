
option_price_delta_american_binomial(option, LB)
{
    decl R;           				// interest rate for each step
    decl Rinv;                      // inverse of interest rate
    decl u;   						// up movement
    decl uu;						// square of up movement
    decl d;							// inverse of up movement
    decl p_up;						// up probability
    decl p_down;					// down probability

	initial_calcs(r, sigma, &R, &Rinv, &u, &uu, &d, &p_up, &p_down);

	// calculate call or put value
	decl values;
	
	values_calc(Rinv, uu, d, p_up, p_down, &values, option, LB);
	
    return (values[1]-values[0])/(S*u-S*d);
}
