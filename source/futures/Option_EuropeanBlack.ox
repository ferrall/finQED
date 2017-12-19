#include <oxstd.oxh>
//#include <Option.ox>

class Option_EuropeanBlack : Option {

	//constructor
	//default constructor, no params
	Option_EuropeanBlack();

	//declaring method headers
	callPrice();
	putPrice();
	toString();
	};

	//empty constructor
	Option_EuropeanBlack::Option_EuropeanBlack(){
		Option();
	}

	//class methods
	//call price
	Option_EuropeanBlack::callPrice() {
		decl std_sqr = std*std;
		decl time_sqrt = sqrt(t);
		decl d1 = (log(S/X) + 0.5 * std_sqr * t) / (std* time_sqrt);
		decl d2 = d1 - std * time_sqrt;
		decl price = exp(-r*t)*(S * probn(d1) - X * probn(d2));
		p = price;
		type = "Call Option";
	}
	
	//put price
	Option_EuropeanBlack::putPrice() {
		decl std_sqr = std*std;
		decl time_sqrt = sqrt(t);
		decl d1 = (log(S/X) + 0.5 * std_sqr * t) / (std * time_sqrt);
		decl d2 = d1 - std * time_sqrt;
		decl price = exp(-r*t)*(X * probn(-d2) - S * probn(-d1));
		p = price;
		type = "Put Option";
	}

	Option_EuropeanBlack::toString(){
 		return ("\n---FUTURES OPTION EUROPEAN BLACK---\nType: " + type + "\nPrice: " + sprint(p) + "\nPrice Of Stock: " + sprint(S) + "\nStrike Price: " + sprint(X) + "\nInterest Rate: " + sprint(r*100) + " %\nVolatility: " + sprint(std) + "\nTime To Maturity: " + sprint(t) + "year");
	}
	
	
