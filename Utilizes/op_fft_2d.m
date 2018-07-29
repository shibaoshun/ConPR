function B = op_fft_2d(Z,t)
%function B = op_fft_2d(Z,t)
%
% Implements the (normalized) 2D-FFT linear operator (and its adjoint), 
% wrapper to conform with DOLPHIn function format.
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
   B = myfft(Z);  
else % adjoint (inverse fft)
   B = myifft(Z); 
end