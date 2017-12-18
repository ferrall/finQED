#include <oxstd.h>
/**This function combines lookback call option and lookback put option.
The estimation of the option value relies on the analytical solution of Goldman. Sosin and Gatto (1979)**/
exotics_lookback_european(S,Smaxin,r,q,sigma,time,corp){
    if (r==q) return 0;
    decl sigma_sqr=sigma*sigma;
    decl time_sqrt = sqrt(time);
    decl a1 = (log(S/Smaxin) + (r-q+sigma_sqr/2.0)*time)/(sigma*time_sqrt);
    decl a2 = a1-sigma*time_sqrt;
    decl a3 = (log(S/Smaxin) + (-r+q+sigma_sqr/2.0)*time)/(sigma*time_sqrt);
	if (corp=="call") {decl Y1 = 2.0 * (r-q-sigma_sqr/2.0)*log(S/Smaxin)/sigma_sqr;
	    return S * exp(-q*time)*probn(a1)
     	- S * exp(-q*time)*(sigma_sqr/(2.0*(r-q)))*probn(-a1)
    	- Smaxin * exp(-r*time)*(probn(a2)-(sigma_sqr/(2*(r-q)))*exp(Y1)*probn(-a3));
	}
	if (corp=="put")  {decl Y1 = 2.0 * (r-q-sigma_sqr/2.0)*log(Smaxin/S)/sigma_sqr;   
        return 	Smaxin * exp(-r*time)*(probn(a3)-(sigma_sqr/(2*(r-q)))*exp(Y1)*probn(-a1))
	    + S * exp(-q*time)*(sigma_sqr/(2.0*(r-q)))*probn(-a2)
	    - S * exp(-q*time)*probn(a2);   }	
}
