#include "all.ox"

main() {
	decl m = new Menu("test");
	m->add(
			{"alt-formula: merton",             merton},
			{"quadratic approximation",         quadratic_approximation},
			{"binomial (sub options)",          binomial_menu()},
			{"Black-Scholes",                   blackscholes_menu() },
			{"Bond Options (sub options)",      bondopt_menu()},
			{"Bonds",                           bonds},
			{"Cash Flow",                       cash_flow},
			{"Currency",                        currency},
			{"Exotics",                         exotics},
			{"Finite Differences",              finite_differences},
			{"Futures",                         futures},
			{"Mean-Variance Portfolio",         mv_calc_port},
			{"Simulation (sub options)",        simulate_menu()},
			{"Term Structure (sub options)",    termstruc_menu()}
            );
	m->Run();
    }
	