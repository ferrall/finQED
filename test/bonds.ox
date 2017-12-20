<<<<<<< HEAD
#include <oxstd.oxh>
#include <Bond.ox>

main(){
	decl bond, price;         
    bond = new Bond();
 
	//example of 30 year governemnt bond paying 5% annual coupons

	//OPTION 1 USES SEPERATE SCALARS TO STORE COUPONS AND PRINCIPAL
	decl cpT=<>, cpA=<>, i=1;
	//create discounting period scalar <1, 2, 3, ..., 30>
	while (columns(cpT) < 30) {
		cpT ~= i;
		i+=1;
	}
	//create coupon scalar. number of coupons should match number of discounting periods, so 30 inputs <50, 50, 50, ..., 50>
	while (columns(cpA) < 30)
		cpA ~= 0.05*1000;

	//set object attributes
	bond.setCouponTimes(cpT);
	bond.setCouponAmounts(cpA);
	bond.setPrincipalTimes(<30>);
	bond.setPrincipalAmounts(<1000>);
	bond.setR(0.11);
	
	//price test option 1
	bond.priceBoth();
	println("price= ", bond.getPrice());
	   
	//OPTION 2 COMBINES METHOD 1 INTO ONE SINGLE CASHFLOW SCALAR
	//discounting period scalar is same between coupons and cashflows
	decl cfT = cpT;
	//cashflow scalar is same as coupon scalar but with principal added to the last period
	decl cfA=cpA;
	cfA[29] += 1000;

	//set object attributes
	bond.setCashflowTimes(cfT);
	bond.setCashflowAmounts(cfA);

	//price test option 2
	bond.price();
	println("price= ", bond.getPrice());

	//OPTION 3 SAME AS OPTION 2 (USES CASHFLOW SCALAR) WITH SLIGHTLY DIFFERENT CALCUATION METHOD
	//price test option 3
	bond.priceDiscrete();
	println("price= ", bond.getPrice());

	//calculate duration
	bond.duration();
	println("Duration= ", bond.getDur());

	//calculate convexity
	bond.convexity();
	println("Convexity= ", bond.getCvx());

	//calculate YTM 
	bond.setR(0); //set YTM to 0 and let the program solve for it
	bond.ytm();
	println("Yield To Maturity= ", bond.getYTM());

	//toString method
	print(bond.toString());
	
}//end main
=======
#import "finQED"

bonds()
{
    println("START testing bond algoritms ");
    decl coupon_times = <1,2>;
    decl coupon_amounts = <10,10>;
 	decl principal_times = <2>;
  	decl principal_amounts = <100>;
    decl r = 0.1;
    println(" price = ",
        bonds_price_both(coupon_times,coupon_amounts,
  	 		principal_times,principal_amounts,r));
    decl cashflow_times = <1,2>;
    decl cashflows = <10,110>;
    println(" price, cashflows case = ",
        bonds_price(cashflow_times, cashflows, r));
    println(" price, discrete compounding = ",
        bonds_price_discrete(cashflow_times, cashflows, r));
    println(" duration, simple ",
        bonds_duration(cashflow_times, cashflows,r));
    decl price = bonds_price(cashflow_times, cashflows, 0.11);
    println(" duration, Macaulay ",
        bonds_duration_macaulay(cashflow_times, cashflows,price));
    println(" duration, Modified ",
        bonds_duration_modified(cashflow_times, cashflows, price, r));
    decl y = bonds_yield_to_maturity(cashflow_times, cashflows, price);
    println(" yield = ", y);
    println(" convexity = ",
        bonds_convexity (cashflow_times, cashflows, y));

    println("DONE testing bonds ");
}

bonds_portfolio()
{
    println("START creating bonds portfolio with particular duration");
    decl coupon_times = <1,2>;
    decl coupon_amounts = <10,10>;
 	decl principal_times = <2>;
  	decl principal_amounts = <100>;
    decl r = 0.1;
	decl cashflow_times = <1,2>;
    decl cashflows = <10,110>;
	println(" duration of bond A ",
	    bonds_duration(cashflow_times, cashflows,r));
	decl coupon_timesb = <1,2,3,4,5>;
    decl coupon_amountsb = <10,10,10,10,10>;
 	decl principal_timesb = <5>;
  	decl principal_amountsb = <100>;
	decl cashflow_timesb = <1,2,3,4,5>;
    decl cashflowsb = <10,10,10,10,100>;
	println(" duration of bond B ",
	    bonds_duration(cashflow_timesb, cashflowsb,r));
	decl duration_of_portfolio=3;
	println(" portfolio_duration",
	    duration_of_portfolio);
	println(" calculate_portfolio_with_particular_durantion",
	    calculate_portfolio_with_particular_durantion(bonds_duration(cashflow_times, cashflows,r),bonds_duration(cashflow_timesb, cashflowsb,r),duration_of_portfolio));
 }

 bonds_menu(){
    return {
    {"Run All",0},
	{"bonds",bonds},
	{"Portfolio",bonds_portfolio}
    };
    }



	
>>>>>>> 256035f1eebf63c616e72f4b8b12f85dd0d26202
