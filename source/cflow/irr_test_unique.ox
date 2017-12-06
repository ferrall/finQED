// file cflow_irr_test_unique.cc
// author Bernt A Oedegaard

#include <oxstd.h>

static count_sign_changes(v)
{
	decl c = sizerc(v);
	if (c <= 1)
		return 0;
	decl v1 = vec(v)[1 : ];
	decl v2 = vec(v)[: c-2];
	return int(sumc(v1 .< 0 .&& v2 .>= 0 .|| v1 .>= 0 .&& v2 .< 0));
}

cash_flow_unique_irr(cflow_times,cflow_amounts)
{
    // check whether the cash flow has a unique irr.
	// first check Descartes rule
    decl sign_changes = count_sign_changes(cflow_amounts);
    if (sign_changes == 0) return FALSE;  // can not find any irr
    if (sign_changes == 1) return TRUE;

    // check the aggregate cash flows, due to Norstrom
    sign_changes = count_sign_changes(cumulate(vec(cflow_amounts)));
    return sign_changes <= 1;
}
