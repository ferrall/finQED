// file termstru_discfact_cir.cc
// author: Bernt A Oedegaard
#include <oxstd.h>

     // this is the original CIR formulation of their term structure.
term_structure_discount_factor_cir(t,r,kappa,lambda,theta,sigma)
{
    decl sigma_sqr=pow(sigma,2);
    decl gamma = sqrt(pow((kappa+lambda),2)+2.0*sigma_sqr);
    decl denum = (gamma+kappa+lambda)*(exp(gamma*t)-1)+2*gamma;
    decl p=2*kappa*theta/sigma_sqr;
    decl enum1= 2*gamma*exp(0.5*(kappa+lambda+gamma)*t);
    decl A = pow((enum1/denum),p);
    decl B = (2*(exp(gamma*t)-1))/denum;
    decl dfact=A*exp(-B*r);
    return dfact;
}
