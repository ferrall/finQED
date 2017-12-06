#import "finQED"

cash_flow() {
	println("START testing cash flow algoritms ");
  	decl times = <1,2>;
	decl amounts = <-100, 110.51709>;
	println(" testing PV ");
	println(" pv 0   ", cash_flow_pv(times,amounts, 0  ));
	println(" pv 0.1 ", cash_flow_pv(times,amounts, 0.1));
	println(" discrete compounding ");
	println(" pv 0   ", cash_flow_pv_discrete(times,amounts, 0  ));
	println(" pv 0.1 ", cash_flow_pv_discrete(times,amounts, 0.1));
	println(" testing irr ");
	amounts = <-100, 134.98588>;
	println(" irr (should be 0.30) ", cash_flow_irr(times,amounts));
	amounts = <100, -134.98588>;
	println(" irr (should be 0.30) ", cash_flow_irr(times,amounts));
	times ~= 3;
	amounts ~= 30;
	println(" irr (should be ?) ", cash_flow_irr(times,amounts));

	println(" testing, is irr unique? ");
	amounts = <-100, 110, 10>;
	println(" is irr unique (?) ", cash_flow_unique_irr(times,amounts));
	amounts = <-100, 110, -10>;
	println(" irr unique (?) ", cash_flow_unique_irr(times,amounts));
	amounts = <-10, 20.0001, -10>;
	println(" irr unique (?) ", cash_flow_unique_irr(times,amounts));
	println(" irr: ", cash_flow_irr(times,amounts));
	amounts = <-10, 19.999, -10>;
	println(" irr unique ? (blows) ", cash_flow_unique_irr(times,amounts));
	println(" irr: ", cash_flow_irr(times,amounts));
	amounts = <10, -21, 10>;
	println(" irr unique (?) ", cash_flow_unique_irr(times,amounts));
	println(" irr: ", cash_flow_irr(times,amounts));
	println("DONE testing cash flow algorithms");
}
