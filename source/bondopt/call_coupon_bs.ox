#include "../../include/finQED.h"

bond_option_price_call_coupon_bond_black_scholes(B,X,r,sigma,time,coupon_times,coupon_amounts)
{
	// subtract present value of coupons
	decl idx = vecindex(coupon_times .<= time);
	if (sizerc(idx))
		B -= double(sumc(vec(coupon_amounts[idx]) .* exp(-r*vec(coupon_times[idx]))));
    return bond_option_price_call_zero_black_scholes(B,X,r,sigma,time);
}
