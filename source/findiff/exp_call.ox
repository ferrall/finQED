#include <oxstd.h>
/**
   This function calculates the call option price of an asset using the explicit finite difference method.

   Call option is an agreement that gives the investor the right to buy an underlying asset at a set price
   (strike price) within a time frame (until its expiration). Additionally, the main difference between an American and
   European option is when it can be exercised. A European option may be exercised only at the expiration date.
   Whereas, an American option can be exercised at any time before the expiration date.

   An explicit solution involves parameters that are calculated based on previous levels.
   Note - explicit version may not converge for certain combinations of inputs.

   This algorithm follows an iterative method that generates a sequence of solutions which are computed
   by approximating differential equations that describe how option prices evolve over time. First, we discretize
   the Black-Scholes-Merton partial differential equation (PDE). Then create a matrix (grid) of possible current and
   future prices for the underlying asset. Next we calculate the payoff of the option at specfic boundaries of that
   matrix. And finally, through an iterative process we calculate the option price at all other points in the matrix.
   
   Parameters: S - spot price of underlying asset
               X - strike price (exercise price)
               r - risk free interest rate
               sigma - volatility
               time - time to maturity
               no_S_steps - number of steps in S dimension
               no_t_steps - number of steps in time dimension
               type - must be American or European

   Return: callP - the call price of American or European option 
*/

enum{American,European,OptionType} // choices for option type

option_price_call_finite_diff_explicit(S, X, r, sigma, time, no_S_steps, no_t_steps, type) {

   decl sigma_sqr, M, N, delta_S, delta_t, m;
   setup_parameters(S, X, r, sigma, time, no_S_steps, no_t_steps, &sigma_sqr, &M, &delta_S, &N, &delta_t);

   // initialize vector for potential option prices
   decl S_values = zeros(1,M+1); 
   // allocate values for vector of potential option prices
   for (m=0;m<=M;m++) { S_values[m] = m*delta_S; }
   
   // initialize coefficients for finite difference equation
   decl a = zeros(1,M);
   decl b = zeros(1,M);
   decl c = zeros(1,M);
   
   decl r1=1.0/(1.0+r*delta_t);
   decl r2=delta_t/(1.0+r*delta_t);

   // discretize the Black-Scholes-Merton PED
   for (decl j=1;j<M;j++){ 
      a[j] = r2*0.5*j*(-r+sigma_sqr*j);	     //	backward approximation
      b[j] = r1*(1.0-sigma_sqr*j*j*delta_t); // central approximation
      c[j] = r2*0.5*j*(r+sigma_sqr*j);		 //	standard approximation
   }
   // get boundary conditions by calculating the payoff at each point on the boundary of the matrix
   decl f_next = zeros(1,M+1);
   for (m=0;m<=M;++m) {
       f_next[m]=max(0.0,S_values[m]-X); // payoff for call option
   }
   // use the value of the option at the boundary condition (at expiry) to determine all other interior prices in the
   // matrix, which can be calculated by working iteratively backwards through time until option price at t=0 (today)
   decl f = zeros(1,M+1);
   for (decl t=N-1;t>=0;--t) { 
          f[0]=0;  
      for (m=1;m<M;++m) {
	      if (type == American){ // American option	  
		      f[m] = a[m]*f_next[m-1]+b[m]*f_next[m]+c[m]*f_next[m+1];
	          f[m] = max(f[m],S_values[m]-X);  // check if the asset is worth more exercised early
          }
		  else {  // European option
		      f[m]=a[m]*f_next[m-1]+b[m]*f_next[m]+c[m]*f_next[m+1];
		  }
	  }
         if (type == American){	
		     f[M] = S_values[M]-X;
		 }
		 else { // European option
		     f[M] = 0;
		 }	 
      for (m=0;m<=M;++m) {
	      f_next[m] = f[m];
	  }
   }
   // typically the current price of the underlying asset lies close to the middle of the M steps of the matrix.
   decl callP = f[M/2]; 
   return callP;
}
