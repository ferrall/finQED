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
