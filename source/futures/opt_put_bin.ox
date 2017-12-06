// file futures_opt_put_bin.cc
// author: Bernt A Oedegaard

#include <oxstd.h>

futures_option_price_put_american_binomial(F,X,r,sigma,  time,  no_steps){
   decl futures_prices = zeros(1,no_steps+1);
   decl put_values = zeros(1,no_steps+1);
   decl t_delta= time/no_steps;
   decl Rinv = exp(-r*(t_delta));
   decl u = exp(sigma*sqrt(t_delta));
   decl d = 1.0/u;
   decl uu= u*u;
   decl uInv=1.0/u;
   decl pUp   = (1-d)/(u-d);
   decl pDown = 1.0 - pUp;
   futures_prices[0] = F*pow(d, no_steps);
   decl i;
   for (i=1; i<=no_steps; ++i)
      futures_prices[i] = uu*futures_prices[i-1]; // terminal tree nodes
   for (i=0; i<=no_steps; ++i) put_values[i] = max(0.0, (X-futures_prices[i]));
   for (decl step=no_steps-1; step>=0; --step) {
      for (i=0; i<=step; ++i)   {
	 futures_prices[i] = uInv*futures_prices[i+1];
	 put_values[i] = (pDown*put_values[i]+pUp*put_values[i+1])*Rinv;
	 put_values[i] = max(put_values[i], X-futures_prices[i]); // check for exercise
      }
   }
   return put_values[0];
}
