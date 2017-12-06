#include "../../include/finQED.h"

/* given an amount of dividend, the binomial tree does not recombine, have to
 start a new tree at each ex-dividend date.
 do this recursively, at each ex dividend date, at each step, put the
 binomial formula starting at that point to calculate the value of the live
 option, and compare that to the value of exercising now.*/
option_price_put_american_discrete_dividends_binomial(S,X,r,sigma,t,steps,dividend_times,dividend_amounts)
{
    decl no_dividends = sizerc(dividend_times);
    if (no_dividends == 0)               // just take the regular binomial
       return option_price_put_american_binomial(S,X,r,sigma,t,steps);
	
    decl steps_before_dividend = int(dividend_times[0]/t*steps);

    decl R = exp(r*(t/steps));
    decl Rinv = 1.0/R;
    decl u = exp(sigma*sqrt(t/steps));
    decl uu= u*u;
    decl d = 1.0/u;
    decl p_up   = (R-d)/(u-d);
    decl p_down = 1.0 - p_up;
    decl dividend_amount = dividend_amounts[0];
	// temporaries with one less dividend
    decl tmp_dividend_amounts, tmp_dividend_times;
	if (no_dividends > 1)
    {	tmp_dividend_amounts = dividend_amounts[1 : ];
    	tmp_dividend_times   = dividend_times[1 : ] - dividend_times[0];
	}
	else
		tmp_dividend_amounts = tmp_dividend_times = <>;

	decl prices = constant(uu, steps_before_dividend + 1, 1);
	prices[0] = S * pow(d, steps_before_dividend);
	prices = cumprod(prices)';
    decl put_values = zeros(1,steps_before_dividend+1);

	for (decl i=0; i<=steps_before_dividend; ++i)
	{
        decl value_alive
      		= option_price_put_american_discrete_dividends_binomial(
         		prices[i]-dividend_amount, X, r, sigma,
         		t-dividend_times[0],               // time after first dividend
         		steps-steps_before_dividend,
         		tmp_dividend_times, tmp_dividend_amounts);
        // what is the value of keeping the option alive?  Found recursively,
        // with one less dividend, the stock price is current value
        // less the dividend.
       	put_values[i] = max(value_alive,X-prices[i]);  // compare to exercising now
    }
	for (decl step=steps_before_dividend-1; step>=0; --step)
	{
		put_values = (p_up * put_values[1 : step + 1] + p_down * put_values[ : step]) * Rinv;
		prices = d * prices[1 : step + 1];
		put_values = X - prices .> put_values .? X - prices .: put_values;
    }
    return put_values[0];
}
