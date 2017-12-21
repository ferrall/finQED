// file simulated_delta_call.cc
// author: Bernt A Oedegaard
// estimation of the partials when doing monte carlo

#include <oxstd.h>
/** Option delta: the first derivative of the call price with respect to the underlying security.
    Delta represents the change in the option's price when the underlying asset's price increases by 1.
    Assume the option price formula c=f(S;X,r,sigma,t).
	Then estimated delta=(f(S+q)-f(S))/q    (where q is a small quantity)
	Here, this function shows the progress of estimating the call option delta using simulation.
	Explanations of variables: S:Stock Price   X:Strike Price    r:Interest rate     sigma: Volatility
	                           time:Time to final date     no_sims:Number of simulations
	To find more general info, see call/put euro option. Also, some duplicate info is omitted.	
**/
   // estimate the price using two different S values
   
option_price_delta_call_european_simulated(
    S,X,r,sigma,time,no_sims){
    decl R = (r - 0.5 * sqr(sigma)) * time;
    decl SD = sigma * sqrt(time);
    decl q = S * 0.001;	/** Here, q means a small quantity relative to S.
	                        0.001 can be substituted by 0.01, 0.0001 or other similar small number, which only affect the accuracy of delta.
	                    **/
	decl series = exp(R + SD * rann(1, no_sims));	/** rann(1, no_sims) produces a 1 by no_sims matrix with random numbers from the standard normal distribution, which means prices is also  a 1 by no_sims matrix.
														According to our assumption, the price of the asset is log-normally distributed, so exp(R + SD * random) simulates the distribution once.
														so series is a 1 by no_sims matrix, and its elements simulate the distribution for no_sims times.
													**/
	decl prices = S * series - X;		 /** calculate the prices of every simulated call option... we get c=f(S) **/
	decl sum_payoffs1 = double(sumr(prices .> 0 .? prices .: 0));  /** the same explanation as euro call **/
	prices = (S + q) * series - X;		 /** we are going to estimate delta through (f(S+q)-f(S))/q...
											 Here, we calculate the second S value, which is the f(S+q) part in the formula.
										 **/
	decl sum_payoffs2 = double(sumr(prices .> 0 .? prices .: 0));  	
    decl c1 = sum_payoffs1 / no_sims;  /** turn to the average value**/
    decl c2 = sum_payoffs2 / no_sims;
    return exp(-r*time) * (c2 - c1) / q;  /** calculate delta and then transform it into present value.  **/
}

