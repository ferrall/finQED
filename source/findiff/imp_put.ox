#include <oxstd.h>

/**
   This function calculates the put option price of an asset using the implicit finite difference method.

   Put option is an agreement that gives the investor the right to sell an underlying asset at a set price
   (strike price) within a time frame (until its expiration). Additionally, the main difference between an American and
   European option is when it can be exercised. A European option may be exercised only at the expiration date.
   Whereas, an American option can be exercised at any time before the expiration date.

   A implicit solution involves parameters that are dependent on each other at the same level. Implicit methods
   allow for larger time steps and better stability.

   This algorithm follows an iterative method that generates a sequence of solutions which are computed
   by approximating differential equations that describe how option prices evolve over time. First, we discretize
   the Black-Scholes-Merton partial differential equation (PDE). Then create a matrix (grid) of possible current and
   future prices for the underlying asset. Next we calculate the payoff of the option at specfic boundaries of that
   matrix. And finally, through an iterative process we calculate the option price at all other points in the matrix.

   Parameters: S - spot price of underlying asset
               X - strike	price (exercise price)
               r - risk free interest rate
               sigma - volatility
               time - time to maturity
               no_S_steps - number of steps in S dimension
               no_t_steps - number of steps in time dimension
               type - must be American or European

   Return: putP - the put price of American or European option
*/

enum{American,European,OptionType} // choices for option type

option_price_put_finite_diff_implicit(S,X, r,sigma,time,no_S_steps,no_t_steps, type){

    decl sigma_sqr, M, N, delta_S, delta_t, m;
    setup_parameters(S, X, r, sigma, time, no_S_steps, no_t_steps, &sigma_sqr, &M, &delta_S, &N, &delta_t);
	
   	// initialize vector for potential option prices
    decl S_values = zeros(1,M+1); 
	// allocate values for vector of potential option prices
    for (m=0;m<=M;m++) { S_values[m] = m*delta_S; }

    decl A = unit(M+1);	// currently not using that A is a band matrix
	// discretize the Black-Scholes-Merton PED
    for (decl j=1;j<M;++j) {
		A[j][j-1] = 0.5*j*delta_t*(r-sigma_sqr*j);    // a[j] - forward approximation
		A[j][j]   = 1.0 + delta_t*(r+sigma_sqr*j*j);  // b[j] - central approximation
		A[j][j+1] = 0.5*j*delta_t*(-r-sigma_sqr*j);   // c[j] - standard approximation
    }
	// get boundary conditions by calculating the payoff at each point on the boundary of the matrix
	decl Ainv = invert(A);
    decl B = zeros(M+1,1);
    for (m=0;m<=M;++m){
	    B[m] = max(0.0,X-S_values[m]); // payoff for put option
	}
	// use the value of the option at the boundary condition (at expiry) to determine all other interior prices in the
    // matrix, which can be calculated by working iteratively backwards through time until option price at t=0 (today)
    decl F=Ainv*B;
    for(decl t=N-1;t>0;--t) {
	     B = F;
	     F = Ainv*B;
		 if (type == American){ // American option
		     for (m=1;m<M;++m) { // check if the asset is worth more exercised early
	             F[m] = max(F[m], X-S_values[m]);
	         }
		}
    }
	// typically the current price of the underlying asset lies close to the middle of the M steps of the matrix.
	decl putP = F[M/2];
    return putP;
}
