// file simulate_general_payoff_average.cc

#include <oxstd.h>

payoff_arithmetic_average(prices) {
    decl avg = meanc(vec(prices));
    return max(0.0,avg-prices[sizerc(prices)-1]);
}

payoff_geometric_average(prices) {
//    logsum=log(prices[0]);
//   for (i=1;i<sizerc(prices);++i){ logsum+=log(prices[i]); }
//    avg = exp(logsum/sizerc(prices));
    decl avg = exp(meanc(vec(log(prices))));
    return max(0.0,avg-prices[sizerc(prices)-1]);
}
