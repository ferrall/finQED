
option_price_american_binomial(option, LB, S, r, sigma, time, steps, dividend_times, dividend_amounts)
{
    decl R;           				// interest rate for each step
    decl Rinv;                      // inverse of interest rate
    decl u;   						// up movement
    decl uu;						// square of up movement
    decl d;							// inverse of up movement
    decl p_up;						// up probability
    decl p_down;					// down probability

	initial_calcs(r, sigma, &R, &Rinv, &u, &uu, &d, &p_up, &p_down);

	decl values;
	
	values_calc(Rinv, uu, d, p_up, p_down, &values, option, LB);
	
    return values[0];
}
