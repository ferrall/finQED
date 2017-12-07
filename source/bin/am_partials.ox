//#include "bin.h"

option_price_partials_american_binomial(option, 
						delta, 	//  out: partial wrt S
						gamma, 	//  out: second prt wrt S
						theta, 	// 	out: partial wrt time
						vega,  	//  out: partial wrt sigma
						rho)   	//	out: partial wrt r
{
    decl delta_t =(time/steps);

	decl R;           				// interest rate for each step
    decl Rinv;                      // inverse of interest rate
    decl u;   						// up movement
    decl uu;						// square of up movement
    decl d;
    decl p_up;
    decl p_down;
	
	initial_calcs(r, sigma, &R, &Rinv, &u, &uu, &d, &p_up, &p_down);
	
	// fill in the endnodes.
	decl prices = constant(uu, steps + 1, 1);
	prices[0] = S * pow(d, steps);
	prices = cumprod(prices)';
	decl values = prices - X .> 0 .? prices - X .: 0;
	if (option == 1) values = X - prices .> 0 .? X - prices .: 0;
	
	for (decl step=steps-1; step>=2; --step)
	{
		values = (p_up * values[1 : step + 1] + p_down * values[ : step]) * Rinv;
		prices = d * prices[1 : step + 1];
		if (option == 0) values = prices - X .> values .? prices - X .: values;
		if (option == 1) values = X - prices .> values .? X - prices .: values; 
	}
    decl f22 = values[2];
    decl f21 = values[1];
    decl f20 = values[0];
    for (decl i=0;i<=1;i++)
	{
        prices[i] = d*prices[i+1];
        values[i] = (p_down*values[i]+p_up*values[i+1])*Rinv;
        if (option == 0) values[i] = max(values[i], prices[i]-X);
		if (option == 1) values[i] = max(values[i], X-prices[i]); // check for exercise
    }
    decl f11 = values[1];
    decl f10 = values[0];

    prices[0] = d*prices[1];
    values[0] = (p_down*values[0]+p_up*values[1])*Rinv;
    if (option == 0) values[0] = max(values[0], S-X);        // check for exercise on first date
	if (option == 1) values[0] = max(values[0], X-prices[2]);
	
    decl f00 = values[0];
	if (option == 0) delta[0] = (f11-f10)/(S*u-S*d);
	if (option == 1) delta[0] = (f11-f10)/(S*(u-d));
    decl h = 0.5 * S * ( uu - d*d);
    gamma[0] = ( (f22-f21)/(S*(uu-1)) - (f21-f20)/(S*(1-d*d)) ) / h;
    theta[0] = (f21-f00) / (2*delta_t);
    decl diff = 0.02;
    decl tmp_sigma = sigma+diff;

	initial_calcs(r, tmp_sigma, &R, &Rinv, &u, &uu, &d, &p_up, &p_down);	
	
	prices = constant(uu, steps + 1, 1);
	prices[0] = S * pow(d, steps);
	prices = cumprod(prices)';

	if (option == 0) values = prices - X .> 0 .? prices - X .: 0;
	if (option == 1) values = X - prices .> 0 .? X - prices .: 0;
		 
	for (decl step=steps-1; step>=0; --step) {
		values = (p_up * values[1 : step + 1] + p_down * values[ : step]) * Rinv; 
		prices = d * prices[1 : step + 1];
		if (option == 0) values = prices - X .> values .? prices - X .: values;
		if (option == 1) values = X - prices .> values .? X - prices .: values; 
											 }
	decl tmp_prices = values[0];
	vega[0] = (tmp_prices-f00)/diff;
	diff = 0.05;
    decl tmp_r = r+diff;

	initial_calcs(tmp_r, sigma, &R, &Rinv, &u, &uu, &d, &p_up, &p_down);
	
	prices = constant(uu, steps + 1, 1);
	prices[0] = S * pow(d, steps);
	prices = cumprod(prices)';

	if (option == 0) values = prices - X .> 0 .? prices - X .: 0;
 	if (option == 1) values = X - prices .> 0 .? X - prices .: 0;
		 
	for (decl step=steps-1; step>=0; --step) {
		values = (p_up * values[1 : step + 1] + p_down * values[ : step]) * Rinv; 
		prices = d * prices[1 : step + 1];
		if (option == 0) values = prices - X .> values .? prices - X .: values;
		if (option == 1) values = X - prices .> values .? X - prices .: values; 
											 }
	tmp_prices = values[0];
	rho[0] = (tmp_prices-f00)/diff;
}
