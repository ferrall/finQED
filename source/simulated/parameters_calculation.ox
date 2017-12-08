#include <oxstd.h> 


parameters_calculation1(r,sigma,time){
    decl R = (r - 0.5 * sqr(sigma)) * time;		 /** calculate R=(r-(1/2)*sigma^2)*t **/
    decl SD = sigma * sqrt(time);				  /** calculate the standard deviation of a single simualtion SD=sigma*t^(1/2)  **/
}

parameters_calculation2(r,sigma,time,no_steps){
    decl delta_t = time / no_steps;
    decl R = (r - 0.5 * sqr(sigma)) * delta_t;
    decl SD = sigma * sqrt(delta_t);
}

pvoption(r,time,no_sims,sum_payoffs){
 return exp(-r*time) * (sum_payoffs/no_sims);
 }