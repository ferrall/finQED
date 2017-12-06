// file: termstru_discfact_cubic_spline.cc
// author: Bernt A Oedegaard

#include <oxstd.h>

term_structure_discount_factor_cubic_spline(t,b1,c1,d1,f,knots)
{
    //  calculate the discount factor for the spline functional form.
    decl d = 1.0
	+ b1*t
	+ c1*(pow(t,2))
	+ d1*(pow(t,3));
    for (decl i=0;i<sizerc(knots);i++) {
      if (t >= knots[i]) { d += f[i] * (pow((t-knots[i]),3)); }
      else { break; }
    }
    return d;
}
