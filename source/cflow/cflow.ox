#include "cflow.h"

/**Determines the number of sign changes in a vector.
@returns integer Number of sign changes


**/
count_sign_changes(v) {
	decl c = rows(v);	
	if (c <= 1) return 0;
	decl leadneg = v[1 : ].<0;	//Vector excluding first entry
	decl curneg = v[: c-2].<0; //Vector excluding last entry
	return int(sumc( (leadneg .* (1-v2)) + ((1-leadneg).*curneg) ));
    }
	
/** Create a new investment stream to analyze.
@param inflow vector cash flows
@param times 0 [default] use ordinary time</br>
             vector: periods that correspond to inflow

If no times are specified times is set to correspond with the first cash flow being period 0
(the investment) and each subsequent cash flow being period 1,2,3...etc. If the user has inputted periods these are set to the
global variable cflow_times and a check is preformed to ensure the number of cash flows and periods are equal. The user does not have
to input times/periods in chronological order.

@example To inpute a cash flow that does not start generating income for 5 periods. All periods in-between will be given a cash flow of zero.

setflow(<-100,500>,<0,5>)
																															
**/
cflow::cflow(inflow, times = 0) {																							
     inputok = FALSE;
	 amounts = inflow;
     Nv = rows(amounts);
	 this.times = (isint(times))
	 	               ?  range(0,Nv-1)'; //Periods start at zero	
	                   :  times;
	 if (rows(cflow_times) != Nv)
	   oxrunerror("Cash flows and periods do not match.");
    inputok = TRUE;
    }

/**
To determine the IRR of the cash flow, it is first determined if there is a unique or multiple IRRs.

@returns Either the single or mutliple IRRs
**/
cflow::irr() {
 if(unique_irr()==1)
 return single_irr();
 else
 return multiple_roots();
}

/** Calculate the present value of cash flows using continuous discounting.

@param r Interest rate at which to discount future value of cash flows
@returns Present value of cash flows using continuous discounting
Continuous discounting always leads to a lower present value than discrete discounting.

PV = FV0 + FV1 / e^(r*1) + FV2 / e^(r*2) + ... + FVn / e^(r*n)

Where r is the interest rate and n is the number of periods.

**/
cflow::pv(r) {
	return double(sumc(amounts .* exp(-r*times)));
    }

/**
Finds a single IRR or root if it exists. An initial bracket is created discounting the cash flows at interest rates of x1 = 0% and x2 = 20%.
If f(x1) and f(x2) do not have opposite signs and the function is decreasing x1 is continually decreased or if the
function is increasing x2 is continually increased until f(x1) and f(x2) bracket zero.

Depending on which of x1 or x2 produce a negative present value that variable is equated to a new variable rtb.
A change dx (change in interest rate) which starts off as x2 - x1 if the function is increasing or x1 - x2 if the
function is decreasing is added to rtb to create x_mid (x_mid = dx + rtb). To find a root, the present value is first
calculated at the x_mid. If the present value is negative, rtb is adjusted to the x_mid. If the present value is positive
rtb does not change. The dx value is then halved and added again to rtb to create a new x_mid.

The present value is again calculated and the process repeated until the present value or the dx value is less than the accuracy of 1.0e-6.
If the maximum number of iterations is reached 500, returns error. 																												

@comments The present value of cash flows is calculated using continuous discounting.
**/
cflow::single_irr()	 {

	decl x1 = 0.0, x2 = 0.2; //Denotes inital guesses of interest rates (r values)
    decl f1 = pv(x1), f2 = pv(x2), i;

    i = 0;
    succ = FALSE;
    do
		if (f1*f2 < 0.0) {
            succ = TRUE;
			break;
            }
		if (fabs(f1)<fabs(f2))
		 	f1 = pv(x1+=1.6*(x1-x2));
		else
			f2 = pv(x2+=1.6*(x2-x1));
        ++i
        } while(++i<FNR_MAXIT);

    if (!succ) return CFLOW_ERROR;
	
    decl f = pv(x1), rtb, dx=0;
    if (f<0.0) //Define bottom bracket which equals either x1 or x2 depending on the slope of the function.
	   {	rtb = x1;	dx = x2-x1;
	   }
    else
	   {	rtb = x2;	dx = x1-x2;
	   }

    decl x_mid, f_mid;
    do {
		dx *= 0.5;
		x_mid = rtb+dx;
		f_mid = pv(x_mid);
		if (f_mid<=0.0)
			rtb = x_mid; //rtb only changes to x_mid only if the cash flows evaluated at x_mid are less negative.
        } while ( (fabs(f_mid)>FNR_ACCURACY) && (fabs(dx)>FNR_ACCURACY) )
	return x_mid;
    }

