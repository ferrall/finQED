// file: black_scholes_delta_call.cc
// author: Bernt A Oedegaard
// The delta of the Black - Scholes formula

#include <oxstd.h>

option_price_delta_call_black_scholes(
					 S,     // spot price
				     X,     // Strike (exercise) price,
				     r,     // interest rate
				     sigma, // volatility
				     time)  // time to maturity
{					
    decl time_sqrt = sqrt(time);
    decl d1 = (log(S/X)+r*time)/(sigma*time_sqrt) + 0.5*sigma*time_sqrt;
    return probn(d1);
}
