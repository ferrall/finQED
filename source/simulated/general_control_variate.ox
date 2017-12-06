#include "../../include/finQED.h"

derivative_price_european_simulated_control_variate(
	 S,r,sigma,time,payoff,	no_steps,no_sims)
{
    decl X = S;
    decl c_bs = option_price_call_black_scholes(S,X,r,sigma,time);
    decl prices;
    decl sum_payoffs = 0;
    decl sum_payoffs_bs = 0;
	
    for (decl n=0; n<no_sims; n++)
	{
        prices = simulate_price_sequence(S,r,sigma,time,no_steps);
        sum_payoffs += payoff(prices);
        sum_payoffs_bs += payoff_european_call(prices[sizerc(prices)-1],X);
    }
    decl c_sim = exp(-r*time) * (sum_payoffs/no_sims);
    decl c_bs_sim = exp(-r*time) * (sum_payoffs_bs/no_sims);
    c_sim += (c_bs-c_bs_sim);
    return c_sim;
}
