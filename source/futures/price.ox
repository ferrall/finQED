// file futures_price.cc
// author: Bernt A Oedegaard.

#include <oxstd.h>

futures_price(S,                     // value of underlying
		      r,                     // risk free interest
		      time_to_maturity) {
    return exp(r*time_to_maturity)*S;
}
