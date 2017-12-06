#include "../../include/finQED.h"  // the regular black sholes formula

option_price_american_call_dividend(S,X,r,sigma,tau,D1,tau1)
{
    if (D1 <= X* (1.0-exp(-r*(tau-tau1)))) // check for no exercise
       return option_price_call_black_scholes(S-exp(-r*tau1)*D1,X,r,sigma,tau);

    decl sigma_sqr = sigma*sigma;
    decl tau_sqrt = sqrt(tau);
    decl tau1_sqrt = sqrt(tau1);
    decl rho = - sqrt(tau1/tau);

    decl S_bar = 0;  // first find the S_bar that solves c=S_bar+D1-X
    decl S_low=0;    // the simplest: binomial search
    decl S_high=S;  // start by finding a very high S above S_bar
    decl c = option_price_call_black_scholes(S_high,X,r,sigma,tau-tau1);
    decl test = c-S_high-D1+X;
    while ( (test>0.0) && (S_high<=1e10) )
	{
        S_high *= 2.0;
        c = option_price_call_black_scholes(S_high,X,r,sigma,tau-tau1);
        test = c-S_high-D1+X;
    }
    if (S_high>1e10)  // early exercise never optimal, find BS value
    {   return option_price_call_black_scholes(S-D1*exp(-r*tau1),X,r,sigma,tau);
    }

    S_bar = 0.5 * S_high;  // now find S_bar that solves c=S_bar-D+X
    c = option_price_call_black_scholes(S_bar,X,r,sigma,tau-tau1);
    test = c-S_bar-D1+X;
    while ( (fabs(test)>FNR_ACCURACY) && ((S_high-S_low)>FNR_ACCURACY) )
	{
        if (test<0.0) { S_high = S_bar; }
        else { S_low = S_bar; }
        S_bar = 0.5 * (S_high + S_low);
        c = option_price_call_black_scholes(S_bar,X,r,sigma,tau-tau1);
        test = c-S_bar-D1+X;
    }
    decl a1 =  (log((S-D1*exp(-r*tau1))/X) +( r+0.5*sigma_sqr)*tau)
       / (sigma*tau_sqrt);
    decl a2 = a1 - sigma*tau_sqrt;
    decl b1 = (log((S-D1*exp(-r*tau1))/S_bar) + (r+0.5*sigma_sqr)*tau1)
       / (sigma*tau1_sqrt);
    decl b2 = b1 - sigma * tau1_sqrt;
    decl C = (S-D1*exp(-r*tau1)) * probn(b1)
       + (S-D1*exp(-r*tau1)) * probbvn(a1,-b1,rho)
       - (X*exp(-r*tau))*probbvn(a2,-b2,rho)
       - (X-D1)*exp(-r*tau1)*probn(b2);
    return C;
}
