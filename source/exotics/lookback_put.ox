// file exotics_lookback_put.cc
// author: Bernt A Oedegaard

#include <oxstd.h>

exotics_lookback_european_put( S,Smax,r,q,sigma,time)
{
    if (r==q) return 0;
    decl sigma_sqr=sigma*sigma;
    decl time_sqrt = sqrt(time);
    decl b1 = (log(S/Smax) + (-r+q+sigma_sqr/2.0)*time)/(sigma*time_sqrt);
    decl b2 = b1-sigma*time_sqrt;
    decl b3 = (log(S/Smax) + (r-q-sigma_sqr/2.0)*time)/(sigma*time_sqrt);
    decl Y2 = (2.0 * (r-q-sigma_sqr/2.0)*log(Smax/S))/sigma_sqr;
    decl p =
	Smax * exp(-r*time)*(probn(b1)-(sigma_sqr/(2*(r-q)))*exp(Y2)*probn(-b3))
	+ S * exp(-q*time)*(sigma_sqr/(2.0*(r-q)))*probn(-b2)
	- S * exp(-q*time)*probn(b2);
    return p;
}
