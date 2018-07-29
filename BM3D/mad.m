function Nsig= mad( IMinnoise )
x=IMinnoise;
 windowsize  = 7;
windowfilt = ones(1,windowsize)/windowsize;
% Number of Stages
L = 6;
% symmetric extension
N1 = length(x);
N1 = N1+2^L;
x = symextend(x,2^(L-1));
% forward transform
[af, sf] = farras;
W = dwt2D(x,L,af); 
% Noise variance estimation using robust median estimator..
tmp = W{1}{3};
Nsig = median(abs(tmp(:)))/0.6745;
  

