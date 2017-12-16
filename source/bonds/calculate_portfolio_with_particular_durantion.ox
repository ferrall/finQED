#include <oxstd.h>

calculate_portfolio_with_particular_durantion(duration_bond_A,duration_bond_B,duration_of_portfolio){
 decl bonds_fraction=zeros(2,1)
 bonds_fraction[0]=(duration_of_portfolio-duration_bond_B)/(duration_bond_A-duration_bond_B); //
 bonds_fraction[1]=1- bonds_fraction[0];
 // bonds_fraction_A* duration_bond_A+bonds_fraction_B* duration_bond_B=duration_of_portfolio
 //	bonds_fraction_A+bonds_fraction_B=1
 return bonds_fraction;
 }