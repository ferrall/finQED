#import "finQED"

transforms(){
    println(" testing transformations ");
    decl r=0.1;
    decl t=1;
    decl d=0.9;
    println(" r= ", r, " t = ", t, " gives disc.fact ",
    	term_structure_discount_factor_from_yield(r,t));
    println(" d= ", d, " t = ", t, " gives yield ",
    	term_structure_yield_from_discount_factor(d,t));
    decl d1=0.8;
    println(" implied forward rate, d = ", d, " d1= ", d1,
		" t= ", t, " forward = ",
		term_structure_forward_rate_from_disc_facts(d,d1,t));
}
cir() {
    println(" cir dfact (t=1): ",
	term_structure_discount_factor_cir(1.0,0.1,0.1,0.1,0.1,0.1));
    }
vasicek() {
    println(" vasicek dfact (t=1): ",
    	term_structure_discount_factor_vasicek(1.0,0.05,-0.1,0.1,0.1));
    }

esti_cir() {
    println(" estimated cir discount_factor (t=1): ",
    	term_structure_discount_factor_estimated_cir(1.0,0.1,0.1,0.1,1.1));
}

nelson_siegel() {
    decl t=1.0;
    println(" ns= ",
		term_structure_yield_nelson_siegel(t,0.1,0.1,0.1,1.0));
}

bliss(){
    decl t=1.0;
    println(" bliss r(t=1) ",
    	term_structure_yield_bliss(t,0.1,0.1,0.1,1.0,1.0));
}

ts_spline(){
    decl b=0.1;
    decl c=0.1;
    decl d=-0.1;
    decl f = <0.01,0.01,-0.01>;
    decl knots = <2,7,12>;
    decl t=1.0;
    println("spline disc fact ",
    	term_structure_discount_factor_cubic_spline(t,b,c,d,f,knots));
}
interpolated() {
    decl times = <0.1,0.5,1,5,10>;
    decl yields = <0.1,0.2,0.3,0.4,0.5>;
    println(" testing interpolated ");
    println(" t=.1 ", term_structure_yield_linearly_interpolated(0.1,times,yields));
    println(" t=0.5 ", term_structure_yield_linearly_interpolated(0.5,times,yields));
    println(" t=1 ", term_structure_yield_linearly_interpolated(1,times,yields));
    println(" t=3 ", term_structure_yield_linearly_interpolated(3,times,yields));
    println(" t=5 ", term_structure_yield_linearly_interpolated(5,times,yields));
    println(" t=10 ", term_structure_yield_linearly_interpolated(10,times,yields));
}

termstruc_menu (){
	decl m = new Menu("Term Structure",FALSE);
	m->add(
    	{"Transforms",transforms},
    	{"Interpolated",interpolated},
    	{"Spline ",ts_spline},
    	{"Bliss",bliss},
    	{"Nelson-Siegel",nelson_siegel},
    	{"Vasicek",vasicek},
    	{"CIR ",cir},
    	{"Estimated CIR",esti_cir}
		);
	return m;
    }
