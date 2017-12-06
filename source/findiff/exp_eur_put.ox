// file: findiff_exp_eur_put.cc
// author: Bernt A Oedegaard

#include <oxstd.h>

option_price_put_european_finite_diff_explicit(S,X,r,sigma,time,no_S_steps,no_t_steps) {
    decl sigma_sqr = sigma*sigma;

    decl m,M;           // need M = no_S_steps to be even:
    if (idiv(no_S_steps,2)==1) { M=no_S_steps+1; } else { M=no_S_steps; }
    decl delta_S = 2.0*S/M;
    decl S_values = zeros(1,M+1);
    for (m=0;m<=M;m++) { S_values[m] = m*delta_S; }
    decl N=no_t_steps;
    decl delta_t = time/N;

    decl a = zeros(1,M);
    decl b = zeros(1,M);
    decl c = zeros(1,M);
    decl r1=1.0/(1.0+r*delta_t);
    decl r2=delta_t/(1.0+r*delta_t);
    for (decl j=1;j<M;j++){
	a[j] = r2*0.5*j*(-r+sigma_sqr*j);
	b[j] = r1*(1.0-sigma_sqr*j*j*delta_t);
	c[j] = r2*0.5*j*(r+sigma_sqr*j);
    }
    decl f_next = zeros(1,M+1);
    for (m=0;m<=M;++m) { f_next[m]=max(0.0,X-S_values[m]); }
    decl f = zeros(1,M+1);
    for (decl t=N-1;t>=0;--t) {
	f[0]=X;
	for (m=1;m<M;++m) {
	    f[m]=a[m]*f_next[m-1]+b[m]*f_next[m]+c[m]*f_next[m+1];
	}
	f[M] = 0;
	for (m=0;m<=M;++m) { f_next[m] = f[m]; }
    }
    return f[M/2];
}
