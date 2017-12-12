#include "oxstd.h"

//set global variables:
static decl  S, X, r, sigma, time, steps, dividend_times, dividend_yields, dividend_amounts; 				

//new functions:
set_parameters(inS, inX, inr, insigma, intime, insteps, individend_times, individend_yields, individend_amounts);

//values functions:
option_price_call_european_binomial();
option_price_put_european_binomial();
option_price_call_american_binomial(S, r, sigma, time, steps, dividend_times, dividend_amounts);
option_price_put_american_binomial(S, r, sigma, time, steps, dividend_times, dividend_amounts);
option_price_call_american_discrete_dividends_binomial(S, time, steps, dividend_times, dividend_amounts);
option_price_put_american_discrete_dividends_binomial(S, time, steps, dividend_times, dividend_amounts);
option_price_call_american_proportional_dividends_binomial();
option_price_put_american_proportional_dividends_binomial();
option_price_delta_american_call_binomial();
option_price_delta_american_put_binomial();
option_price_partials_american_call_binomial(aDelta,aGamma, aTheta, aVega, aRho);
option_price_partials_american_put_binomial(aDelta,aGamma, aTheta, aVega, aRho);
