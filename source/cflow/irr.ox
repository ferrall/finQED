#include "../../include/finQED.h"

static const decl CFLOW_ERROR = .NaN;

cash_flow_irr(cflow_times,cflow_amounts)
{
	// simple minded irr function.  Will find one root (if it exists.)
	// adapted from routine in Numerical Recipes in C.
    if (sizerc(cflow_times) != sizerc(cflow_amounts)) return CFLOW_ERROR;
    decl x1 = 0.0, x2 = 0.2;

	// create an initial bracket, with a root somewhere between bot,top
    decl f1 = cash_flow_pv(cflow_times, cflow_amounts,  x1);
    decl f2 = cash_flow_pv(cflow_times, cflow_amounts,  x2);
    decl i;
    for (i=0;i<FNR_MAXIT;i++)
	{
		if (f1*f2 < 0.0)
			break;
		if (fabs(f1)<fabs(f2))
		 	f1 = cash_flow_pv(cflow_times,cflow_amounts, x1+=1.6*(x1-x2));
		else
			f2 = cash_flow_pv(cflow_times,cflow_amounts, x2+=1.6*(x2-x1));
    }
    if (f2*f1>0.0)	return CFLOW_ERROR;
	
    decl f = cash_flow_pv(cflow_times,cflow_amounts, x1);
    decl rtb;
    decl dx=0;
    if (f<0.0)
	{	rtb = x1;	dx = x2-x1;
	}
    else
	{	rtb = x2;	dx = x1-x2;
	}
    for (decl i=0;i<FNR_MAXIT;i++)
	{
		dx *= 0.5;
		decl x_mid = rtb+dx;
		decl f_mid = cash_flow_pv(cflow_times,cflow_amounts, x_mid);
		if (f_mid<=0.0)
			rtb = x_mid;
		if ( (fabs(f_mid)<FNR_ACCURACY) || (fabs(dx)<FNR_ACCURACY) )
			return x_mid;
    }
    return CFLOW_ERROR;   // error.
}
