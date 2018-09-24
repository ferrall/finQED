
enum{IMPLICIT,EXPLICITY,N??}
struct findiff {
    findiff();
    call(??);
    put(??);
    }

//findiff functions
option_price_call_finite_diff_explicit(S, X, r, sigma, time, no_S_steps, no_t_steps, type);
option_price_put_finite_diff_explicit(S, X, r, sigma, time, no_S_steps, no_t_steps, type);
option_price_put_finite_diff_implicit(S, X, r, sigma, time, no_S_steps, no_t_steps, type);
option_price_call_finite_diff_implicit(S, X, r, sigma, time, no_S_steps, no_t_steps, type);

//new function
setup_parameters(S, X, r, sigma, time, no_S_steps, no_t_steps, sigma_sqr, M, delta_S, N, delta_t);
