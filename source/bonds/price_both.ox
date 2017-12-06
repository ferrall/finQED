// file bonds_price_both.cc
// author: Bernt A Oedegaard.

#include <oxstd.h>

/*calculate bond price when term structure is flat, given both coupon and principals*/
bonds_price_both(coupon_times,coupon_amounts,principal_times,principal_amounts,r)
{
    decl p = sumc(exp(-r*vec(coupon_times)).*vec(coupon_amounts));
	p += sumc(exp(-r*vec(principal_times)).*vec(principal_amounts));
    return double(p);
}
