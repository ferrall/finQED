// file currency_opt_bin_put.cc
// author: Bernt A Oedegaard

#include <oxstd.h>

currency_option_price_put_american_binomial(S,X,r,r_f,sigma,time,no_steps) {
  	decl exchange_rates = zeros(1,no_steps+1);
  	decl put_values = zeros(1,no_steps+1);
    decl t_delta= time/no_steps;
    decl Rinv = exp(-r*(t_delta));
    decl u = exp(sigma*sqrt(t_delta));
    decl d = 1.0/u;
    decl uu= u*u;
    decl pUp = (exp((r-r_f)*t_delta)-d)/(u-d); // adjust for foreign decl.rate
    decl pDown = 1.0 - pUp;
    exchange_rates[0] = S*pow(d, no_steps);
    decl i;
    for (i=1; i<=no_steps; ++i)
	exchange_rates[i] = uu*exchange_rates[i-1]; // terminal tree nodes
    for (i=0; i<=no_steps; ++i) put_values[i] = max(0.0, (exchange_rates[i]-X));
    for (decl step=no_steps-1; step>=0; --step) {
	for (i=0; i<=step; ++i)   {
	    exchange_rates[i] = d*exchange_rates[i+1];
	    put_values[i] = (pDown*put_values[i]+pUp*put_values[i+1])*Rinv;
	    put_values[i] = max(put_values[i], X-exchange_rates[i]); // check for exercise
	}
    }
  return put_values[0];
}
