
option_price_partials_american_call_binomial(
						delta, 	//  out: partial wrt S
						gamma, 	//  out: second prt wrt S
						theta, 	// out: partial wrt time
						vega,  	//  out: partial wrt sigma
						rho)   	// out: partial wrt r
{
    decl delta_t =(time/steps);
    decl R = exp(r*delta_t);
    decl Rinv = 1.0/R;
    decl u = exp(sigma*sqrt(delta_t));
    decl d = 1.0/u;
    decl uu= u*u;
    decl p_up   = (R-d)/(u-d);
    decl p_down = 1.0 - p_up;
	// fill in the endnodes.
	decl prices = constant(uu, steps + 1, 1);
	prices[0] = S * pow(d, steps);
	prices = cumprod(prices)';
	decl call_values = prices - X .> 0 .? prices - X .: 0;

	for (decl step=steps-1; step>=2; --step)
	{
		call_values = (p_up * call_values[1 : step + 1] + p_down * call_values[ : step]) * Rinv;
		prices = d * prices[1 : step + 1];
		call_values = prices - X .> call_values .? prices - X .: call_values;
    }
    decl f22 = call_values[2];
    decl f21 = call_values[1];
    decl f20 = call_values[0];
    for (decl i=0;i<=1;i++)
	{
        prices[i] = d*prices[i+1];
        call_values[i] = (p_down*call_values[i]+p_up*call_values[i+1])*Rinv;
        call_values[i] = max(call_values[i], prices[i]-X);        // check for exercise
    }
    decl f11 = call_values[1];
    decl f10 = call_values[0];

    prices[0] = d*prices[1];
    call_values[0] = (p_down*call_values[0]+p_up*call_values[1])*Rinv;
    call_values[0] = max(call_values[0], S-X);        // check for exercise on first date

    decl f00 = call_values[0];
    delta[0] = (f11-f10)/(S*u-S*d);
    decl h = 0.5 * S * ( uu - d*d);
    gamma[0] = ( (f22-f21)/(S*(uu-1)) - (f21-f20)/(S*(1-d*d)) ) / h;
    theta[0] = (f21-f00) / (2*delta_t);
    decl diff = 0.02;
    decl tmp_sigma = sigma+diff;
    decl tmp_prices = option_price_call_american_binomial(S, r, tmp_sigma, time, steps, dividend_times, dividend_amounts);
    vega[0] = (tmp_prices-f00)/diff;
    diff = 0.05;
    decl tmp_r = r+diff;
    tmp_prices = option_price_call_american_binomial(S, tmp_r, sigma, time, steps, dividend_times, dividend_amounts);
    rho[0] = (tmp_prices-f00)/diff;
}
