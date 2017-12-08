#include <oxstd.h>
option_price_euro_simulated(S, X, r, sigma, time, no_sims, corp)
{
    parameters_calculation1(r,sigma,time);
	decl prices;
	if ( corp == 0)  {prices = S * exp(R + SD * rann(1, no_sims)) - X;  };
	/** rann(1, no_sims) produces a 1 by no_sims matrix with random numbers from the standard normal distribution, which means prices is also  a 1 by no_sims matrix.
		Price of option = Stock price at final date - strike price
		Stock price * e^(R + SD* a random number)  -- this formula is based on the implication mentioned before	
	    Here, we calculate the price of call option through simulation for no_sims times
	**/
	if( corp == 1 )  {prices = X - S * exp(R + SD * rann(1, no_sims));	};
    decl sum_payoffs = double(sumr(prices .> 0 .? prices .: 0));
	/** Here, we calculate the sum of all the prices of option which are greater than 0
	We have known that prices is a 1 by no_sims matrix, so this sentence use a conditional expression ?: to distinguish every element >0 than add up them 
	**/
    return pvoption(r,time,no_sims,sum_payoffs);  /**  calculate the present value of the average simulated price of option as the estimated call option price**/
}

