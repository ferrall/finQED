#import "bin"

binomial_pricing()
{
    println("START testing Binomial Pricing");
    decl spot = 100.0;
    decl exercise = 100.0;
    decl r = 0.1;
    decl sigma = 0.25;
    decl time_to_maturity=1.0;
    decl steps = 100;
	decl dividend_times = <0.25,0.75>;
    decl dividend_yields = <0.03,0.03>;
    decl dividend_amounts = <2.5,2.5>;

	decl option = <0, 1>;	// if option == 0, return call value; if option == 1, return put value
	set_parameters(spot, exercise, r, sigma, time_to_maturity, steps, dividend_times, dividend_yields, dividend_amounts);
	
    println(" european ");
    println(" call: ", option_price_european_binomial(option[0]) );
	println(" put: ", option_price_european_binomial(option[1]) );
    println(" american ");
    println(" call: ", option_price_american_binomial(option[0]) );
    println(" put: ", option_price_american_binomial(option[1]) );
   

    println("Proportional dividends ");
    println(" american call, dividends=3%, 3%, price= ",
		option_price_american_proportional_dividends_binomial(option[0]
//	    	spot,exercise,r,sigma,time_to_maturity,steps,dividend_times, dividend_yields
			) );
    println(" american put, dividends=3%, 3%, price= ",
		option_price_american_proportional_dividends_binomial(option[1]
//	    	spot,exercise,r,sigma,time_to_maturity,steps,dividend_times, dividend_yields
));

    println("Discrete dividends: " );
    println(" american call, dividends 2.5 2.5, price= ",
		option_price_call_american_discrete_dividends_binomial(
//	    	spot,exercise,r,sigma,time_to_maturity,steps,	    	dividend_times, dividend_amounts
)
);
    println(" american put, dividends 2.5 2.5, price= ",
		option_price_put_american_discrete_dividends_binomial(
//	    	spot,exercise,r,sigma,time_to_maturity,steps,	    	dividend_times, dividend_amounts
));
    println("DONE testing binomial pricing ");
}
binomial_partials()
{
    println("START testing binomial partials ");
    decl S = 100.0;
    decl X = 100.0;
    decl r = 0.1;
    decl sigma = 0.25;
    decl time = 1.0;
    decl no_steps=100;
	set_parameters(S,X,r,sigma,time, no_steps,0,0,0);
    println(" american call delta = ",
		option_price_delta_american_binomial(0) );
    println(" american put delta = ",
		option_price_delta_american_binomial(1) );
    decl delta, gamma, theta, vega, rho;
    option_price_partials_american_call_binomial(&delta, &gamma, &theta, &vega, &rho);
    println("CALL price partials ");
    println(" Delta = ", delta);
    println(" gamma = ", gamma);
    println(" theta = ", theta);
    println(" vega  = ", vega);
    println(" rho   = ", rho);
    option_price_partials_american_put_binomial(&delta, &gamma, &theta, &vega, &rho);
    println("PUT price partials");
    println(" Delta = ", delta);
    println(" gamma = ", gamma);
    println(" theta = ", theta);
    println(" vega  = ", vega);
    println(" rho   = ", rho);
    println("DONE testing binomial partials ");
}

binomial_menu(){
	decl m = new Menu("binomial",FALSE);
	m->add(
		{"Pricing",binomial_pricing},
		{"Partials",binomial_partials}
    	);
	return m;
    }
