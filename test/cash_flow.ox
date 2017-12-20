#import "finQED"

cash_flow() {

	println("START testing cash flow algoritms ");
	setflow(<-100, 110, 170, 220>);
	println(" testing PV ");
	println(" pv 0   ", cash_flow_pv(0));
	println(" pv 0.1 ", cash_flow_pv(0.1));
	println(" pv 0   ", cash_flow_pv_discrete( 0 ));
	println(" pv 0.1 ", cash_flow_pv_discrete( 0.1), "\n ");

    println(" testing, is irr unique? ");
	setflow(<-100, 110, 10>);
	println(" irr unique (?) ", cash_flow_unique_irr());	
	setflow(<-100, 110, -10>);
	println(" irr unique (?) ", cash_flow_unique_irr());
	setflow(<10, -21, 10>);
	println(" irr unique (?) ", cash_flow_unique_irr());
	println(" irr: ", cash_flow_irr());
	
	setflow(<-10, 20.0001, -10>); 
    println(" irr unique (?) ", cash_flow_unique_irr());
	println(" irr: ", cash_flow_irr());	 
	setflow(<-10, 19.999, -10>); //Cash flow changes sign twice, cumulative cash flow changes sign twice 
	println(" irr unique ? (blows) ", cash_flow_unique_irr());
	println(" irr: ", cash_flow_irr(), "\n ");
	
	println(" testing irr ");
	setflow(<-100, 134.98588>);
	println(" irr (should be 0.30) ", cash_flow_irr());
	setflow(<100, -134.98588>);
	println(" irr (should be 0.30) ", cash_flow_irr());
	setflow(<100, -134.98588,30>);
	println(" irr (should be ?) ", cash_flow_irr(), "\n ");	

	println(" test multiple irr ");
	setflow(<-12000,10000,-6000>,<0,2,4>);   //Test multiple roots - there are no real roots 
    println(" irr: ", multiple_roots(), "\n "); 	//ANS: No real roots  	
	setflow(<-100,200,-300,400,150>);	//ANS: -1.29, 0.81 
    println(" irr: ", multiple_roots(), "\n ");	
	
	println(" test mirr ");
	setflow(<-12000,10000,-6000,4000,2000>); 
    println(" mirr: ", modified_irr(.08,.15)); //ANS: 6.2%   
	setflow(<-10,-10,20,40>,<0,2,4,5>); //Test MIRR	with skipped periods (because zero cash flow)	
    println(" mirr: ",modified_irr(.08,.15), "\n "); //ANS: 27.67%

	println(" test breakeven ");
	setflow(<-12000,10000,-6000,-4000,2000>);	
    println(" breakeven period: ",breakeven()); //Does not break even 
	setflow(<-12000,10000,6000,4000,2000>);	
    println(" breakeven period: ", breakeven(), "\n ");	//ANS: 2 

	setflow(<-120,100,-600,400,300>);
	print_summary(.03,.05); 		

    println("DONE testing cash flow algorithms");	

}
