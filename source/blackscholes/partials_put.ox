// file: black_scholes_partials_call.cc
// author: Bernt A Oedegaard
// The partial derivatives of the Black - Scholes formula

#include <oxstd.h>

option_price_partials_put_black_scholes(S, // spot price
					      X, // Strike (exercise) price,
					      r,  // interest rate
					      sigma,
					      time,
					      Delta, //  out: partial wrt S
					      Gamma, //  out: second prt wrt S
					     decl Theta,  // out: partial wrt time
					     decl Vega,  //  out: partial wrt sigma
					     decl Rho){    // out: partial wrt r
    decl time_sqrt = sqrt(time);
    decl d1 = (log(S/X)+r*time)/(sigma*time_sqrt) + 0.5*sigma*time_sqrt;
    decl d2 = d1-(sigma*time_sqrt);
    Delta[0] = -probn(-d1);
    Gamma[0] = densn(d1)/(S*sigma*time_sqrt);
    Theta[0] = -(S*sigma*densn(d1)) / (2*time_sqrt)+ r*X * exp(-r*time) * probn(-d2);
    Vega[0]  = S * time_sqrt * densn(d1);
    Rho[0] = - X * time * exp(-r * time) * probn(-d2);
}
