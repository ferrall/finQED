#import "finQED"
#include "../source/simulated/parameters_calculation.ox"
#include "../source/simulated/euro_option.ox"
#include "../source/simulated/delta_calculation.ox"



simulate_parameters(S,X,r,sigma,time,no_sims)
{
    S[0]        = 100.0;
    X[0]        = 100.0;
    r[0]        = 0.1;
    sigma[0]    = 0.25;
    time[0]     = 1.0;
    no_sims[0]  = 50000;
}	 // easy to adjust initial parameters

simulate_pricing()
{
	println("Given current underlying price = 100, Strike Price = 100, interest rate = 10%, volatility = 0.25, time to maturity = 1, number of simulations = 50000")  ;
	println("START testing Monte Carlo option pricing");
	decl S1,X1,r1,sigma1,time1,no_sims1;
    simulate_parameters(&S1,&X1,&r1,&sigma1,&time1,&no_sims1);
	decl S        = S1;		 
    decl X        = X1;
    decl r        = r1;
    decl sigma    = sigma1;
    decl time     = time1;
    decl no_sims  = no_sims1;	  
    println("1)call ");
    println("   black scholes price = ",
		option_price_call_black_scholes(S,X,r,sigma,time));
	println("   simulated = ",
	   option_price_euro_simulated(S, X, r, sigma, time, no_sims, 0));	
	   //option_price_call_european_simulated(S,X,r,sigma,time,no_sims));
    println("2)put  ");
    println("   black scholes price = ",
		option_price_put_black_scholes(S,X,r,sigma,time));
    println("   simulated = ",
	  option_price_euro_simulated(S, X, r, sigma, time, no_sims, 1));
	   //option_price_put_european_simulated(S,X,r,sigma,time,no_sims));
    println("DONE testing MC pricing ");
}
simulate_deltas()
{
    println("START testing estimating deltas of simulated prices");
   	decl S2,X2,r2,sigma2,time2,no_sims2;
    simulate_parameters(&S2,&X2,&r2,&sigma2,&time2,&no_sims2);
	decl S        = S2;		 
    decl X        = X2;
    decl r        = r2;
    decl sigma    = sigma2;
    decl time     = time2;
    decl no_sims  = no_sims2;
    println(" call: bs= ",
    	option_price_delta_call_black_scholes(S,X,r,sigma,time),
        " sim= ",
        //option_price_delta_call_european_simulated(S,X,r,sigma,time,no_sims));
		option_price_delta_european_simulated(S,X,r,sigma,time,no_sims,0));
    println(" put: bs= ",
    	option_price_delta_put_black_scholes(S,X,r,sigma,time),
      	" sim= ",
   		//option_price_delta_put_european_simulated(S,X,r,sigma,time,no_sims));
		option_price_delta_european_simulated(S,X,r,sigma,time,no_sims,1));
  	println("DONE testing estimating deltas");
}

simulate_general()
{
	println("START testing general simulations ");
   	decl S3,X3,r3,sigma3,time3,no_sims3;
    simulate_parameters(&S3,&X3,&r3,&sigma3,&time3,&no_sims3);
	decl S        = S3;		 
    decl X        = X3;
    decl r        = r3;
    decl sigma    = sigma3;
    decl time     = time3;
    decl no_sims  = no_sims3;	
	println(" Black Scholes call price ",
	    option_price_call_black_scholes(S,X,r,sigma,time),
	    "   to be compared to ");
	println(" simulated Black Scholes call ",
	    derivative_price_european_simulated2(S,X,r,sigma,time,
			payoff_european_call,no_sims));
	println(" Black Scholes put price ",
	    option_price_put_black_scholes(S,X,r,sigma,time),
	    "   to be compared to ");
	println(" simulated Black Scholes put ",
	    derivative_price_european_simulated2(S,X,r,sigma,time,
			payoff_european_put,no_sims));
	
	no_sims = 500;
	decl no_steps = 300;
	
	println(" simulated arithmetic average ",
	    " S= ",  S, " r= ", r, " price=",
	    derivative_price_european_simulated1(S,r,sigma,time,
			payoff_arithmetic_average, no_steps,no_sims));
	
	println(" simulated geometric average ",
	    derivative_price_european_simulated1(S,r,sigma,time,
			payoff_geometric_average, no_steps,no_sims));
	
	println(" simulated geometric average, control variates ",
	    derivative_price_european_simulated_control_variate(S,r,sigma,time,
			payoff_geometric_average, no_steps,no_sims));
	println(" simulated max  ",
	    derivative_price_european_simulated1(S,r,sigma,time,
			payoff_max, no_steps,no_sims));
	println(" simulated min ",
	    derivative_price_european_simulated1(S,r,sigma,time,
			payoff_min,no_steps,no_sims));
	println("DONE testing general simulations ");
}

simulate_menu (){
	decl m = new Menu("Simulation",FALSE);
	m->add(				 
  		{"Pricing ",simulate_pricing},
  		{"Deltas ",simulate_deltas},
  		{"General",simulate_general}
		);
	return m;
    }
