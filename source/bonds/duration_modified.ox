#include "../../include/finQED.h"

bonds_duration_modified(cashflow_times,cashflow_amounts,bond_price,r)
{
     decl dur = bonds_duration(cashflow_times, cashflow_amounts, r);
     decl y = bonds_yield_to_maturity(cashflow_times,cashflow_amounts,
				       bond_price);
    return dur/y;
}
