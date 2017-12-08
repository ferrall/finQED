#import "finQED"

simulate_pricing()
{
	println("Given current underlying price = 100, Strike Price = 100, interest rate = 10%, volatility = 0.25, time to maturity = 1, number of simulations = 50000")  ;
	println("START testing Monte Carlo option pricing");
    decl S        = 100.0;
    decl X        = 100.0;
    decl r        = 0.1;
    decl sigma    = 0.25;
    decl time     = 1.0;
    decl no_sims  = 50000;
    println(" call ");
    println("   black scholes price = ",
		option_price_call_black_scholes(S,X,r,sigma,time));
	println("    simulated = ",
	   //option_price_euro_simulated(S,X,r,sigma,time,no_sims,0));	
	   option_price_call_european_simulated(S,X,r,sigma,time,no_sims));
    println(" put  ");
    println("   black scholes price = ",
		option_price_put_black_scholes(S,X,r,sigma,time));
    println("    simulated = ",
	  //option_price_euro_simulated(S,X,r,sigma,time,no_sims,1));
	   option_price_put_european_simulated(S,X,r,sigma,time,no_sims));
    println("DONE testing MC pricing ");
}
simulate_deltas()
{
    println("START testing estimating deltas of simulated prices");
    decl S        = 100.0;
    decl X        = 100.0;
    decl r        = 0.1;
    decl sigma    = 0.25;
    decl time     = 1.0;
    decl no_sims  = 50000;
    println(" call: bs= ",
    	option_price_delta_call_black_scholes(S,X,r,sigma,time),
        " sim= ",
        option_price_delta_call_european_simulated(S,X,r,sigma,time,no_sims));
    println(" put: bs= ",
    	option_price_delta_put_black_scholes(S,X,r,sigma,time),
      	" sim= ",
   		option_price_delta_put_european_simulated(S,X,r,sigma,time,no_sims));
  	println("DONE testing estimating deltas");
}

simulate_general()
{
	println("START testing general simulations ");
	decl S=100;
	decl X=100;
	decl r=0.05;
	decl time =1;
	decl sigma=0.2;
	decl no_sims = 10000;		
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
/*
simulate_change(){
   println("which parameter do you wanna change?\n","[0] strike price\n", "[1] volatility\n", "[2] time to maturity\n","[3] number of simulations\n" );
   decl num;
   scan("?: %g", &num);
   switch(num){
  case 0:
    println("The current underlying price is 100, what's your strike price?");
	decl s;
	scan("?: %g", &s);
	//......
    break;
  case 1:
    println("What's your volatility? ");
	decl v;
	scan("?: %g", &v);
	//...
    break;
  case 2:
    println("What's your time to maturity? ");
	decl t;
	scan("?: %g", &t);
	//....
    break;
  case 3:
    println("How many simulations do you want? ");
	decl simu;
	scan("?: %g", &simu);
	//....
    break;	
  default:
    println("fault");
    break;
   }
}
// may need change the whole structure.... need consideration
*/
simulate_menu (){
	decl m = new Menu("Simulation",FALSE);
	m->add(				 
  		{"Pricing ",simulate_pricing},
  		{"Deltas ",simulate_deltas},
  		{"General",simulate_general}
		//{"Change parameters",simulate_change}
		);
	return m;
    }
