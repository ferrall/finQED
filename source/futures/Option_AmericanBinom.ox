#include <oxstd.oxh>
//#include <Option.ox>

//AmericanBinom class extends Option class
class Option_AmericanBinom : Option {

	decl n; //number of steps

	//constructor
	//default constructor, no params
	Option_AmericanBinom();
	

	//declaring method headers
	setN(numberSteps);
	getN();
	callPrice();
	putPrice();
	toString();
	};

	//empty constructor
	Option_AmericanBinom::Option_AmericanBinom(){
		Option();
	}

	//setters
	Option_AmericanBinom::setN(numberSteps) {
		n=numberSteps;
	}

	//getters
	Option_AmericanBinom::getN() {
		return n;
	}

	//class methods
	//call price
	Option_AmericanBinom::callPrice() {
		decl futures_prices = zeros(1,n+1);
		decl put_values = zeros(1,n+1);
		decl call_values = zeros(1,n+1);
		decl t_delta= t/n;
		decl Rinv = exp(-r*(t_delta));
		decl u = exp(std*sqrt(t_delta));
		decl d = 1.0/u;
		decl uu= u*u;
		decl pUp   = (1-d)/(u-d);
		decl pDown = 1.0 - pUp;
		//fill in price tree
		decl i, step;
		futures_prices[0] = S*pow(d, n);
		for (i=1; i<=n; ++i)
			futures_prices[i] = uu*futures_prices[i-1];
		for (i=0; i<=n; ++i)
			call_values[i] = max(0.0, (futures_prices[i]-X));
		for (step=n-1; step>=0; --step) {
	     	for (i=0; i<=step; ++i)   {
		 		futures_prices[i] = d*futures_prices[i+1];
		 		call_values[i] = (pDown*call_values[i]+pUp*call_values[i+1])*Rinv;
		 		call_values[i] = max(call_values[i], futures_prices[i]-X); // check for exercise
	      	}
	  	}
		p = call_values[0];
		type = "Call Option";
	}

	//put price
	Option_AmericanBinom::putPrice() {
		decl futures_prices = zeros(1,n+1);
		decl put_values = zeros(1,n+1);
		decl t_delta= t/n;
		decl Rinv = exp(-r*(t_delta));
		decl u = exp(std*sqrt(t_delta));
		decl d = 1.0/u;
		decl uu= u*u;
		decl uInv=1.0/u;
		decl pUp   = (1-d)/(u-d);
		decl pDown = 1.0 - pUp;
		//fill in price tree
		decl i, step;
		futures_prices[0] = S*pow(d, n);
		for (i=1; i<=n; ++i)
			futures_prices[i] = uu*futures_prices[i-1];
		for (i=0; i<=n; ++i)
			put_values[i] = max(0.0, (X-futures_prices[i]));
		for (step=n-1; step>=0; --step) {
	     	for (i=0; i<=step; ++i)   {
		 		futures_prices[i] = uInv*futures_prices[i+1];
		 		put_values[i] = (pDown*put_values[i]+pUp*put_values[i+1])*Rinv;
		 		put_values[i] = max(put_values[i], X-futures_prices[i]); // check for exercise
	      	}
	  	}
		p = put_values[0];
		type = "Put Option";
	}

	Option_AmericanBinom::toString(){
 		return ("\n---FUTURES OPTION AMERICAN BINOMIAL---\nType: " + type + "\nPrice: " + sprint(p) + "\nPrice Of Stock: " + sprint(S) + "\nStrike Price: " + sprint(X) + "\nInterest Rate: " + sprint(r*100) + " %\nVolatility: " + sprint(std) + "\nTime To Maturity: " + sprint(t) + "year");
	}
	