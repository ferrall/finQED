#import "finQED"

mv_calc_port()
{
    println("START testing Mean variance portfolios ");
	decl c = 4;
	decl x = ranu(c,c), e = ranu(c,1);
	decl V = x'x, r = meanc(e);

	x = mv_calculate_portfolio_given_mean_unconstrained(e, V, r);
	println("mv_calculate_portfolio_given_mean_unconstrained:", x);

	x = mv_calculate_portfolio_given_mean_no_short_sales(e, V, r);
	println("mv_calculate_portfolio_given_mean_no_short_sales:", x);
	
	x = mv_calculate_portfolio_given_mean_min_max_constraints(
	    e, V, zeros(c,1) + 0.1, ones(c,1) - 0.1, r);
	println("mv_calculate_portfolio_given_mean_min_max_constraints:", x);

    println("DONE testing Mean variance portfolios");
}
