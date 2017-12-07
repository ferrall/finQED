#include "../../include/finQED.h"
/**
three ways to evaluate option price, proper for different options
The variable payoff in the below functions is a general substitute for different payoff calculation functions of different options.
**/

/** The first one describes a payoff which simply depends on the terminal price of the underlying and some constant  **/
derivative_price_european_simulated2 ( S,  X,  r,  sigma,time, payoff, no_sims) {
    decl sum_payoffs=0;
    for (decl n=0; n<no_sims; n++) {
       decl S_T = simulate_terminal_price(S,r,sigma,time);
       sum_payoffs += payoff(S_T,X);
    }
    return  exp(-r*time) * (sum_payoffs/no_sims);
}

/** The second one describes a payoff which depends on the whole price path and some constants, without certain strike prices
eg. Asian option, lookback option**/
derivative_price_european_simulated1 ( S,r,sigma,time,payoff,no_steps,no_sims) {
   decl n,sum_payoffs=0;
   decl prices;
   for (n=0; n<no_sims; n++) {
      prices = simulate_price_sequence(S,r,sigma,time,no_steps);
      sum_payoffs += payoff(prices);
   }
   return  exp(-r*time) * (sum_payoffs/no_sims);
}

/** The third one describes a payoff which depends on the whole price path and some constants with a certain strike price**/
derivative_price_european_simulated3 ( S,X,r,sigma,time,payoff,no_steps,no_sims) {
   decl sum_payoffs=0;
   decl prices;
   for (decl n=0; n<no_sims; n++) {
      prices = simulate_price_sequence(S,r,sigma,time,no_steps);
      sum_payoffs += payoff(prices,X);
   }
   return  exp(-r*time) * (sum_payoffs/no_sims);
}
