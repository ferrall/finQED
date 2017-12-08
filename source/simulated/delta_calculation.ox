#include <oxstd.h>

option_price_delta_european_simulated(
    S,X,r,sigma,time,no_sims,corp){
    decl R = (r - 0.5 * sqr(sigma)) * time;
    decl SD = sigma * sqrt(time);
    decl q = S * 0.001;	/** Here, q means a small quantity relative to S.
	                        0.001 can be substituted by 0.01, 0.0001 or other similar small number, which only affect the accuracy of delta.
	                    **/
	decl series = exp(R + SD * rann(1, no_sims));	/** rann(1, no_sims) produces a 1 by no_sims matrix with random numbers from the standard normal distribution, which means prices is also  a 1 by no_sims matrix.
														According to our assumption, the price of the asset is log-normally distributed, so exp(R + SD * random) simulates the distribution once.
														so series is a 1 by no_sims matrix, and its elements simulate the distribution for no_sims times.
													**/
	decl prices;
	 if (corp==0) {prices= S * series - X;}		 /** calculate the prices of every simulated call option... we get c=f(S) **/
     if (corp==1) {prices = X - S * series;}
	decl sum_payoffs1 = double(sumr(prices .> 0 .? prices .: 0));  /** the same explanation as euro call **/
	if (corp==0) {prices = (S + q) * series - X;}		 /** we are going to estimate delta through (f(S+q)-f(S))/q...
											 Here, we calculate the second S value, which is the f(S+q) part in the formula.
										 **/
    if (corp==1) {	prices = X - (S + q) * series;}
	decl sum_payoffs2 = double(sumr(prices .> 0 .? prices .: 0));  	
    decl x1 = sum_payoffs1 / no_sims;  /** turn to the average value**/
    decl x2 = sum_payoffs2 / no_sims;
    return exp(-r*time) * (x2 - x1) / q;  /** calculate delta and then transform it into present value.  **/
}
