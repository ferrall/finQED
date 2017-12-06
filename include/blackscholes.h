option_price_call_black_scholes(S, X, r, sigma, time);
option_price_put_black_scholes(S, X, r, sigma, time);
option_price_implied_volatility_call_black_scholes_newton(S, X, r, time, option_price);
option_price_implied_volatility_call_black_scholes_bisections(S, X, r, time,
option_price);
option_price_delta_call_black_scholes(S, X, r, sigma, time);
option_price_delta_put_black_scholes(S, X, r, sigma, time);
option_price_partials_call_black_scholes(S, X, r, sigma, time,aDelta, aGamma, aTheta,
aVega, aRho);
option_price_partials_put_black_scholes(S, X, r, sigma, time,aDelta, aGamma, aTheta,
aVega, aRho);
option_price_european_call_payout(S, X, r, q, sigma, time);
option_price_european_put_payout(S, X, r, q, sigma, time);
option_price_european_call_dividends(S, X, r, sigma, time_to_maturity,dividend_times,
dividend_amounts);
option_price_european_put_dividends(S, X, r, sigma, time_to_maturity,dividend_times,
dividend_amounts);
option_price_american_call_dividend(S, X, r, sigma, tau,D1, tau1);
