#include "../../include/finQED.h"

derivative_price_european_simulated2 ( S,  X,  r,  sigma,time, payoff, no_sims) {
    decl sum_payoffs=0;
    for (decl n=0; n<no_sims; n++) {
       decl S_T = simulate_terminal_price(S,r,sigma,time);
       sum_payoffs += payoff(S_T,X);
    }
    return  exp(-r*time) * (sum_payoffs/no_sims);
}

derivative_price_european_simulated1 ( S,r,sigma,time,payoff,no_steps,no_sims) {
   decl n,sum_payoffs=0;
   decl prices;
   for (n=0; n<no_sims; n++) {
      prices = simulate_price_sequence(S,r,sigma,time,no_steps);
      sum_payoffs += payoff(prices);
   }
   return  exp(-r*time) * (sum_payoffs/no_sims);
}

derivative_price_european_simulated3 ( S,X,r,sigma,time,payoff,no_steps,no_sims) {
   decl sum_payoffs=0;
   decl prices;
   for (decl n=0; n<no_sims; n++) {
      prices = simulate_price_sequence(S,r,sigma,time,no_steps);
      sum_payoffs += payoff(prices,X);
   }
   return  exp(-r*time) * (sum_payoffs/no_sims);
}
