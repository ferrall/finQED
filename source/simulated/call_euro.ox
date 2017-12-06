// file: simulated_call_euro.cc
// author: Bernt Arne Oedegaard

#include <oxstd.h>

option_price_call_european_simulated(
    S,X,r,sigma,time,no_sims)
{
    decl R = (r - 0.5 * sqr(sigma)) * time;
    decl SD = sigma * sqrt(time);
	decl prices = S * exp(R + SD * rann(1, no_sims)) - X;
	decl sum_payoffs = double(sumr(prices .> 0 .? prices .: 0));
    return exp(-r*time) * (sum_payoffs/no_sims);
}
