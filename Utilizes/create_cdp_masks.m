function M = create_cdp_masks(n1,n2,nM,type)
%function M = create_cdp_masks(n1,n2,nM,type)
%
% Creates nM coded diffraction masks of size n1 x n2 and specified type
% (can be 'ternary' or 'complex', or (experimental) 'binary').
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

masktypes = {'binary';'ternary';'quatary';'complex'};
% 'binary' is experimental; didn't check admissability...

if nargin < 4
   type = masktypes{1};
end

if strcmpi(type,masktypes{1})
   M = ones(n1,n2,nM);  % Storage for nM masks, each of dim n1 x n2

   % Sample magnitudes and make masks 
   temp = rand(n1,n2,nM);
   M = M .* ( (temp <= 0.5) ); % gives 0 entries with prob. 1/2
   M(M==0)=-1;% add by lqs 2017.2.5
elseif strcmpi(type,masktypes{2})
   M = ones(n1,n2,nM);  % Storage for nM masks, each of dim n1 x n2

   % Sample magnitudes and make masks 
   temp = rand(n1,n2,nM);
   M = M .* ( (temp <= 0.25) - (temp > 0.75) ); % gives 0 entries with prob. 1/2
elseif strcmpi(type,masktypes{3})
   M = zeros(n1,n2,nM);  % Storage for nM masks, each of dim n1 x n2

   % Sample phases: each symbol in alphabet {1, -1, i , -i} has equal prob. 
   for ll = 1:nM, M(:,:,ll) = randsrc(n1,n2,[1i -1i 1 -1]); end
elseif strcmpi(type,masktypes{4})
   M = zeros(n1,n2,nM);  % Storage for nM masks, each of dim n1 x n2

   % Sample phases: each symbol in alphabet {1, -1, i , -i} has equal prob. 
   for ll = 1:nM, M(:,:,ll) = randsrc(n1,n2,[1i -1i 1 -1]); end

   % Sample magnitudes and make masks 
   temp = rand(n1,n2,nM);
   M = M .* ( (temp <= 0.2)*sqrt(3) + (temp > 0.2)/sqrt(2) );
end