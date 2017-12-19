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