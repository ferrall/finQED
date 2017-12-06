#include "../../include/finQED.h"          // define other option pricing formulas

option_price_american_put_approximated_baw( S,
						    X,
						    r,
						    b,
						    sigma,
						    time ){
    decl sigma_sqr = sigma*sigma;
    decl time_sqrt = sqrt(time);
    decl M=2.0*r/sigma_sqr;
    decl NN=2.0*b/sigma_sqr;
    decl K=1.0-exp(-r*time);
    decl q1     = 0.5*(-(NN-1)-sqrt(pow((NN-1),2.0)+(4.0*M/K)));

    // now find initial S value
    decl q1_inf = 0.5*(-(NN-1)-sqrt(pow((NN-1),2.0)+4.0*M));
    decl S_star_star_inf=X/(1.0-1.0/q1_inf);
    decl h1 = (b*time-2*sigma*time_sqrt)*(X/(X-S_star_star_inf));
    decl S_seed=S_star_star_inf+(X-S_star_star_inf)*exp(h1);

    decl Si = S_seed;  // now do Newton iterations to solve for S**
    decl no_iterations = 0;
    decl g          = 1;
    decl gprime     = 1;
    while ((fabs(g)>FNR_ACCURACY)
	   && (fabs(gprime)>FNR_ACCURACY) // to avoid non-convergence
	   && (no_iterations++<FNR_MAXIT)
	   && Si>0.0) {
	decl p = option_price_european_put_payout(Si,X,r,b,sigma,time);
	decl d1 = (log(Si/X)+(b+0.5*sigma_sqr)*time)/(sigma*time_sqrt);
	g = X - Si - p + (1-exp((b-r)*time)*probn(-d1))*Si/q1;
	gprime = (1.0/q1-1.0)*(1.0-exp((b-r)*time)*probn(-d1))
	    + (1.0/q1)*exp((b-r)*time)*(1.0/(sigma*time_sqrt))*densn(-d1);
	Si=Si-(g/gprime);
    }
    decl S_star_star=Si;
    if (g>FNR_ACCURACY) {
	S_star_star = S_seed;
    }  // if not found g**
    decl P=0;
    decl p = option_price_european_put_payout(S,X,r,b,sigma,time);
    if (S>S_star_star) {
	decl d1 = (log(S_star_star/X)
		     + (b+0.5*sigma_sqr)*time)/(sigma*time_sqrt);
	decl A1 = -(S_star_star/q1)*(1-exp((b-r)*time)*probn(-d1));
	P= p + A1 * pow((S/S_star_star),q1);
    }
    else {
	P=X-S;
    }
    return max(P,p);  // should not be lower than Black Scholes value
}
