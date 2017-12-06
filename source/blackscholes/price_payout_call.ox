// file: black_scholes_price_payout_call.cc
// author: Bernt A Oedegaard
//    Calculation of the Black Scholes option price formula,
//    special case where the underlying is paying out a yield of q.

#include <oxstd.h>

option_price_european_call_payout( S, // spot price
					  X, // Strike (exercise) price,
					  r,  // interest rate
					  q,  // yield on underlying
					  sigma, // volatility
					  time) { // time to maturity
  decl sigma_sqr = pow(sigma,2);
  decl time_sqrt = sqrt(time);
  decl d1 = (log(S/X) + (r-q + 0.5*sigma_sqr)*time)/(sigma*time_sqrt);
  decl d2 = d1-(sigma*time_sqrt);
  decl call_price = S * exp(-q*time)* probn(d1) - X * exp(-r*time) * probn(d2);
  return call_price;
}
