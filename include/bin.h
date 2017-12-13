#include "oxstd.h"

//set global variables:
static decl  S, X, r, sigma, time, steps, dividend_times, dividend_yields, dividend_amounts; 				

//new functions:
set_parameters(inS, inX, inr, insigma, intime, insteps, individend_times, individend_yields, individend_amounts);
initial_calcs(r, sigma, R, Rinv, u, uu, d, p_up, p_down);
values_calc(option, LB, S, steps, Rinv, uu, d, p_up, p_down, values, inprices);

//values functions:
option_price_european_binomial(option);
option_price_american_binomial(option);
option_price_american_discrete_dividends_binomial(option, S, time, steps, dividend_times, dividend_amounts);
option_price_american_proportional_dividends_binomial(option);
option_price_delta_american_binomial(option);
option_price_partials_american_binomial(option, aDelta,aGamma, aTheta, aVega, aRho);
