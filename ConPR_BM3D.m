function Iout=ConPR_BM3D(Y,phi,phit,x)
%% This algorithm exploits the ConPR framework
%%%% Only the iteartion times need to be specified.
%% If you use this code, please cite the following reference. 
%%%%%% BAOSHUN SHI, QIUSHENG LIAN, XIN HUANG, AND NI AN
%%%%%%¡°Constrained Phase Retrieval: when alternating projection meets regularization¡±, submitted to JOSA B.
%%%%%%%%%%%%%%last modified by shibaoshun 2018 Mar 9th
%%%%%%%%%% Input:  Y    measurements
%%%%%%%%%%        phi   linear sampling operator A 
%%%%%%%%%%        phit  linear sampling operator A^{H}
%%%%%%%%%%        x     random initial guess
%% Initial
    maxiteration=20;
    f = @(Yhat) sum(abs((Yhat(:)-Y(:))).^2); 
    gradf= @(x,Yhat) 4*real(phit(phi(x).*(Yhat-Y))); % define the gradient of the data fidelity function
    z=x;
    xold=x;
%%
 for i=1:1:maxiteration
%% update x (BM3D image denoising step)
    Nsig=mad(z);                        %evaluate the input noise standard deviation
    [~,x] = BM3D(z,z,Nsig*255, 'lc',0); %
%% update z (Projection step)
    z=proj_CPR(x,2,f,gradf,phi);        % J=2
%% stop while the residual is a small value 
    Residual= norm(x-xold)/norm(x);
    if  Residual<1e-4
    break;
    end
    xold = x;  
    i
 end
Iout=x;
