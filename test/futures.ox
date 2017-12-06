#import "finQED"

futures()
{
  	println("START testing futures options etc ");
  	decl S=100;
  	decl F=100;
    decl X=100;
    decl r =0.1;
    decl sigma = 0.2;
    decl time = 1;
  	println(" futures price ", futures_price(S,r,time));
    println(" european call price = ",
		futures_option_price_call_european_black(F,X,r,sigma,time));
    println(" european put price = ",
		futures_option_price_put_european_black(F,X,r,sigma,time));
    decl nosteps = 100;
    println(" call price, binomial american = ",
    	futures_option_price_call_american_binomial(F,X,r,sigma,time,nosteps));
    println(" put price, binomial american = ",
    	futures_option_price_put_american_binomial(F,X,r,sigma,time,nosteps));
  	println("DONE testing futures ");
}
