// file: findiff_imp_am_call.cc
// author: Bernt A Oedegaard

#include <oxstd.h>

option_price_call_american_finite_diff_implicit(S,X,r,sigma,time,no_S_steps,no_t_steps) {
     decl sigma_sqr = sigma*sigma;
    decl m,M;
    if (imod(no_S_steps,2)==1) { M=no_S_steps+1; } else { M=no_S_steps; } // need no_S_steps to be even:
    decl delta_S = 2.0*S/M;
    decl S_values = zeros(1,M+1);
    for (m=0;m<=M;m++) { S_values[m] = m*delta_S; }
    decl N=no_t_steps;
    decl delta_t = time/N;

    decl A = unit(M+1);	// currently not using that A is a band matrix
    for (decl j=1;j<M;++j) {
	A[j][j-1] = 0.5*j*delta_t*(r-sigma_sqr*j);    // a[j]
	A[j][j]   = 1.0 + delta_t*(r+sigma_sqr*j*j);  // b[j];
	A[j][j+1] = 0.5*j*delta_t*(-r-sigma_sqr*j);   // c[j];
    }
	decl Ainv = invert(A);
    decl B = zeros(M+1,1);
    for (m=0;m<=M;++m){ B[m] = max(0.0,S_values[m]-X); }
    decl F=Ainv*B;
    for (decl t=N-1;t>0;--t) {
	B = F;
	F = Ainv*B;
	for (m=1;m<M;++m) { 	// now check for exercise
	    F[m] = max(F[m], S_values[m]-X);
	}
    }
    return F[M/2];
}
