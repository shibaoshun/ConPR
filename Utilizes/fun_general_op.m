function [Yhat, grad] = fun_general_op(F,X,Y,gamma) % gamma is the strength of possion noise
%function [Yhat, grad] = fun_general_op(F,X,Y)
%
% Evaluates linear measurement operator F at X and computes
% gradient of data-fit term 0.5*||Y-abs(F(X,0)).^2||_F^2 at X, where Y
% are the orig.measurements (i.e., Y=F(Xopt,0) with Xopt the sought sol.)
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This function is part of the DOLPHIn package (version 1.10)
% last modified: 06/06/2016, A. M. Tillmann
%
% You may freely use and modify the code for academic purposes, though we
% would appreciate if you could let us know (particularly should you find 
% a bug); if you use DOLPHIn for your own work, please cite the paper
%
%    "DOLPHIn -- Dictionary Learning for Phase Retrieval",
%    Andreas M. Tillmann, Yonina C. Eldar and Julien Mairal, 2016.
%    http://arxiv.org/abs/1602.02263
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tmp = F(X,0);% A(x)
Yhat = abs(tmp).^2;
if ~exist('gamma','var')
    gamma=0;
end
if( nargout == 2 )% calc grad
   if gamma==0 %gaussian measured noise
     Z = tmp .* (Yhat- Y);
     grad =F(Z,1);%real(F(Z,1));% modified by lqs for complex image
   else %possion measured noise, lqs
     %Yhat(Yhat==0)=eps;
     %gamma=1;
     %Z=(Yhat-Y).*tmp./Yhat;
     Z=(Yhat-Y)./(conj(tmp)+eps);
     grad=2*F(Z,1); %At(x)      
   end
end

