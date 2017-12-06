#include "../../include/finQED.h"

option_price_american_call_approximated_baw( S,X,r,b,sigma,time)
{
    decl sigma_sqr = sigma*sigma;
    decl time_sqrt = sqrt(time);
    decl nn = 2.0*b/sigma_sqr;
    decl m = 2.0*r/sigma_sqr;
    decl K = 1.0-exp(-r*time);
    decl q2 = (-(nn-1)+sqrt(pow((nn-1),2.0)+(4*m/K)))*0.5;

    // seed value from paper
    decl q2_inf = 0.5 * ( (-nn-1.0) + sqrt(pow((nn-1),2.0)+4.0*m));
    decl S_star_inf = X / (1.0 - 1.0/q2_inf);
    decl h2 = -(b*time+2.0*sigma*time_sqrt)*(X/(S_star_inf-X));
    decl S_seed = X + (S_star_inf-X)*(1.0-exp(h2));

    decl no_iterations=0; // iterate on S to find S_star, using Newton steps
    decl Si=S_seed;
    decl g=1;
    decl gprime=1.0;
    while ((fabs(g) > FNR_ACCURACY)
	   && (fabs(gprime)>FNR_ACCURACY) // to avoid exploding Newton's
	   && ( no_iterations++<FNR_MAXIT)
	   && (Si>0.0)) {
	decl c  = option_price_european_call_payout(Si,X,r,b,sigma,time);
	decl d1 = (log(Si/X)+(b+0.5*sigma_sqr)*time)/(sigma*time_sqrt);
	g=(1.0-1.0/q2)*Si-X-c+(1.0/q2)*Si*exp((b-r)*time)*probn(d1);
	gprime=( 1.0-1.0/q2)*(1.0-exp((b-r)*time)*probn(d1))
	    +(1.0/q2)*exp((b-r)*time)*densn(d1)*(1.0/(sigma*time_sqrt));
	Si=Si-(g/gprime);
    }
    decl S_star = 0;
    if (fabs(g)>FNR_ACCURACY) { S_star = S_seed; } // did not converge
    else { S_star = Si; }
    decl C=0;
    decl c  = option_price_european_call_payout(S,X,r,b,sigma,time);
    if (S>=S_star) {
	C=S-X;
    }
    else {
	decl d1 = (log(S_star/X)+(b+0.5*sigma_sqr)*time)/(sigma*time_sqrt);
	decl A2 =  (1.0-exp((b-r)*time)*probn(d1))* (S_star/q2);
	C=c+A2*pow((S/S_star),q2);
    }
    return max(C,c); // know value will never be less than BS value
}
