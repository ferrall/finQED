#import "finQED"

bondopt_black_scholes()
{
    println("START testing Black Scholes Bond options ");
    decl B=100;
    decl X=100;
    decl r=0.05;
    decl sigma=0.1;
    decl time=1;
    println(" call ",
		bond_option_price_call_zero_black_scholes( B,X,r,sigma,time),
    		" put ",
		bond_option_price_put_zero_black_scholes( B,X,r,sigma,time));
    decl coupon_times = <0.5>;
    decl coupons = <1>;
    println(" price adjusting for coupon ");
    println(" call ",
		bond_option_price_call_coupon_bond_black_scholes(
	    	B,X,r,sigma,time,coupon_times,coupons),
    		" put ",
		bond_option_price_put_coupon_bond_black_scholes(
	    	B,X,r,sigma,time,coupon_times,coupons));
    println("DONE testing bond options Black Scholes");
}

zero_coupon_call() {
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

bondopt_vasicek()
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

bondopt_menu(){
	decl m = new Menu("Bond Options",FALSE);
	m->add(
    	{"Black-Scholes",bondopt_black_scholes},
    	{"0-coupon Rendleman and Bartter",zero_coupon_call},
    	{"Vasicek",bondopt_vasicek}
  		);
	return m;
    }
