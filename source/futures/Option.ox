#include <oxstd.oxh>

//base class for all option pricing methods 
class Option {

	decl p;	//price of call option
	decl S; //price of stock
	decl X;	//strike price
	decl r;	//interest rate
	decl std;	//volatility
	decl t;	//time to maturity
	decl type;
	
	//declaring method headers
	setPrice(price);
	setStockPrice(stockPrice);
	setStrike(strikePrice);
	setR(interestRate);
	setSTD(volatility);
	setTime(timeToMaturity);

	getPrice();
	getStockPrice();
	getStrike();
	getR();
	getSTD();
	getTime();
	Option();
	
	};

  
	//setters
	Option::Option(){
	}
	Option::setPrice(price) {
		p=price;
	}

	Option::setStockPrice(stockPrice) {
		S=stockPrice;
	}

	Option::setR(interestRate) {
		r=interestRate;
	}

	Option::setStrike(strikePrice) {
		X=strikePrice;
	}

	Option::setSTD(volatility) {
		std=volatility;
	}

	Option::setTime(timeToMaturity) {
		t=timeToMaturity;
	}

	//getters
	Option::getPrice() {
		return p;
	}

	Option::getStockPrice() {
		return S;
	}
	
	Option::getR() {
		return r;
	}

	Option::getStrike() {
		return X;
	}

	Option::getSTD() {
		return std;
	}

	Option::getTime() {
		return t;
	}


	