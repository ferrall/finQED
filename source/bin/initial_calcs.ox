#include "oxstd.h"

initial_calcs(r, sigma, R, Rinv, u, uu, d, p_up, p_down)
{
    R[0] = exp(r*(time/steps));             
    Rinv[0] = 1.0/R[0];                      
	u[0] = exp(sigma*sqrt(time/steps));  
	uu[0] = u[0]*u[0];
	d[0] = 1.0/u[0];
	p_up[0] = (R[0]-d[0])/(u[0]-d[0]);
	p_down[0] = 1.0-p_up[0];
}
