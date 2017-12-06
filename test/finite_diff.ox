#import "finQED"

finite_differences()
{
    println("START testing finite differences");
    decl S = 50.0;
    decl X = 50.0;
    decl r = 0.1;
    decl sigma = 0.4;
    decl time=0.4167;
    decl no_S_steps=20;
    decl no_t_steps=11;
    println(" black scholes call price = ",
    	option_price_call_black_scholes(S,X,r,sigma,time));
    println(" explicit FD American call price = ",
    	option_price_call_american_finite_diff_explicit(S,X,r,sigma,time,no_S_steps,no_t_steps)
     );
    println(" implicit FD American call price = ",
    	option_price_call_american_finite_diff_implicit(S,X,r,sigma,time,no_S_steps,no_t_steps));
    println(" black scholes put price = ",
    	option_price_put_black_scholes(S,X,r,sigma,time));
    println(" explicit Euro put price = ",
    	option_price_put_european_finite_diff_explicit(S,X,r,sigma,time,no_S_steps,no_t_steps));

    println(" implicit Euro put price = ",
    	option_price_put_european_finite_diff_implicit(S,X,r,sigma,time,no_S_steps,no_t_steps));
    println(" explicit American put price = ",
    	option_price_put_american_finite_diff_explicit(S,X,r,sigma,time,no_S_steps,no_t_steps));
    println(" implicit American put price = ",
    	option_price_put_american_finite_diff_implicit(S,X,r,sigma,time,no_S_steps,no_t_steps));
    println("DONE testing finite differences ");
}
