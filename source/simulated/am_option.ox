

option_price_am_simulated(S, X, r, sigma, time, no_sims, no_steps, corp)
{
	decl R,SD;
	decl ss= no_steps;
	decl h,n;
	decl sum_payoffs=0;
	for (n=0; n<no_sims; n++){
	decl prices=zeros(1,ss);
	decl HV=zeros(1,ss),j,i;
	decl PX=zeros(1,ss);
	decl V=zeros(1,ss);
	parameters_calculation_step(r,sigma,time,no_steps,&R,&SD);
	prices = S * cumprod(exp(R + SD * rann(no_steps, 1)))';
	for(j=0;j<ss;j=j+1){
	PX[j]=X*exp(-r*time/ss*(ss-1-j));}
	for (j=0;j<ss;j=j+1){
	if( corp == "call")  {HV[j] = prices[j] - PX[j];  };
	if( corp == "put" )  {HV[j] = PX[j] - prices[j];  };
	}
	V[ss-1]=HV[ss-1];
	i=ss-1;
	do {
	V[i-1]=V[i]*exp(-r*time/no_steps);
	if (HV[i-1]>V[i-1]) {V[i-1]=HV[i-1];};
	i=i-1;
	} while (i>0);
	if (V[0]>0) {sum_payoffs=sum_payoffs+V[0];};
}
    return exp(-r*time)*sum_payoffs/no_sims;
}