#include "../../include/finQED.h"

/*
solve the quadratic program to minimize variance given constraints
all weights are in [0,1]
the weights sum to one
expected return equals r
*/
mv_calculate_portfolio_given_mean_min_max_constraints(e,V,min_weights, max_weights, r)
{
	 decl c = sizer(e),
     w = zeros(c, 1),
    // check whether it is feasible to find optimum. Only if r is between
    // min and max in e;
	 i_min = mincindex(e),
	 i_max = maxcindex(e),
	 r_min = e[i_min],
	 r_max = e[i_max];

	if ( (r>r_max) || (r<r_min) )
	{
	    println("Error: can not perform optimization");
	    return w;	   // returning zeros as weight
	}
	decl x = zeros(1, c);
	decl x_min = min_weights;
	decl x_max = max_weights;
    // now generate feasible portfolio by combining r_max and r_min;
    decl lambda = (r-r_max)/(r_min-r_max);
    x[i_min] = lambda;
    x[i_max] = 1 - lambda;

	decl iret;
	[iret, x] = SolveQP(V, zeros(c,1), <>, <>,
		e' | ones(1, c), r | 1, x_min, x_max);
	if (iret != 0)
		x = <>;
	
//	decl min_var  = CFSQP_optimize_with_constraints_and_bounds (
//        x, MV_CONSTRAINED_no_assets, MV_CONSTRAINED_objective,
//        0,0,0,2,                         // 2 linear equality constraints
//        MV_CONSTRAINED_constraints,
//        x_min, x_max);
    return x;
}

    // solve the quadratic program to minimize variance given constraints
    // all weights are in [0,1], the weights sum to one
    // expected return equals r
mv_calculate_portfolio_given_mean_no_short_sales(e,V,r) {
	return mv_calculate_portfolio_given_mean_min_max_constraints(e, V, zeros(e), ones(e), r);
}
