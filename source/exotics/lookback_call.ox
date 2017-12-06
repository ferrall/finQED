// file exotics_lookback_call.cc
// author: Bernt A Oedegaard

#include <oxstd.h>

exotics_lookback_european_call(S,Smin,r,q,sigma,time){
    if (r==q) return 0;
    decl sigma_sqr=sigma*sigma;
    decl time_sqrt = sqrt(time);
    decl a1 = (log(S/Smin) + (r-q+sigma_sqr/2.0)*time)/(sigma*time_sqrt);
    decl a2 = a1-sigma*time_sqrt;
    decl a3 = (log(S/Smin) + (-r+q+sigma_sqr/2.0)*time)/(sigma*time_sqrt);
    decl Y1 = 2.0 * (r-q-sigma_sqr/2.0)*log(S/Smin)/sigma_sqr;
    return S * exp(-q*time)*probn(a1)
	- S * exp(-q*time)*(sigma_sqr/(2.0*(r-q)))*probn(-a1)
	- Smin * exp(-r*time)*(probn(a2)-(sigma_sqr/(2*(r-q)))*exp(Y1)*probn(-a3));
}
