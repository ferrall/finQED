#include "../../include/finQED.h"

static const decl HIGH_VALUE = 1e10;
static const decl ERROR = .NaN;

option_price_implied_volatility_call_black_scholes_bisections(S,X,r,time,option_price)
{ // check for arbitrage violations:
    // if price at almost zero volatility greater than price, return 0

     decl sigma_low=0.0001;
     decl price = option_price_call_black_scholes(S,X,r,sigma_low,time);
    if (price>option_price) return 0.0;

    // simple binomial search for the implied volatility.
    // relies on the value of the option increasing in volatility

    // want to bracket sigma. first find a maximum sigma by finding a sigma
    // with a estimated price higher than the actual price.
    decl sigma_high=0.3;
    price = option_price_call_black_scholes(S,X,r,sigma_high,time);
    while (price < option_price)
	{
		sigma_high = 2.0 * sigma_high; // keep doubling.
		price = option_price_call_black_scholes(S,X,r,sigma_high,time);
		if (sigma_high>HIGH_VALUE) return ERROR; // panic, something wrong.
    }
    for (decl i=0;i<FNR_MAXIT;i++)
	{
		decl sigma = (sigma_low+sigma_high)*0.5;
		price = option_price_call_black_scholes(S,X,r,sigma,time);
		decl test =  (price-option_price);
		if (fabs(test)<FNR_ACCURACY) { return sigma; }
		if (test < 0.0) { sigma_low = sigma; }
		else { sigma_high = sigma; }
    }
    return ERROR;
}

option_price_implied_volatility_call_black_scholes_newton(S,X,r,time,option_price)
{
	// check for arbitrage violations:
	// if price at almost zero volatility greater than price, return 0
	decl sigma_low = 1e-5;
	decl price = option_price_call_black_scholes(S,X,r,sigma_low,time);
	if (price > option_price) return 0.0;
	
	decl t_sqrt = sqrt(time);
	
	decl sigma = (option_price/S)/(0.398*t_sqrt);    // find initial value
	for (decl i=0;i<FNR_MAXIT;i++)
	{
		price = option_price_call_black_scholes(S,X,r,sigma,time);
		decl diff = option_price -price;
		if (fabs(diff)<FNR_ACCURACY) return sigma;
		decl d1 = (log(S/X)+r*time)/(sigma*t_sqrt) + 0.5*sigma*t_sqrt;
		decl vega = S * t_sqrt * densn(d1);
		sigma = sigma + diff/vega;
	}
	return ERROR;  // something screwy happened, should throw exception
}
