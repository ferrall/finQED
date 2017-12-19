 /**
 Attention: wrong!!!
 It is based on a wrong condition: we can know the price path at the first time.
 **/

option_price_am_simulated(S, X, r, sigma, time, no_sims, no_steps, corp)
{
	decl R,SD;
	decl ss= no_steps;
	decl n;
	decl sum_values=0;
	
	for (n=0; n<no_sims; n++){
	decl prices=zeros(1,ss);
	decl HV=zeros(1,ss);
	decl V=zeros(1,ss);
	decl i,j;
	parameters_calculation_step(r,sigma,time,no_steps,&R,&SD);
	prices = S * cumprod(exp(R + SD * rann(no_steps, 1)))';	 // simulate the prices of the underlying asset	at each step

	for (j=0;j<ss;j=j+1){
	if( corp == "call")  {HV[j] = prices[j] - X;  };
	if( corp == "put" )  {HV[j] = X - prices[j];  };
	}	// calculate the payoff at each step   
	V[ss-1]=HV[ss-1];	   // the option value at final date is the payoff at final date 
	i=ss-1;
	do {
	V[i-1]=V[i]*exp(-r*time/no_steps);
	if (HV[i-1]>V[i-1]) {V[i-1]=HV[i-1];};
	i=i-1;
	} while (i>0);	//	if the payoff at a certain step	is larger than its value of the same time, then change its value to its payoff

	if (V[0]>0) {sum_values=sum_values+V[0];};
}

	return sum_values/no_sims;
}