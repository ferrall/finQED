#include <oxstd.h>
#import "financialNR"

test_zero_coupon_call()
{
    println(" Zero Coupon Call ");
    decl X=1000;                   // exercise price
    decl S=0.15;
    decl M=0.05;                   // term structure paramters
    decl interest=0.10;            // current short interest rate
    decl no_steps=100;
    decl option_maturity=4;
    decl bond_maturity=5;
    decl maturity_payment=1000;
    X=900;
    println(" option on zero coupon bond ");
    decl c =  bond_option_price_call_zero_american_rendleman_bartter(
       X, option_maturity, S, M, interest, bond_maturity, maturity_payment, no_steps);
    println("   c = ", c);
}
main()
{
   println("START testing Rendleman and Bartter ");
   test_zero_coupon_call();
   println("DONE testing Rendleman and Bartter ");
}
