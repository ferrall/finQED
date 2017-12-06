// file simulated_delta_put.cc
// author: Bernt Arne Oedegaard

#include <oxstd.h>

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
