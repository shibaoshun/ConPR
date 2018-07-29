function B = op_cdp_2d(Z,M,t,S)
%function B = op_cdp_2d(Z,M,t)
%
% Implements the linear operator (and its adjoint) obtained by combining 
% 2D-FFT (normalized) with given diffraction masks M.
%
% Builds on code accompanying Candes, Li & Soltanolkotabi (2014),
%   "Phase Retrieval via Wirtinger Flow: Theory and Algorithms",
% (arXiv: 1407.1065)
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
[n1,n2,nM] = size(M); % Z must be n1 x n2 (if t=0) or n1 x n2 x nM (if t=1)
if isempty(S) %lqs add
    S=1;
end
if ~t % forward map:
   if size(M,3)>1
     B =myfft( conj(M) .* reshape(repmat(Z,[1 nM]), n1, n2, nM) );  %
   else
     B =S.*myfft( conj(M) .* reshape(repmat(Z,[1 nM]), n1, n2, nM) );  % Input is n1 x n2 image, output is n1 x n2 x nM array
   end
else % adjoint:
   if size(M,3)>1
      B =  mean( M .* myifft(Z), 3);  %lqs remove numel(Z) %numel(Z) * mean( M .* myifft(Z), 3); 
   else
      B =  mean( M .* myifft(Z.*S), 3);   %numel(Z) * mean( M .* myifft(Z.*S), 3);  % Input is n1 x n2 X nM array, output is n1 x n2 image
   end
end