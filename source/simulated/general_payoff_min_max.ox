// file simulate_general_payoff_min_max
#include <oxstd.h>

/**
the strike price is the maximum value of all the prices from the start date to the final date.
for lookback put option
**/
payoff_max(prices) {
    decl m = max(prices);
   return m-prices[sizerc(prices)-1]; // max is always larger or equal.
}

/**
the strike price is the minimum value of all the prices from the start date to the final date.
for lookback call option
**/
payoff_min(prices) {
    decl m = min(prices);
   return prices[sizerc(prices)-1]-m; // always positive or zero
}
