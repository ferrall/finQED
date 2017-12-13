
option_price_partials_american_binomial(option,
						delta, 		//  out: partial wrt S
						gamma, 		//  out: second prt wrt S
						theta, 		// out: partial wrt time
						vega,  		//  out: partial wrt sigma
						rho)   		// out: partial wrt r
{
    decl delta_t = (time/steps);
    decl R;           				// interest rate for each step
    decl Rinv;                      // inverse of interest rate
    decl u;   						// up movement
    decl uu;						// square of up movement
    decl d;							// inverse of up movement
    decl p_up;						// up probability
    decl p_down;					// down probability
	
	initial_calcs(r, sigma, &R, &Rinv, &u, &uu, &d, &p_up, &p_down);

	decl LB = 2;
	decl prices;
	decl values = values_calc(option, LB, S, steps, Rinv, uu, d, p_up, p_down, &values, &prices);
	
    decl f22 = values[2];
    decl f21 = values[1];
    decl f20 = values[0];
	
    for (decl i=0;i<=1;i++)
	{
    	prices[i] = d*prices[i+1];
       	values[i] = (p_down*values[i]+p_up*values[i+1])*Rinv;
        if (option == 0) values[i] = max(values[i], prices[i]-X); // check for exercise
		if (option == 1) values[i] = max(values[i], X-prices[i]); // check for exercise
    						}
	
    decl f11 = values[1];
    decl f10 = values[0];

    prices[0] = d*prices[1];
    values[0] = (p_down*values[0]+p_up*values[1])*Rinv;
    if (option == 0) values[0] = max(values[0], S-X);        	// check for exercise on first date
	if (option == 1) values[0] = max(values[0], X-prices[2]);	// check for exercise on first date
	
    decl f00 = values[0];
	if (option == 0) delta[0] = (f11-f10)/(S*u-S*d);
	if (option == 1) delta[0] = (f11-f10)/(S*(u-d));
    delta[0] = (f11-f10)/(S*u-S*d);
    decl h = 0.5 * S * ( uu - d*d);
    gamma[0] = ( (f22-f21)/(S*(uu-1)) - (f21-f20)/(S*(1-d*d)) ) / h;
    theta[0] = (f21-f00) / (2*delta_t);

	LB = 0;
	decl diff = 0.02;
    decl tmp_sigma = sigma+diff;
	initial_calcs(r, tmp_sigma, &R, &Rinv, &u, &uu, &d, &p_up, &p_down);
	values = values_calc(option, LB, S, steps, Rinv, uu, d, p_up, p_down, &values, &prices);
	decl tmp_prices = values[0];
	vega[0] = (tmp_prices-f00)/diff;

    diff = 0.05;
    decl tmp_r = r+diff;
	initial_calcs(tmp_r, sigma, &R, &Rinv, &u, &uu, &d, &p_up, &p_down);
	values = values_calc(option, LB, S, steps, Rinv, uu, d, p_up, p_down, &values, &prices);
    tmp_prices = values[0];
    rho[0] = (tmp_prices-f00)/diff;
}
