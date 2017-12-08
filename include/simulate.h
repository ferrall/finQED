parameters_calcultaion1(r,sigma,time);
parameters_calculation2(r,sigma,time,no_steps);
pvoption(r,time,no_sims,sum_payoffs);


//option_price_euro_simulated(S, X, r, sigma, time, no_sims, corp);
option_price_call_european_simulated(S, X, r, sigma, time, no_sims);
option_price_put_european_simulated(S, X, r, sigma, time, no_sims);
option_price_delta_call_european_simulated(S, X, r, sigma, time, no_sims);
option_price_delta_put_european_simulated(S, X, r, sigma, time, no_sims);
//option_price_delta_european_simulated(S,X,r,sigma,time,no_sims,corp) ;
derivative_price_european_simulated2(S, X, r, sigma, time,payoff, no_sims);
derivative_price_european_simulated1(S, r, sigma, time,payoff, no_steps, no_sims);
derivative_price_european_simulated3(S, X, r, sigma, time,payoff, no_steps, no_sims);
derivative_price_european_simulated_control_variate(S, r, sigma, time,payoff, no_steps, no_sims);

simulate_terminal_price(S, r, sigma, time);
simulate_price_sequence(S, r, sigma, time, no_steps);
payoff_european_call(price, X);
payoff_european_put(price, X);
payoff_min(prices);
payoff_max(prices);
payoff_geometric_average(prices);
payoff_arithmetic_average(prices);

/*struct option_price_european_simulated {
    decl S,X,no_sims,r,time；  
    call(S,X,no_sims,r,time);
    put(S,X,no_sims,r,time);
    }
*/