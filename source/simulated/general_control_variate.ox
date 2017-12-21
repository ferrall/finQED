#include "../../include/finQED.h"
/**
To improve the implementation of Monte Carlo estimation, use the method of control variates
The idea is that when one generates the set of terminal values of the underlying security, one can value several derivatives using the same set of terminal value
We use both the Black Scholes formula and Monte Carlo simulation.
If it turns out that the Monte Carlo estimate overvalues the option price, this may also be the case for other derivatives valued using the same set of simulated terminal values.
So in this function, we estimate the option using Monte Carlo, calculate the Black Scholes value and then calculate the put price with a control variate adjustment. 
**/
derivative_price_european_simulated_control_variate(
	 S,r,sigma,time,payoff,	no_steps,no_sims)
{
    decl X = S;
    decl c_bs = option_price_call_black_scholes(S,X,r,sigma,time); // price of the Black Scholes Euro call option
    decl prices;
    decl sum_payoffs = 0;
    decl sum_payoffs_bs = 0;
	
    for (decl n=0; n<no_sims; n++)
	{
        prices = simulate_price_sequence(S,r,sigma,time,no_steps);
        sum_payoffs += payoff(prices);		// simulate the prices of a certain option using Monte Carlo 
        sum_payoffs_bs += payoff_european_call(prices[sizerc(prices)-1],X);	  // simulate the Black Scholes Euro call option prices using Monte Carlo
    }
    decl c_sim = pvoption(r,time,no_sims,sum_payoffs);	// calculate the average PV of a certain option prices	
    decl c_bs_sim = pvoption(r,time,no_sims,sum_payoffs_bs); // calculate the average PV of Black Scholes option prices
    c_sim += (c_bs-c_bs_sim);  /** calculate the control variate adjustment (c_bs-c_bs_sim), which means the undervaluing part of Monte Calo simulation over Black Scholes calcultaion of the euro call option
								   and add the control variate adjustment to the simulation price of the certain option.
							   **/
    return c_sim;
}
