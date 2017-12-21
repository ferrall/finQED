#include <oxstd.h> 
/**
The first two functionns caiculated fundamental parameters R and SD for following calculations.
The third function is set to simplify the calculation progress.
**/

parameters_calculation1(r,sigma,time,R,SD){
    R[0] = (r - 0.5 * sqr(sigma)) * time;		 /** calculate R=(r-(1/2)*sigma^2)*t **/
    SD[0] = sigma * sqrt(time);				  /** calculate the standard deviation of a single simualtion SD=sigma*t^(1/2)  **/
}

parameters_calculation_step(r1,sigma1,time1,no_steps1,R1,SD1){
    decl delta_t = time1 / no_steps1;
    R1[0] = (r1 - 0.5 * sqr(sigma1)) * delta_t;
    SD1[0] = sigma1 * sqrt(delta_t);
}

pvoption(r,time,no_sims,sum_payoffs){
 return exp(-r*time) * (sum_payoffs/no_sims);
 }