#include "../../include/finQED.h"

bond_option_price_call_zero_vasicek(X,  // exercise price
					    r, // current interest rate
					    option_time_to_maturity,
					    bond_time_to_maturity,
					    a,  // parameters
					    b,
					    sigma)
{
    decl T_t = option_time_to_maturity;
    decl s_t = bond_time_to_maturity;
    decl T_s = s_t-T_t;
    decl v_t_T;
    decl sigma_P;
    if (a==0.0)
	{
		v_t_T = sigma * sqrt ( T_t );
		sigma_P = sigma*T_s*sqrt(T_t);
    }
    else
	{
		v_t_T = sqrt (sigma*sigma*(1-exp(-2*a*T_t))/(2*a));
		decl B_T_s = (1-exp(-a*T_s))/a;
		sigma_P = v_t_T*B_T_s;
    }
    decl h = (1.0/sigma_P) * log (
		term_structure_discount_factor_vasicek(s_t,r,a,b,sigma)/
		(term_structure_discount_factor_vasicek(T_t,r,a,b,sigma)*X) )
		+ sigma_P/2.0;
    decl c =
		term_structure_discount_factor_vasicek(s_t,r,a,b,sigma)*probn(h)
		-X*term_structure_discount_factor_vasicek(T_t,r,a,b,sigma)*probn(h-sigma_P);
    return c;
}
