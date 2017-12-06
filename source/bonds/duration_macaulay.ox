#include "../../include/finQED.h"

bonds_duration_macaulay(cashflow_times,cashflows,bond_price)
{
    decl y = bonds_yield_to_maturity(cashflow_times, cashflows, bond_price);
    return bonds_duration(cashflow_times, cashflows, y); // use YTM in duration
}
