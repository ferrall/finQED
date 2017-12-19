#include <oxstd.oxh>
#include <Option.ox>
#include <Option_EuropeanBlack.ox>
#include <Option_AmericanBinom.ox>
main();
main(){
	decl callOpt1, putOpt1, callOpt2, putOpt2;
	
    callOpt1 = new Option_EuropeanBlack();
	putOpt1 = new Option_EuropeanBlack();
	callOpt2 = new Option_AmericanBinom();
	putOpt2 = new Option_AmericanBinom();

	callOpt1.setStockPrice(100);
	callOpt1.setStrike(100);
	callOpt1.setR(0.1);
	callOpt1.setSTD(0.2);
	callOpt1.setTime(1);

	putOpt1.setStockPrice(100);
	putOpt1.setStrike(100);
	putOpt1.setR(0.1);
	putOpt1.setSTD(0.2);
	putOpt1.setTime(1);

	callOpt2.setStockPrice(100);
	callOpt2.setStrike(100);
	callOpt2.setR(0.1);
	callOpt2.setSTD(0.2);
	callOpt2.setTime(1);
	callOpt2.setN(100);

	putOpt2.setStockPrice(100);
	putOpt2.setStrike(100);
	putOpt2.setR(0.1);
	putOpt2.setSTD(0.2);
	putOpt2.setTime(1);
	putOpt2.setN(100);

	callOpt1.callPrice();
	putOpt1.putPrice();
	callOpt2.callPrice();
	putOpt2.putPrice();
	
	println("European Black Scholes Call Price = ", callOpt1.getPrice());
	println("European Black Scholes Put Price = ", putOpt1.getPrice());
	println("American Binomial Call Price = ", callOpt2.getPrice());
	println("American Binomial Put Price = ", putOpt2.getPrice());

	print(callOpt1.toString());
	print(putOpt1.toString());
	print(callOpt2.toString());
	print(putOpt1.toString());
	
}