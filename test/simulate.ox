#import "finQED"
#include "../source/simulated/parameters_calculation.ox"
#include "../source/simulated/euro_option.ox"
#include "../source/simulated/delta_calculation.ox"

decl S0=100.0,X0=100.0,r0=0.1,sigma0=0.25,time0=1,no_sims0=50000;  //global variables


simulate_parameters(S,X,r,sigma,time,no_sims)  // read current values
{
    S[0]        = S0;
    X[0]        = X0;
    r[0]        = r0;
    sigma[0]    = sigma0;
    time[0]     = time0;
    no_sims[0]  = no_sims0;
}	

simulate_pricing()
{
	println("START testing Monte Carlo option pricing");
	decl S,X,r,sigma,time,no_sims;
    simulate_parameters(&S,&X,&r,&sigma,&time,&no_sims);
	println("Given stock price:  ",S,"    strike price:  ",X,"      interest rate:  ",r*100,"%","     volatility:  ",sigma*100,"%","     time to maturity:  ",time," year       simulation times:  ",no_sims)  ;
    println("1)call ");
    println("   black scholes price = ",
		option_price_call_black_scholes(S,X,r,sigma,time));
	println("   simulated = ",
	   option_price_euro_simulated(S, X, r, sigma, time, no_sims, "call"));	
    println("2)put  ");
    println("   black scholes price = ",
		option_price_put_black_scholes(S,X,r,sigma,time));
    println("   simulated = ",
	  option_price_euro_simulated(S, X, r, sigma, time, no_sims, "put"));
    println("DONE testing MC pricing ");
}
simulate_deltas()
{
    println("START testing estimating deltas of simulated prices");
 	decl S,X,r,sigma,time,no_sims;
    simulate_parameters(&S,&X,&r,&sigma,&time,&no_sims);
	println("Given stock price:  ",S,"    strike price:  ",X,"      interest rate:  ",r*100,"%","     volatility:  ",sigma*100,"%","     time to maturity:  ",time," year       simulation times:  ",no_sims)   ;
    println(" call: bs= ",
    	option_price_delta_call_black_scholes(S,X,r,sigma,time),
        " sim= ",
		option_price_delta_european_simulated(S,X,r,sigma,time,no_sims,"call"));
    println(" put: bs= ",
    	option_price_delta_put_black_scholes(S,X,r,sigma,time),
      	" sim= ",
		option_price_delta_european_simulated(S,X,r,sigma,time,no_sims,"put"));
  	println("DONE testing estimating deltas");
}

simulate_general()
{
	println("START testing general simulations ");
	decl S,X,r,sigma,time,no_sims;
    simulate_parameters(&S,&X,&r,&sigma,&time,&no_sims);
    println("Given stock price:  ",S,"    strike price:  ",X,"      interest rate:  ",r*100,"%","     volatility:  ",sigma*100,"%","     time to maturity:  ",time," year       simulation times:  ",no_sims)   ;
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
	println("ATTENTION: change parameters  simulation times = 500, number of steps = 300");
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

simulate_change_parameters(){
  println("Do you wanna change some parameters and test again? yes please enter 1, no please enter 0");
  decl a;
  scan("Enter you choice: %g", &a);
  if (a==1){
  println("which parameter do you wanna change?\n","0 stock price     1 strike price     2 interest rate      3 volatility     4 time to maturity    5 number of simulations") ;
  decl x;
  scan("Enter you choice: %g", &x);
  switch(x){
        case 0:
            println("what's the current stock price?");
			scan("Enter: %g", &S0);
            break;
        case 1:
            println("what's the strike price?");
			scan("Enter: %g", &X0);
            break;
		case 2:
            println("what's the interest rate?(number<1,please)");
			scan("Enter: %g", &r0);
            break;
		case 3:
            println("what's the volatility?(number<1,please)");
			scan("Enter: %g", &sigma0);
            break;
		case 4:
            println("what's the left time to maturity?(1 means 1 year)");
			scan("Enter: %g", &time0);
            break;
		case 5:
            println("How many simulations do you wanna have?");
			scan("Enter: %g", &no_sims0);
            break;
        default:
            println("That's not a choice option, so sorry...");
            break;
        }
  print("Done changeing parameters, the current parameters is ....\n",
  "stock price:  ",S0,"    strike price:  ",X0,"      interest rate:  ",r0*100,"%","     volatility:  ",sigma0*100,"%","     time to maturity:  ",time0," year       simulation times:  ",no_sims0)   ;
  }
  else println("that's okay");
}

simulate_menu (){
	decl m = new Menu("Simulation",FALSE);
	m->add(				 
  		{"Pricing ",simulate_pricing},
  		{"Deltas ",simulate_deltas},
  		{"General",simulate_general},
		{"Change parameters",simulate_change_parameters}
		);
	return m;
    }
