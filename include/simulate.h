option_price_call_european_simulated(S, X, r, sigma, time, no_sims);
option_price_put_european_simulated(S, X, r, sigma, time, no_sims);
option_price_delta_call_european_simulated(S, X, r, sigma, time, no_sims);
option_price_delta_put_european_simulated(S, X, r, sigma, time, no_sims);

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
