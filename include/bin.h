 option_price_call_european_binomial(S, X, r, sigma, time, steps);
option_price_put_european_binomial(S, X, r, sigma, time, steps);
option_price_call_american_binomial(S, X, r, sigma, time, steps);
option_price_put_american_binomial(S, X, r, sigma, time, steps);
option_price_call_american_discrete_dividends_binomial(S, X, r, sigma, time,
steps,dividend_times, dividend_amounts);
option_price_put_american_discrete_dividends_binomial(S, X, r, sigma, time,
steps,dividend_times, dividend_amounts);
option_price_call_american_proportional_dividends_binomial(S, X, r, sigma, time,
no_steps,dividend_times, dividend_yields);
option_price_put_american_proportional_dividends_binomial(S, X, r, sigma, time,
no_steps,dividend_times, dividend_yields);
option_price_delta_american_call_binomial(S, X, r, sigma, time, no_steps);
option_price_delta_american_put_binomial(S, X, r, sigma, time, no_steps);
option_price_partials_american_call_binomial(S, X, r, sigma, time, no_steps,aDelta,
aGamma, aTheta, aVega, aRho);
option_price_partials_american_put_binomial(S,  X, r, sigma, time, no_steps,aDelta,
aGamma, aTheta, aVega, aRho);
