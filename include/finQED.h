
#include "oxstd.h"
#include "oxprob.h"
#import <solveqp>

const decl FNR_ACCURACY=1.0e-6;
const decl FNR_MAXIT   =   500;

#include "cflow.h"
#include "blackscholes.h"

//#include "bin.h"

#include "findiff.h"
#include "simulate.h"

/////////// approximated option prices ////////////////////////
option_price_american_call_approximated_baw(S, X, r, b, sigma, time);
option_price_american_put_approximated_baw(S, X, r, b, sigma, time);

#include "futures.h"
#include "currency.h"
#include "exotics.h"
	

/////////////////// alternative stochastic processes ////////////////
option_price_call_merton_jump_diffusion(S, X, r, sigma, time_to_maturity,lambda, kappa, delta);

#include "bonds.h"
#include "mv.h"
#include "termstru.h"


/// rendlemann barterr
bond_option_price_call_zero_american_rendleman_bartter(X, option_maturity, S, M, interest,bond_maturity, maturity_payment, no_steps);

/// Vasicek model, explicit call

bond_option_price_call_zero_vasicek(X, r,option_time_to_maturity,bond_time_to_maturity, a, b, sigma);
bond_option_price_put_zero_vasicek(X, r, option_time_to_maturity,bond_time_to_maturity, a, b, sigma);
