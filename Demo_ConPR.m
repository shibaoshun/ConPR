function Demo_ConPR()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Coded diffraction imaging from one coded diffraction pattern at Gaussion noise case
%%%%%%%%%%%%%%last modified by shibaoshun 2018 Mar 9th
%% add path
clear ;
close all;
CurrPath = cd;
addpath(genpath(CurrPath));
%% function defination
type ='cdp'; 
data.cdptype       ='quatary';%'complex'; %'quatary'; %'ternary';%  type of cdp masks {'binary';'ternary';'complex'};% binary 1 or -1
gamma=0;                      %0 for gaussian noise
outliers=0;
savefile           =        []; % filename to save instance data
%% select an image
Imagenumber=1;
 switch Imagenumber
 case 1
 ori_image='Lena512.png';
 case 2
 ori_image='barbara.png';
 case 3
 ori_image='hill.png';
 case 4
 ori_image='boat.png';
 case 5
 ori_image='couple.png';
 case 6
 ori_image='fingerprint.png';
 case 7
 ori_image='acinarcell.png';
 case 8
 ori_image='chromaffincell.png';  
 end
rng('default');
disp(['Loading image ',ori_image]);
disp(' ');
Imin=double(imread(ori_image))/255; % the original image 
SNR_num=[10 15 20 25 30];           % SNR number
%% innitial guess
 %x=PS(rand(size(Imin)));  
load initialguess.mat    % the same initialguess for each case, one can also exploit the random one
data.numM=1;             % one diffraction pattern
j=3;                     % select noise level
SNR=SNR_num(j)           % level of noise (added to measurements)
[Y,F,~,~,~] = instanceGenerator(Imin,type,data,savefile,SNR,gamma,outliers);
phi = @(I) F(I,0);       % define the linear transform operator A
phit = @(I) F(I,1);     % define the linear transform operator A^{H}
%% %%%%%%%%%%%%%%%%%%%%%<<<<ConPR_BM3D>>>%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('calling the function ConPR_BM3D.....\n');
t=clock;
Image=ConPR_BM3D(Y,phi,phit,x);
time=etime(clock,t);
PSNR=psnr(Image,Imin);
[FSIM, ~] = FeatureSIM(Imin, Image);% compute FSIM
%% show the result
fprintf(1,'PSNR = %6.2f \n', PSNR);
fprintf(1,'FSIM = %6.4f \n', FSIM);
fprintf(1,'Time = %6.2f \n', time);