// file termstru_discfact_estimated_cir.cc
// author Bernt Arne Oedegaard

#include <oxstd.h>

term_structure_discount_factor_estimated_cir(
    t,r,phi1,phi2,phi3){
  decl tmp = (phi2*(exp(phi1*t)-1.0)+phi1);
  decl A = (phi1*exp(phi2*t))/tmp;
  A = pow(A,phi3);
  decl B = (exp(phi1*t)-1.0)/tmp;
  decl dfact =  A*exp(-B*r);
  return dfact;
}
