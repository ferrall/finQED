#import "finQED"

currency() {
    println("START testing option price ");
    println(" european ");
    println("  call = ",
		currency_option_price_call_european(1.0,1.0,0.11,0.08,0.4,1.0));
    println("  put = ",
		currency_option_price_put_european(1.0,1.0,0.11,0.08,0.4,1.0));
    println(" binomial american ");
    println("  call = ",
		currency_option_price_call_american_binomial(1.0,1.0,0.11,0.08,0.4,1.0,100));
    println("  put = ",
		currency_option_price_put_american_binomial(1.0,1.0,0.11,0.08,0.4,1.0,100));
    println("DONE testing option price ");
}
