
initial_calcs(r, sigma, R, Rinv, u, uu, d, p_up, p_down)
{
    decl R = exp(inr*(intime/insteps));          
    decl Rinv = 1.0/R;                  
    decl u = exp(insigma*sqrt(intime/insteps));    
    decl uu = u*u;
    decl d = 1.0/u;
    decl p_up = (R-d)/(u-d);
    decl p_down = 1.0-p_up;

	return uu, d, p_up, p_down, Rinv;
}