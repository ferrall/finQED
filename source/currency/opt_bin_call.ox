// file currency_opt_bin_call.cc
// author: Bernt A Oedegaard

#include <oxstd.h>

currency_option_price_call_american_binomial(S,X,r,r_f,sigma,time,no_steps) {
    decl exchange_rates = zeros(1,no_steps+1);
    decl call_values = zeros(1,no_steps+1);
    decl t_delta= time/no_steps;
    decl Rinv = exp(-r*(t_delta));
    decl u = exp(sigma*sqrt(t_delta));
    decl d = 1.0/u;
    decl uu= u*u;
    decl pUp   = (exp((r-r_f)*t_delta)-d)/(u-d); // adjust for foreign decl.rate
    decl pDown = 1.0 - pUp;
    exchange_rates[0] = S*pow(d, no_steps);
    decl i;
    for (i=1; i<=no_steps; ++i) {
	exchange_rates[i] = uu*exchange_rates[i-1]; // terminal tree nodes
    }
    for (i=0; i<=no_steps; ++i) call_values[i] = max(0.0, (exchange_rates[i]-X));
    for (decl step=no_steps-1; step>=0; --step) {
	for (i=0; i<=step; ++i)   {
	    exchange_rates[i] = d*exchange_rates[i+1];
	    call_values[i] = (pDown*call_values[i]+pUp*call_values[i+1])*Rinv;
	    call_values[i] = max(call_values[i], exchange_rates[i]-X); // check for exercise
	}
    }
    return call_values[0];
}
