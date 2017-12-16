
#include "alternative_formulas.ox"
#include "approximate.ox"
#include "binomial.ox"
#include "black_scholes.ox"
#include "bondopt.ox"
#include "bonds.ox"
#include "cash_flow.ox"
#include "currency.ox"
#include "exotics.ox"
#include "finite_diff.ox"
#include "futures.ox"
#include "mv_calc_port.ox"
#include "simulate.ox"
#include "term_structure.ox"

static const decl sep  = "\n---------------------------\n";
enum{prompt,call,submenu}

main_menu() {
    return {
                    {"Run All (excluding sub-options)", 0,     0},
                    {"alt-formula: merton",             merton,0},
                    {"quadratic approximation",         quadratic_approximation,0},
                    {"binomial (sub options)",          0,      binomial_menu},
                    {"Black-Scholes",                   0,      blackscholes_menu },
                    {"Bond Options (sub options)",      0,      bondopt_menu},
                    {"Bonds",                           0,      bonds_menu},
                    {"Cash Flow",                       cash_flow, 0 },
                    {"Currency",                        currency, 0 },
                    {"Exotics",                         exotics,  0 },
                    {"Finite Differences",              finite_differences, 0 },
                    {"Futures",                         futures, 0},
                    {"Mean-Variance Portfolio",         mv_calc_port, 0 },
                    {"Simulation (sub options)",        0, simulate_menu},
                    {"Term Structure (sub options)",    0, termstruc_menu}
            };
    }
enum{QUIT=-1,DOALL,CHOICE}
make_the_call(m,k) {
	fopen(m[k][prompt]+".txt","l");
	println("Output of ",m[k][prompt],sep);
	m[k][call]();
    println("... finished.\n");
    }
