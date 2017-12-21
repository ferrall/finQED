// file simulate_general_payoff_average.cc

#include <oxstd.h>
/**
Two methods using average to evaluate the payoff
In Asian options, the payoff is calculated on the basis of average because the strike price is the average price of the underlying during time to final date.
1: arithmetic average
2: geometric average
# for put option
**/

payoff_arithmetic_average(prices) {
    decl avg = meanc(vec(prices));
    return max(0.0,avg-prices[sizerc(prices)-1]);	 // prices[sizerc(prices)-1] : the price of the underlying on the final date
	                                                 // avg: the strike price
}

payoff_geometric_average(prices) {
//    logsum=log(prices[0]);
//   for (i=1;i<sizerc(prices);++i){ logsum+=log(prices[i]); }
//    avg = exp(logsum/sizerc(prices));
    decl avg = exp(meanc(vec(log(prices))));
    return max(0.0,avg-prices[sizerc(prices)-1]);
}
