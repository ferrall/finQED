bonds_price_both(coupon_times, coupon_amounts, principal_times,principal_amounts, r);
bonds_price(cashflow_times, cashflows, r);
bonds_price_discrete(cashflow_times, cashflows, r);
bonds_duration(cashflow_times, cashflows, r);
bonds_yield_to_maturity(cashflow_times, cashflow_amounts, bondprice);
bonds_duration_macaulay(cashflow_times, cashflows, bond_price);
bonds_duration_modified(cashflow_times, cashflow_amounts, bond_price, r);
bonds_convexity(cashflow_times, cashflow_amounts, y);
bond_option_price_call_zero_black_scholes(B, X, r, sigma, time);
bond_option_price_put_zero_black_scholes(B, X, r, sigma, time);
bond_option_price_call_coupon_bond_black_scholes(B, X, r, sigma, time,coupon_times, coupon_amounts);
bond_option_price_put_coupon_bond_black_scholes(B, X, r, sigma, time,coupon_times, coupon_amounts);
calculate_portfolio_with_particular_durantion(duration_bond_A,duration_bond_B,duration_of_portfolio);