// file simulated_delta_put.cc
// author: Bernt Arne Oedegaard

#include <oxstd.h>
/**	see simulated_delta_call for more specific explanation,
    almost the same, except the calculation of option price.
    Difference between call option and put option: call option is the right to buy the asset at a certain price in the future, while put option is the right to sell.
	So it is easy to understand, on the final date,
	for call option, its value is the asset price minus strike price;
	for put option, its value is the strike price minus asset price.
**/
option_price_delta_put_european_simulated(
    S,X,r,sigma,time,no_sims)
{
   // estimate the price using two different S values
    decl R = (r - 0.5 * sqr(sigma)) * time;
    decl SD = sigma * sqrt(time);
    decl q = S * 0.001;

	decl series = exp(R + SD * rann(1, no_sims));
	decl prices = X - S * series;
	decl sum_payoffs1 = double(sumr(prices .> 0 .? prices .: 0));
	prices = X - (S + q) * series;
	decl sum_payoffs2 = double(sumr(prices .> 0 .? prices .: 0));

	decl p1 = sum_payoffs1 / no_sims;
    decl p2 = sum_payoffs2 / no_sims;
    return exp(-r*time) * (p2 - p1) / q;
}
