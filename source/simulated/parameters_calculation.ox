#include <oxstd.h> 


parameters_calculation1(r,sigma,time,R,SD){
    R[0] = (r - 0.5 * sqr(sigma)) * time;		 /** calculate R=(r-(1/2)*sigma^2)*t **/
    SD[0] = sigma * sqrt(time);				  /** calculate the standard deviation of a single simualtion SD=sigma*t^(1/2)  **/
}

/*parameters_calculation2(r1,sigma1,time1,no_steps1,R1,SD1){
    decl delta_t = time1 / no_steps1;
    R1[0] = (r1 - 0.5 * sqr(sigma1)) * delta_t;
    SD1[0] = sigma1 * sqrt(delta_t);
}
/* */
D:\Study\ECON354\finQED2\finQED\finQED\source/simulated/parameters_calculation.ox (9): 'parameters_calculation2' redefinition of argument count
D:\Study\ECON354\finQED2\finQED\finQED\source/simulated/parameters_calculation.ox (9): 'parameters_calculation2' redefinition of argument qualifier
*/

pvoption(r,time,no_sims,sum_payoffs){
 return exp(-r*time) * (sum_payoffs/no_sims);
 }