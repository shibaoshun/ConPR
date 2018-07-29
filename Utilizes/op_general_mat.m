function B = op_general_mat(G,X,t)
%function B = op_general_mat(G,X,t)
%
% Implements the linear operator G*X (and its adjoint G'*Z) 
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
if ~t % forward map:
   B = G*X;
else % adjoint
   B = G'*X;
end