#include "../../include/finQED.h"

option_price_put_american_proportional_dividends_binomial(S,	 X,	 r,	 sigma,	 time,	 steps,	dividend_times, dividend_yields)
{
	// given a dividend yield, the binomial tree recombines
    decl no_dividends=sizerc(dividend_times);
    if (no_dividends == 0)               // just take the regular binomial
       return option_price_put_american_binomial(S,X,r,sigma,time,steps);

	decl R = exp(r*(time/steps));
    decl Rinv = 1.0/R;
    decl u = exp(sigma*sqrt(time/steps));
    decl uu= u*u;
    decl d = 1.0/u;
    decl p_up   = (R-d)/(u-d);
    decl p_down = 1.0 - p_up;

    decl dividend_steps = trunc(dividend_times/time*steps);

	decl prices = constant(uu, steps + 1, 1);
	prices[0] = S * pow(d, steps);
	prices[0] *= cumprod(1.0-vec(dividend_yields))[no_dividends-1];
	prices = cumprod(prices)';
	decl put_values = X - prices .> 0 .? X - prices .: 0;

	for (decl step=steps-1; step>=0; --step)
	{
		decl j = vecindex(step .== dividend_steps);
		if (sizerc(j))
        	prices /= 1.0 - dividend_yields[j];
		put_values = (p_up * put_values[1 : step + 1] + p_down * put_values[ : step]) * Rinv;
		prices = d * prices[1 : step + 1];
		put_values = X - prices .> put_values .? X - prices .: put_values;
    }
    return put_values[0];
}
