//#include "../../include/finQED.h"
/*
 given an amount of dividend, the binomial tree does not recombine, have to
 start a new tree at each ex-dividend date.
 do this recursively, at each ex dividend date, at each step, call the
 binomial formula starting at that point to calculate the value of the live
 option, and compare that to the value of exercising now.
*/
option_price_american_discrete_dividends_binomial(option, S,time,steps,dividend_times,dividend_amounts)
{
    decl no_dividends = sizerc(dividend_times);
	decl R;           				// interest rate for each step
    decl Rinv;                      // inverse of interest rate
    decl u;   						// up movement
    decl uu;						// square of up movement
    decl d;
    decl p_up;
    decl p_down;
	
	initial_calcs(r, sigma, &R, &Rinv, &u, &uu, &d, &p_up, &p_down);

	if (no_dividends == 0)               // just take the regular binomial
	{
		decl prices = constant(uu, steps + 1, 1);
		prices[0] = S * pow(d, steps);
		prices = cumprod(prices)';

		decl values = prices - X .> 0 .? prices - X .: 0;
		if (option == 1)
			values =  -1 * prices - X .> 0 .? -1 * prices - X .: 0;
		
		for (decl step = steps-1; step>=0; --step) {
			if (option == 0) {
				values = (p_up * values[1 : step + 1] + p_down * values[ : step]) * Rinv;
				prices = d * prices[1 : step + 1];
				values = prices - X .> values .? prices - X .: values;
							 }
			if (option == 1) {
				values = (p_up * values[1 : step + 1] + p_down * values[ : step]) * Rinv;
				prices = d * prices[1 : step + 1];
				values = X - prices .> values .? X - prices .: values;
							 }
												   }
		return values[0];
	}
	
	decl dividend_amount = dividend_amounts[0];
	decl steps_before_dividend = int(dividend_times[0]/time*steps);

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

	decl values = zeros(1,steps_before_dividend+1);

	for (decl i=0; i<=steps_before_dividend; ++i) {
		decl value_alive
			= option_price_american_discrete_dividends_binomial(option,
		         	prices[i]-dividend_amount,
		         	time-dividend_times[0], // time after first dividend
		         	steps-steps_before_dividend,
		         	tmp_dividend_times,
	         		tmp_dividend_amounts);
			// what is the value of keeping the option alive?  Found recursively,
	        // with one less dividend, the stock price is current value
	        // less the dividend.			
		if (option == 0) {
			values[i] = max(value_alive,prices[i]-X);  // compare to exercising now
		}
		if (option == 1) {
			values[i] = max(value_alive,X-prices[i]);  // compare to exercising now
		}					  
												   }
	for (decl step=steps_before_dividend-1; step>=0; --step) {
		values = (p_up * values[1 : step + 1] + p_down * values[ : step]) * Rinv;
		prices = d * prices[1 : step + 1];
		if (option == 0) values = prices - X .> values .? prices - X .: values;
		if (option == 1) values = X - prices .> values .? X - prices .: values;
															  }
	return values[0];														  
}