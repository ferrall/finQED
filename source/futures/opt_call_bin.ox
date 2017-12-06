// file: futures_opt_call_bin.cc
// author: Bernt A Oedegaard

#include <oxstd.h>

futures_option_price_call_american_binomial(F,X,r,sigma,time,no_steps) {
    decl futures_prices = zeros(1,no_steps+1);
    decl call_values = zeros(1,no_steps+1);
    decl t_delta= time/no_steps;
   decl Rinv = exp(-r*(t_delta));
   decl u = exp(sigma*sqrt(t_delta));
   decl d = 1.0/u;
   decl uu= u*u;
   decl pUp   = (1-d)/(u-d);   // note how probability is calculated
   decl pDown = 1.0 - pUp;
   futures_prices[0] = F*pow(d, no_steps);
   decl i;
   for (i=1; i<=no_steps; ++i) futures_prices[i] = uu*futures_prices[i-1]; // terminal tree nodes
   for (i=0; i<=no_steps; ++i) call_values[i] = max(0.0, (futures_prices[i]-X));
   for (decl step=no_steps-1; step>=0; --step) {
      for (i=0; i<=step; ++i)   {
	 futures_prices[i] = d*futures_prices[i+1];
	 call_values[i] = (pDown*call_values[i]+pUp*call_values[i+1])*Rinv;
	 call_values[i] = max(call_values[i], futures_prices[i]-X); // check for exercise
      }
   }
   return call_values[0];
}
