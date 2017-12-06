// file bondopt_put_bs.cc
// author: Bernt A Oedegaard.

#include <oxstd.h>

bond_option_price_put_zero_black_scholes(B,X,r,sigma,time)
{
    decl time_sqrt = sqrt(time);
    decl d1 = (log(B/X)+r*time)/(sigma*time_sqrt) + 0.5*sigma*time_sqrt;
    decl d2 = d1-(sigma*time_sqrt);
    decl p =  X * exp(-r*time) * probn(-d2) - B * probn(-d1);
    return p;
}
