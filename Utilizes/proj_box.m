function X = proj_box(Y)
%function X = proj_box(Y)
%
% Projection of X onto [0,1] (component-wise).
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
X = max(min(Y,1),0); % for real image
 %X = max(min(abs(Y),1),0).*exp(1j*max(min(angle(Y),pi),0));   % lqs for complex image
% X = max(min(abs(Y),1),0).*exp(1j*angle(Y));%max(min(angle(Y),pi),0));   % lqs for complex image
