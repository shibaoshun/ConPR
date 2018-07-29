function [Yhat, grad] = fun_lin_op(G,X,Y)
%function [Yhat, grad] = fun_lin_op(G,X,Y)
%
% Evaluates linear measurement operator G at X 
% and computes gradient of data-fit term 0.5*||Y-G(X,0)||_F^2 at X, where Y
% are the orig.measurements (i.e., Y=G(Xopt,0) with Xopt the sought sol.)
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This function is part of the DOLPHIn package (version 1.10)
% last modified: 02/06/2016, A. M. Tillmann
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
Yhat = G(X,0);

if( nargout == 2 )
    if( nargin < 3 )
        Y = 0;
    end
    grad = real(G(Yhat-Y,1));
end

