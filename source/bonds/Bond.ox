#include <oxstd.oxh>

class Bond {
	//Attributes
	decl p;			//price
	decl r;   		//yield to maturity 
	decl cvx;   	//convexity 
	decl dur;     	//duration
	decl dur_mac; 	//duration macauly
	decl dur_mod; 	// duration modified
	decl cashflow_times; 
	decl cashflow_amounts;
	decl coupon_times;
	decl coupon_amounts;
	decl principal_amounts;
	decl principal_times;
	//Constructor
	Bond();
	//Mutators
	setFV(x);
	setR(x);
	setCR(x);
	setPrice(x);
	setCvx(x);
	setDur(x);
	setCoupon(x);
	setPrincipalTimes(x);
	setPrincipalAmounts(x);
	setCouponTimes(x);
	setCouponAmounts(x);
	setCashflowAmounts(x);
	setCashflowTimes(x);
	getPrice();
	getDur();
	getCvx();
	getYTM();
	getCashflowAmounts();
	getCashflowTimes();
	//Methods
	price();
	priceBoth();
	priceDiscrete();
	duration();
	convexity();
	ytm();
	toString();
	};

	//constructor
	Bond::Bond(){
	}

	//setters
	Bond::setR(interestRate) {
		r=interestRate;
	}

	Bond::setPrice(price) {
		p=price;
	}

	Bond::setCvx(convexity) {
		cvx=convexity;
	}

	Bond::setDur(duration) {
		dur=duration;
	}

	Bond::setCouponTimes(couponT) {
		coupon_times=couponT;
	}

	Bond::setCouponAmounts(couponA) {
		coupon_amounts=couponA;
	}
	
	Bond::setPrincipalTimes(princT) {
		principal_times=princT;
	}
	
	Bond::setPrincipalAmounts(princeA) {
		principal_amounts=princeA;
	}
	
	Bond::setCashflowAmounts(cf) {
		cashflow_amounts=cf;
	}
	
	Bond::setCashflowTimes(cft) {
		cashflow_times = cft;
	}
	
	//getters
	Bond::getPrice() {
		return p;
	}
	
	Bond::getCashflowTimes() {
		return cashflow_times;
	}
	
	Bond::getCashflowAmounts() {
		return cashflow_amounts;
	}
	
	Bond::getDur() {
		return dur;
	}
	
	Bond::getCvx() {
		return cvx;
	}

	Bond::getYTM() {
		return r;
	}
	
	// calculate bond price when term structure is flat, 
	Bond::price() {
	    p = (sumc(exp(-r*vec(cashflow_times)).*vec(cashflow_amounts)));
	}// end bondPrice
	
	// calculate bond price when term structure is flat, 
	// given both coupon and principals
	Bond::priceBoth() {
		decl price = sumc(exp(-r*vec(coupon_times)).*vec(coupon_amounts));
		price += sumc(exp(-r*vec(principal_times)).*vec(principal_amounts));
	    p = price;
	}// end priceBoth
	
	// calculate bond price when term structure is flat
	Bond::priceDiscrete() { 
		decl price = (sumc(vec(cashflow_amounts) ./ ((1+r).^vec(cashflow_times))));
		p = price;
	}// end bondPriceDiscrete
	
	// calculate the duration of a bond, simple case where the term 
	// structure is flat, interest rate r.
	Bond::duration() {
		decl t = vec(cashflow_amounts) .* exp(-r .* vec(cashflow_times));
		decl duration = (sumc(t .* vec(cashflow_times)) / sumc(t));
		dur = duration;
	}//end bondDuration
	
	// calculate the convexity of a bond, simple case where the term 
	// structure is flat, interest rate r.
	Bond::convexity(){
		decl t = vec(cashflow_times);
		decl convexity = (sumc(vec(cashflow_amounts) .* sqr(t) .* exp(-r*t)));
		cvx = convexity;
	}//end bondConvexity
	
	// calculate the convexity of a bond, simple case where the term 
	// structure is flat, interest rate r.
	Bond::ytm(){
	  	decl bot=0, top=1.0, FNR_ACCURACY = 0.0001, FNR_MAXIT = 1000;
		decl bondPrice = p;
		r = top;						
		price();					//update bond price could use another pricing calculation method if wanted
	  	while (p > bondPrice){
	  		top = top * 2;
			r = top;
			price(); 						
	  	}
		decl diff;
	  	r = 0.5 * (top+bot);
	  	for (decl i=0;i<FNR_MAXIT;i++) {
	    	diff = p - bondPrice;
		    if (fabs(diff)<FNR_ACCURACY)
				break;
	    	if (diff>0.0){
				bot=r;
			}
		    else{
				top=r;
			}
	    	r = 0.5 * (top+bot);
			price();	//update bond price
		}
	  	this.r = r;
	}//end bondYTM

	Bond::toString(){
		return ("\n---BOND---\nPrice: $" + sprint(p) + "\nInterest Rate: " + sprint(r*100) + "%\nDuration: " + sprint(dur) + " Months" + "\nConvexity: " + sprint(cvx));
	}