#include <oxstd.h>

set_parameters(inS, inX, inr, insigma, intime, insteps, individend_times, individend_yields, individend_amounts)

{
	decl S = inS;
	decl X = inX;
	decl r = inr;
	decl sigma = insigma;
	decl time = intime;
	decl steps = insteps;
	decl dividend_times = individend_times;
	decl dividend_yields = individend_yields;
	decl dividend_amounts = individend_amounts;

	return S, X, r, sigma, time, steps, dividend_times, dividend_yields, dividend_amounts;
	}

