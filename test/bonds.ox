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
	print("duration of bond A ", bonds_duration(cashflow_times, cashflows,r));
	decl coupon_timesb = <1,2,3,4,5>;
    decl coupon_amountsb = <10,10,10,10,10>;
 	decl principal_timesb = <5>;
  	decl principal_amountsb = <100>;
	decl cashflow_timesb = <1,2,3,4,5>;
    decl cashflowsb = <10,10,10,10,100>;
	print("duration of bond B ", bonds_duration(cashflow_timesb, cashflowsb,r));
	decl duration_of_portfolio=3;
	print("calculate_portfolio_with_particular_durantion",calculate_portfolio_with_particular_durantion(bonds_duration(cashflow_times, cashflows,r),bonds_duration(cashflow_timesb, cashflowsb,r),duration_of_portfolio));
 }

 bonds_menu(){
    return {
    {"Run All",0},
	{"bonds",bonds},
	{"Portfolio",bonds_portfolio}
    };
    }



	