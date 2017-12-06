// file: black_scholes_call
// author: Bernt A Oedegaard
//    Calculation of the Black Scholes option price formula.

#include <oxstd.h>

option_price_call_black_scholes( S, // spot price
					 X, // Strike (exercise) price,
					 r,  // interest rate
					 sigma,
					 time)
{
    decl time_sqrt = sqrt(time);
    decl d1 = (log(S/X)+r*time)/(sigma*time_sqrt) + 0.5*sigma*time_sqrt;
    decl d2 = d1-(sigma*time_sqrt);
    decl c = S * probn(d1) - X * exp(-r*time) * probn(d2);
    return c;
}
