#import "finQED"

black_scholes_price() {
	println("START testing Black Scholes price ");
	decl spot = 58.507;
	decl exercise = 60;
	decl r = 0.06;
	decl sigma = 0.35;
	decl time_to_maturity=0.25;
	println(" call price = ",
		option_price_call_black_scholes(spot,exercise,r,sigma, time_to_maturity));
	println(" put price = ",
		option_price_put_black_scholes(spot,exercise,r,sigma, time_to_maturity));
	println(" call delta= ",
		option_price_delta_call_black_scholes(spot,exercise,r,sigma, time_to_maturity));
	println(" put delta = ",
		option_price_delta_put_black_scholes(spot,exercise,r,sigma, time_to_maturity));

	decl delta, gamma, theta, vega, rho;
	option_price_partials_call_black_scholes(
	   	spot, exercise, r, sigma, time_to_maturity,
		&delta, &gamma, &theta, &vega, &rho);
	println(" call partial derivatives:\n", " delta=", delta, " gamma=", gamma,
		" theta=", theta, " vega=", vega, " rho=", rho);

	option_price_partials_put_black_scholes(
	   	spot, exercise, r, sigma, time_to_maturity,
		&delta, &gamma, &theta, &vega, &rho);
	println(" put partial derivatives:\n",	" delta=", delta, " gamma=", gamma,
		" theta=", theta, " vega=", vega, " rho=", rho);

	println(" call implied volatility (bisection) = ",
		option_price_implied_volatility_call_black_scholes_bisections(
			spot, exercise, r, time_to_maturity, 3.80745));
	println(" call implied volatility (Newton-Raphson) = ",
		option_price_implied_volatility_call_black_scholes_newton(
			spot, exercise, r, time_to_maturity, 3.80745));
	println("DONE testing Black Scholes price ");
}

black_scholes_price_payout()
{
	println("START testing Black Scholes price with payouts ");
	decl spot = 100.0;
	decl exercise = 100.0;
	decl r = 0.1;
	decl sigma = 0.25;
	decl time_to_maturity=1.0;
	decl b=0.05;
	println("continous payout 5% ");
	println(" call price: ",
		option_price_european_call_payout(spot,exercise,r,b,sigma, time_to_maturity));
	println(" put price: ",
		option_price_european_put_payout(spot,exercise,r,b,sigma, time_to_maturity));

	println("discrete dividends, european options");
	decl dividend_times = 0.5;
	decl dividend_amounts = 2.0;
	println(" call price: ",
		option_price_european_call_dividends(spot,exercise,r,sigma,
			time_to_maturity, dividend_times, dividend_amounts));
	println(" put price: ",
		option_price_european_put_dividends(spot,exercise,r,sigma,
			time_to_maturity, dividend_times, dividend_amounts));

	println("American call, one dividend, exact solution ");
	decl D=2;
	decl time_to_dividend=0.5;
	println(" call price (D=2): ",
		option_price_american_call_dividend(spot,exercise,r,sigma,
			time_to_maturity, D, time_to_dividend));
	D=10;
	println(" call price (D=10): ",
		option_price_american_call_dividend(spot,exercise,r,sigma,
			time_to_maturity, D, time_to_dividend));
	println("DONE testing Black Scholes price with payouts ");
}

blackscholes_menu(){
	decl m = new Menu("Black-Scholes",FALSE);
	m->add(
    	{"Price",black_scholes_price},
		{"Payout",black_scholes_price_payout}
		);
	return m;
    }
