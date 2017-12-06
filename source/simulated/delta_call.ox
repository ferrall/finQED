// file simulated_delta_call.cc
// author: Bernt A Oedegaard
// estimation of the partials when doing monte carlo

#include <oxstd.h>

   // estimate the price using two different S values
option_price_delta_call_european_simulated(
    S,X,r,sigma,time,no_sims){
    decl R = (r - 0.5 * sqr(sigma)) * time;
    decl SD = sigma * sqrt(time);
    decl q = S * 0.001;

	decl series = exp(R + SD * rann(1, no_sims));
	decl prices = S * series - X;
	decl sum_payoffs1 = double(sumr(prices .> 0 .? prices .: 0));
	prices = (S + q) * series - X;
	decl sum_payoffs2 = double(sumr(prices .> 0 .? prices .: 0));
	
    decl c1 = sum_payoffs1 / no_sims;
    decl c2 = sum_payoffs2 / no_sims;
    return exp(-r*time) * (c2 - c1) / q;
}
