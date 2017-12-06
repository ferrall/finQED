#import "finQED"

merton()
{
    decl S=100;
    decl X=100;
    decl r=0.05;
    decl sigma=0.2;
    decl time = 1;
    decl lambda = 0.01;
    decl kappa = 0.01;
    decl delta = 0.01;
    println(" Merton's jump diffusion,  Call price = ",
		option_price_call_merton_jump_diffusion(S,X,r,sigma,time,
			lambda,kappa,delta));
}
