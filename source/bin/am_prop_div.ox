//#include "bin.h"

option_price_american_proportional_dividends_binomial(option)
{
	// given a dividend yield, the binomial tree recombines
    decl no_dividends=sizerc(dividend_times);

	if (no_dividends == 0) {               // just take the regular binomial		
       if (option == 0)
	   	return option_price_american_binomial(option);
	   if (option == 1)
	   	return option_price_american_binomial(option); 	
							}							
	decl R = exp(r*(time/steps));
    decl Rinv = 1.0/R;
    decl u = exp(sigma*sqrt(time/steps));
    decl uu= u*u;
    decl d = 1.0/u;
    decl p_up   = (R-d)/(u-d);
    decl p_down = 1.0 - p_up;

    decl dividend_steps = trunc(dividend_times/time*steps);

	// declare and define call prices:
	decl call_prices = constant(uu, steps + 1, 1);
	call_prices[0] = S * pow(d, steps);
	call_prices[0] *= cumprod(1.0-vec(dividend_yields))[no_dividends-1];
	call_prices = cumprod(call_prices)';

	// calculate call values:
	decl call_values = call_prices - X .> 0 .? call_prices - X .: 0;

	for (decl step=steps-1; step>=0; --step)
	{
		decl j = vecindex(step .== dividend_steps);
		if (sizerc(j))
        	call_prices /= 1.0 - dividend_yields[j];
		call_values = (p_up * call_values[1 : step + 1] + p_down * call_values[ : step]) * Rinv;
		call_prices = d * call_prices[1 : step + 1];
		call_values = call_prices - X .> call_values .? call_prices - X .: call_values;
    }
	if (option == 0) return call_values[0];

	// declare and define put prices:
	decl put_prices = constant(uu, steps + 1, 1);
	put_prices[0] = S * pow(d, steps);
	put_prices[0] *= cumprod(1.0-vec(dividend_yields))[no_dividends-1];
	put_prices = cumprod(put_prices)';
	
	// calculate put values:
	decl put_values = X - put_prices .> 0 .? X - put_prices .: 0;

	for (decl step=steps-1; step>=0; --step)
	{
		decl j = vecindex(step .== dividend_steps);
		if (sizerc(j))
        	put_prices /= 1.0 - dividend_yields[j];
		put_values = (p_up * put_values[1 : step + 1] + p_down * put_values[ : step]) * Rinv;
		put_prices = d * put_prices[1 : step + 1];
		put_values = X - put_prices .> put_values .? X - put_prices .: put_values;
    }
	if (option == 1) return put_values[0];
}
