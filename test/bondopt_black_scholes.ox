#include <oxstd.h>
#import "financialNR"

test_bondopt_black_scholes()
{
    println("START testing Black Scholes Bond options ");
    decl B=100;
    decl X=100;
    decl r=0.05;
    decl sigma=0.1;
    decl time=1;
    println(" call ",
		bond_option_price_call_zero_black_scholes( B,X,r,sigma,time),
    		" put ",
		bond_option_price_put_zero_black_scholes( B,X,r,sigma,time));
    decl coupon_times = <0.5>;
    decl coupons = <1>;
    println(" price adjusting for coupon ");
    println(" call ",
		bond_option_price_call_coupon_bond_black_scholes(
	    	B,X,r,sigma,time,coupon_times,coupons),
    		" put ",
		bond_option_price_put_coupon_bond_black_scholes(
	    	B,X,r,sigma,time,coupon_times,coupons));
    println("DONE testing bond options Black Scholes");
}
main()
{
	test_bondopt_black_scholes();
}
