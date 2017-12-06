#include <oxstd.h>
#import "financialNR"

test_bondopt_vasicek()
{
    println("START testing Bond option, Vasicek ");
    decl a = 0.1;
    decl b = 0.1;
    decl sigma = 0.02;
    decl r = 0.05;
    println(" discount factor, t=1: ",
		term_structure_discount_factor_vasicek(1.0,r,a,b,sigma));
    decl X=0.9;
    println(" call option price ",
		bond_option_price_call_zero_vasicek(X,r,1,5,a,b,sigma));
    println(" put option price ",
		bond_option_price_put_zero_vasicek(X,r,1,5,a,b,sigma));
    println("DONE testing bond options Vasicek");
}
main()
{
	test_bondopt_vasicek();
}
