// file bondopt_call_rend_bart.cc
// author: Bernt A Oedegaard

#include <oxstd.h>

//  call on a zero coupon bond.
bond_option_price_call_zero_american_rendleman_bartter(X,
							       option_maturity,
							       S,
							       M,                   // term structure paramters
							       interest,            // current short interest rate
							       bond_maturity,        // time to maturity for underlying bond
							       maturity_payment,
							      no_steps)
{
    decl delta_t = bond_maturity/no_steps;

    decl u=exp(S*sqrt(delta_t));
    decl d=1/u;
    decl p_up = (exp(M*delta_t)-d)/(u-d);
    decl p_down = 1.0-p_up;

    decl r = zeros(1,no_steps+1);
    r[0]=interest*pow(d,no_steps);
    decl uu=u*u;
    decl i;
    for (i=1;i<=no_steps;++i){ r[i]=r[i-1]*uu;}
    decl P = zeros(1,no_steps+1);
    for (i=0;i<=no_steps;++i){ 	P[i] = maturity_payment;    }
    decl no_call_steps=int(no_steps*option_maturity/bond_maturity);
    for (decl curr_step=no_steps;curr_step>no_call_steps;--curr_step)
	{
		for (i=0;i<curr_step;i++)
		{
	    	r[i]  = r[i]*u;
	    	P[i] = exp(-r[i]*delta_t)*(p_down*P[i]+p_up*P[i+1]);
 		}
    }
    decl C = zeros(1,no_call_steps+1);
    for (i=0;i<=no_call_steps;++i){ C[i]=max(0.0,P[i]-X); }
    for (decl curr_step=no_call_steps;curr_step>=0;--curr_step)
	{
		for (i=0;i<curr_step;i++)
		{
		    r[i] = r[i]*u;
		    P[i] = exp(-r[i]*delta_t)*(p_down*P[i]+p_up*P[i+1]);
		    C[i] = max(P[i]-X, exp(-r[i]*delta_t)*(p_up*C[i+1]+p_down*C[i]));
	 	}
    }
    return C[0];
}
