/*
This function calculates the following variables used in the value functions to eliminate repetitive code.
*/
initial_calcs(r, sigma, R, Rinv, u, uu, d, p_up, p_down)
{
    R[0] = exp(r*(time/steps));						// interest rate for each step             
    Rinv[0] = 1.0/R[0];                      		// inverse of the interest rate
	u[0] = exp(sigma*sqrt(time/steps));  			// up movement
	uu[0] = u[0]*u[0];								// square of the up movement
	d[0] = 1.0/u[0];								// down movement
	p_up[0] = (R[0]-d[0])/(u[0]-d[0]);				// probability of a movement up
	p_down[0] = 1.0-p_up[0];						// probability of a movement down
}