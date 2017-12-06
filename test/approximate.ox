#import "finQED"

quadratic_approximation()
{
    println("START testing quadratic approximation ");
    decl X = 100;
    decl r = 0.08;
    decl sigma = 0.20;
    decl time = 0.25;
    decl b = -0.04;
    decl S=100;
    println(" call ",
		option_price_american_call_approximated_baw(S,X,r,b,sigma,time));
    println(" put ",
		option_price_american_put_approximated_baw(S,X,r,b,sigma,time));
    println("DONE test of approximation ");
}
tst_geske_johnson()
{
    println("TESTING geske johnson american put approximation ");
    println(" not done ");
    println("DONE TESTING geske johnson american put approximation ");
}
