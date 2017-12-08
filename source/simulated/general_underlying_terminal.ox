// file simulate_underlying_terminal.cc

#include <oxstd.h>
/**
support the function 'derivative_price_european_simulated2'
simply calculate the terminal price of underlying asset using lognormal random variable
**/

simulate_terminal_price( S,  	// current value of underlying
			       		 r,  	// interest rate
			       		 sigma, // volatitily
			       		 time)  // time to final date
{
    parameters_calculation1(r,sigma,time);
    return S * exp(R + SD * rann(1,1));
}
