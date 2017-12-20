#include <oxstd.h>

/*
   This function calculates the variables required for finite difference method.

*/

setup_parameters(S, X, r, sigma, time, no_S_steps, no_t_steps, sigma_sqr, M, delta_S, N, delta_t){

    sigma_sqr[0] = sigma*sigma;
    M[0]=no_S_steps; // need M to be even:
    if (idiv(no_S_steps,2)==1) { M[0]=no_S_steps+1;} else { M[0]=no_S_steps;}
    delta_S[0] = 2.0*S/M[0];	// increment of asset price
	N[0]=no_t_steps;
    delta_t[0] = time/N[0]; // time step

}