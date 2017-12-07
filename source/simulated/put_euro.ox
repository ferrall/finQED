// file: simulated_put_euro.cc
// author: Bernt Arne Oedegaard

#include <oxstd.h>  
/**	 The differece between call option and put option: call option is the right to buy the asset at a certain price in the future, while put option is the right to sell.
	 So it is easy to understand, on the final date, for call option, its value is the asset price minus strike price;	 for put option, its value is the strike price minus asset price.
     Except this, almost the same with function 'option_price_call_european_simulated'
     A simple use of Monte Carlo Simulation to value the European put option.
	 1) Explanations of variables
	    S:  Stock Price
	    X:  Strike Price
	    r:  Interest rate
	    sigma: Volatility
	    time:  Time to final date
	    no_sims: Number of simulations
	 2)	Assumption: underlying asset's return is normally distributed
	 3) Implication of 2 :if the underlying asset's return is normally distributed, the price of the asset is log-normally distributed. 		
**/
option_price_put_european_simulated(S,X,r,sigma,time,no_sims)
{
    decl R = (r - 0.5 * sqr(sigma)) * time;		 /** calculate R=(r-(1/2)*sigma^2)*t **/
    decl SD = sigma * sqrt(time);				 /** calculate the standard deviation of a single simualtion SD=sigma*t^(1/2)  **/
	decl prices = X - S * exp(R + SD * rann(1, no_sims));  /** rann(1, no_sims) produces a 1 by no_sims matrix with random numbers from the standard normal distribution, which means prices is also  a 1 by no_sims matrix.
																Price of option = Strike price - Stock price at final date
															    Stock price * e^(R + SD* a random number)  → this formula is based on the implication mentioned in 3)	
	                                                            Here, we calculate the price of put option through simulation for no_sims times
															**/
	decl sum_payoffs = double(sumr(prices .> 0 .? prices .: 0)); /** Here, we calculate the sum of all the prices of option which are greater than 0
																	  We have known that prices is a 1 by no_sims matrix, so this sentence use a conditional expression ?: to distinguish every element >0 than add up them 
															      **/
    return exp(-r*time) * (sum_payoffs/no_sims);   /**  calculate the present value of the average simulated price of option as the estimated call option price**/
}
