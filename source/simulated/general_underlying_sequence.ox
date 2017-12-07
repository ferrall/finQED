// file: simulate_underlying_sequence.cc
#include <oxstd.h>
/**
this fuction simulate a sequence of lognormally distributed variables
support the function 'derivative_price_european_simulated 1 / 3'
separate the time to final date into several steps
calculate the price of underlying asset of each step
**/
simulate_price_sequence(S, 		// current value of underlying
			     		 r,  		// interest rate
			     		 sigma,  	// volatitily
			     		 time,  	// time to final date
			     		 no_steps)  // number of steps
{
    decl delta_t = time / no_steps;
    decl R = (r - 0.5 * sqr(sigma)) * delta_t;
    decl SD = sigma * sqrt(delta_t);
	return S * cumprod(exp(R + SD * rann(no_steps, 1)))'; /** cumprod returns a 1 by no_steps matrix here with the cumulated autoregressive product**/
}
