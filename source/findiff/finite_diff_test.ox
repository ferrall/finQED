#include <oxstd.h>
#import "finQED"
#include "exp_put.ox"

finite_diff_test(){
    decl c, S, X, r, sigma, time, no_S_steps, no_t_steps, type;
	println("To run the finite difference test, we need the following parameters\n");
	c = scan("Enter a S: %f", &S,
             "Enter a X: %f", &X,
			 "Enter a rate, r: %f", &r,
			 "Enter a sigma: %f", &sigma,
			 "Enter a time to maturity: %f", &time,
			 "Enter a number of steps in S: %f", &no_S_steps,
			 "Enter a number of steps in time (t): %f", &no_t_steps,
			 "Enter your option of price option (either 'American' or 'European')\n: %f", &type);
    println("items read =", c, " S =", S, " X =", X, " rate =", r, " sigma =", sigma, " time =", time, " # s steps =", no_S_steps, " # t steps =", no_t_steps, " price option =", type, "\n");

	println("exp_put:", option_price_put_finite_diff_explicit(S,X,r,sigma,time,no_S_steps,no_t_steps, type));
}

main(){
finite_diff_test();
}