#include <oxstd.h>
#import "findiff"
#import "finQED"

enum{American,European,OptionType} // choices for option type

finite_differences()
{
    println("START testing finite differences\n");
    decl S = 50.0;
    decl X = 50.0;
    decl r = 0.1;
    decl sigma = 0.4;
    decl time=0.4167;
    decl no_S_steps=20;
    decl no_t_steps=11;
	println("Call prices:\n");
    println(" Black scholes call price = ",
    	option_price_call_black_scholes(S,X,r,sigma,time));
	decl type = American;
    println(" Explicit FD American call price = ",
    	option_price_call_finite_diff_explicit(S,X,r,sigma,time,no_S_steps,no_t_steps, type));
	println(" Implicit FD American call price = ",
    	option_price_call_finite_diff_implicit(S,X,r,sigma,time,no_S_steps,no_t_steps, type));
		
	println("\n");
	println("Put prices:\n");
    println(" Black scholes put price = ",
    	option_price_put_black_scholes(S,X,r,sigma,time));
	type = European;
    println(" Explicit Euro put price = ",
    	option_price_put_finite_diff_explicit(S,X,r,sigma,time,no_S_steps,no_t_steps, type));
    println(" Implicit Euro put price = ",
    	option_price_put_finite_diff_implicit(S,X,r,sigma,time,no_S_steps,no_t_steps, type));
	type = American;
    println(" Explicit American put price = ",
    	option_price_put_finite_diff_explicit(S,X,r,sigma,time,no_S_steps,no_t_steps, type));
    println(" Implicit American put price = ",
    	option_price_put_finite_diff_implicit(S,X,r,sigma,time,no_S_steps,no_t_steps, type));
    println("\nDONE testing finite differences ");
	
}

