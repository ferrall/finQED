#import "finQED"

exotics()
{
    println("START testing analytical lookback ");
    decl S=100;
    decl Smin=S;
    decl q = 0;
    decl r = 0.06;
    decl sigma = 0.346;
    decl time = 1.0;
    println(" call ",
		exotics_lookback_european_call(S,Smin,r,q,sigma,time));
    println(" put ",
		exotics_lookback_european_put(S,Smin,r,q,sigma,time));
    println("DONE testing analytical lookback ");
}
