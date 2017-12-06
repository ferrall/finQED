// file termstru_discfact_vasicek.cc
// author: Bernt A Oedegaard

#include <oxstd.h>

term_structure_discount_factor_vasicek(time,r,a,b,sigma){
     decl A,B;
     decl sigma_sqr = sigma*sigma;
    decl aa = a*a;
    if (a==0.0){
	B = time;
	A = exp(sigma_sqr*pow(time,3))/6.0;
    }
    else {
	B = (1.0 - exp(-a*time))/a;
	A = exp( ((B-time)*(aa*b-0.5*sigma_sqr))/aa -((sigma_sqr*B*B)/(4*a)));
    }
    decl d = A*exp(-B*r);
    return d;
}