/**
Calculates multiple IRRs using Ox's polyroots function. A polynomial of the following form (Equation 1) is sent to polyroots where n
is the number of periods and a is the cash flow for that period.

1) a0 + a1*b + a2*b^2 + ... + an*b^n

As polyroots returns the inverse roots of the polynomial these roots are inverted to obtain both the real and imaginary
roots of the function. To find the IRRs of the cash flow, note that the present value using discrete discounted is calculated
using Equation 2.

2) a0 + a1*(1/(1+x)) + a2*(1/(1+x))^2 + ... + an*(1/(1+x))^n

Comparing Equation 1 and Equation 2 the IRRs can be found as follows:

b = 1/(1+x) so x = 1/b - 1

@returns Vector of real IRRs for the cash flow
@comments Multiple IRRs are found assuming present value is calculated using discrete compounding
**/
cflow::multiple_roots() {
	decl i,roots, orderofpoly = max(times), coeffs = zeros(1,orderofpoly+1);
	coeffs[][times] = amounts;
	polyroots(coeffs,&roots);
	roots = selectifc(roots,roots[1][].==0 );
	if(sizerc(roots) == 0) {
        println("There are no real roots.");
        return FALSE;
        }
	roots = roots[0][];
	return roots = roots - 1;
	}

/** Calculate the MIRR.

@param financerate The cost of borrowing (cost of capital) or interest expense in the event of negative cash flows
@param reinvestmentrate The compounding rate of return at which positive cash flow is reinvested

which assumes that positive cash flows are reinvested at the firm's reinvestment rate and
negative cash flows are discounted at the firms finance rate or cost of capital.

MIRR is calculated using the following formula:
MIRR = (sum of terminal cash flows/|investment + discounted negative cash flows|)^(1/n) - 1
where n is the number of periods.

**/
cflow::modified_irr(financerate, reinvestmentrate) {
  decl i,mirr,terminalvalue = 0,
        initialinvestment = amounts[0], neg_cflow = 0;
  for (i = 1;i < Nv; i++)	{
    if (amounts[i] > 0)
        terminalvalue = terminalvalue + amounts[i] * (1 + reinvestmentrate) ^ (times[Nv-1] - times[i]);
    else	
        neg_cflow += amounts[i]/(1+financerate)^times[i];
    }

  mirr =  (terminalvalue / fabs(neg_cflow + initialinvestment)) ^ (1/times[Nv-1]) - 1;
  return mirr;
  }	

/**
Find the period in which then initial investment break-even by summing up the cashflows until they are greater than zero.

@returns Break-even periods of the cash flow
**/
cflow::breakeven() {

	decl count = 1, cumulativecash = amounts[0];
	while (cumulativecash < 0 && count < sizec(amounts)) {
	   cumulativecash +=amounts[count];
	   count++;
	   }
		
	if (cumulativecash < 0)
	   return UNDEFINED;  //"Does not break even";
	else
	   return cflow_times[count-1];

}

/**
Print summary function for NPV, IRR(s), MIRR and the break even period corresponding to a set of cash flows. The finance rate and investment
rate can either be inputted or default values of 8% and 15% are used respectively.

@param finrate The cost of borrowing (cost of capital) or interest expense in the event of negative cash flows
@param investrate The compounding rate of return at which positive cash flow is reinvested
**/
cflow::print_summary(finrate,investrate) {
	
  println("The NPV of the project is: $","%5.2f",pv(finrate));
  println("The IRR(s) of the project is/are: ",multiple_roots());
  println("The MIRR of the project is (default finance rate 8%, reinvestment rate 15%): ","%5.2f",modified_irr(finrate,investrate),"%");
  println("The break even period is: ", breakeven());

}
	
/**
Test whether the cash flow has multiple IRRs. According to Descartes’ rule of signs there can be as many different IRRs as there
are changes in the sign of cash flows. This rule is first checked by calling Count Sign Changes. If there is no sign changes the
function returns false and if the function has one sign change returns true. If there is more than 1 sign change, Nordstrom’s criterion
is checked, which evaluates the number of sign changes in the cumulative cash flow.

@returns One if the cash flow has a unique IRR, zero otherwise.
**/
cflow::unique_irr() {

    decl sign_changes = count_sign_changes(amounts);
    if (sign_changes == 0) return FALSE;  //No irr
    if (sign_changes == 1) return TRUE;	  //Unique IRR

    sign_changes = count_sign_changes(cumulate(amounts)); //Check the aggregate cash flows, due to Nordstrom’s criterion
    return sign_changes <= 1; //If sign changes greater than 1 return 0 IRR not unique
    }
