#include "oxstd.h"
static decl  S, X, r, sigma, time, steps, dividend_times, dividend_yields, dividend_amounts;

set_parameters(inS, inX, inr, insigma, intime, insteps, individend_times, individend_yields, individend_amounts);

option_price_european_binomial(option);
option_price_american_binomial(option);
option_price_call_american_discrete_dividends_binomial();
option_price_put_american_discrete_dividends_binomial();
option_price_call_american_discrete_dividends_binomial_recursive(S,time,steps,dividend_times,dividend_amounts);
option_price_put_american_discrete_dividends_binomial_recursive(S,time,steps,dividend_times,dividend_amounts);
option_price_american_proportional_dividends_binomial(option);
option_price_delta_american_binomial(option);
option_price_partials_american_call_binomial(aDelta,aGamma, aTheta, aVega, aRho);
option_price_partials_american_put_binomial(aDelta,aGamma, aTheta, aVega, aRho);
