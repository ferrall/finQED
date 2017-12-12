
option_price_partials_american_put_binomial(
						delta, 	//  out: partial wrt S
						gamma, 	//  out: second prt wrt S
						theta, 	// out: partial wrt time
						vega,  	//  out: partial wrt sigma
						rho)   	// out: partial wrt r
{
    decl delta_t =(time/steps);
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
	prices = cumprod(prices)';
	decl put_values = X - prices .> 0 .? X - prices .: 0;

	for (decl step=steps-1; step>=2; --step)
	{
		put_values = (p_up * put_values[1 : step + 1] + p_down * put_values[ : step]) * Rinv;
		prices = d * prices[1 : step + 1];
		put_values = X - prices .> put_values .? X - prices .: put_values;
    }
    decl f22 = put_values[2];
    decl f21 = put_values[1];
    decl f20 = put_values[0];
    for (decl i=0;i<=1;i++)
	{
        prices[i] = d*prices[i+1];
        put_values[i] = (p_down*put_values[i]+p_up*put_values[i+1])*Rinv;
        put_values[i] = max(put_values[i], X-prices[i]); // check for exercise
    }
    decl f11 = put_values[1];
    decl f10 = put_values[0];
    prices[0] = d*prices[1];
    put_values[0] = (p_down*put_values[0]+p_up*put_values[1])*Rinv;
    put_values[0] = max(put_values[0], X-prices[2]); // check for exercise
    decl f00 = put_values[0];
    delta[0] = (f11-f10)/(S*(u-d));
    decl h = 0.5 * S *( uu - d*d);
    gamma[0] = ( (f22-f21)/(S*(uu-1.0)) - (f21-f20)/(S*(1.0-d*d)) ) / h;
    theta[0] = (f21-f00) / (2*delta_t);
	
    decl diff = 0.02;
    decl tmp_sigma = sigma+diff;
    decl tmp_prices = option_price_put_american_binomial(S, r, tmp_sigma, time, steps, dividend_times, dividend_amounts);

	vega[0] = (tmp_prices-f00)/diff;
    diff = 0.05;
    decl tmp_r = r+diff;
    tmp_prices = option_price_put_american_binomial(S, tmp_r, sigma, time, steps, dividend_times, dividend_amounts);
    rho[0] = (tmp_prices-f00)/diff;
}
