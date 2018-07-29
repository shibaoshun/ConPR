function [Y,F,M,S,wvar] = instanceGenerator(Xopt,type,data,savefile,SNR,gamma,outliers)
%function [Xopt,Y,F,G,H,M,S] = instanceGenerator(imgfile,type,data,savefile,SNR,normalize)
%
% instance generator for generalized 2D phase retrieval dictionary learning
%
% INPUT: 
% imgfile  - filename (incl. path) of input original image Xopt
% type     - string specifying measurement type to create; choose from:
%            'cdp' - Sq. Fourier magnitudes of coded diffraction patterns
%            'gauss' - complex Gaussian measurements |G*Xopt|.^2
%            'gkronsymm' - complex Gaussian meas. |G*Xopt*G'|.^2
%            'gkron' - complex Gaussian meas. |G*Xopt*H'|.^2
% Note: Of course, if the user specifies matrices G and/or H by setting the
% fields in the data struct (describes next), these can be arbitrary and
% non-Gaussian; the terms used above pertain to what this function creates
% if no user-given matrices (or masks M, for that matter) are available!
%
% OPTIONAL INPUT: 
% data     - struct with predefined parts or parameters to be used in the 
%            instance generation process; leave empty to use defaults. 
%            Fields irrelevant to specified measurement type will be 
%            ignored. Valid fields are:
%            .G, .H - the matrices G,H used for Gaussian meas. types
%            .oversamplfact - sampling ratio in Gaussian case [default:4]
%            .M - diffraction masks (3D-array; M(:,:,j) is j-th mask)
%            .numM - number of diffraction masks [default:5]
%            .cdptype - type of diffraction masks; choose from 
%              'complex' [default], 'ternary', or 'binary' [experimental]
%            .fun - user-provided measurement function
%
% savefile - filename (incl. path) for saving the generated instance data
%            [default: don't save anything]
% SNR      - value inf gives noiseless measurements [default], otherwise 
%            specifies SNR value (in dB) s.t. white Gaussian noise is added 
%            to the measurements accordingly
% normalize - toggle whether to (L2-)normalize rows of measurement matrix 
%            (not available in cdp case) [default: no normalization]
%
% OUTPUT:
% Xopt     - original image (entries as doubles in [0,1]); 
% Y        - measurements of Xopt according to specified type;
%            if Xopt is an RGB color image, Y will contain measurements 
%            of all three color channels, so that, e.g., the measurements
%            for the "green" channel will be stored in Y{2}
% F        - linear operator used in measurements: a function handle whose
%            2nd argument specifies forward (0) or adjoint (1) application
% G,H,M    - matrices or diffraction masks used to create F
% S        - sammpling matrix;support of Xopt (as binary mask of the same size); 
%            only created in experimental 'sqfft' case, where Xopt is 
%            embedded into larger all-zero image and the support is thus 
%            known (exactly).
%            For other types, it is just S=1 (so that S.*X = X itself)
%
% Note: All output variables that are not needed (not related to selected
% measurement model) will be set to [].
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This function is part of the DOLPHIn package (version 1.10)
% last modified: 04/26/2016, A. M. Tillmann
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
% set some parameters and defaults:
if( ~exist('SNR','var') ),               SNR = inf; end
if( exist('data','var') )
    if( isfield(data,'numM') ),          numM = data.numM; end
    if( isfield(data,'cdptype') ),       cdptype = data.cdptype; end
end
if ~exist('outliers','var');
    outliers=0;
end

[m,n,c] = size(Xopt);
% if c>1: same operators, but different noise for each channel 
S=ones(size(Xopt));
% create matrices/masks, measurement operator and measurements Y, 
% according to selected type:
if( strcmpi(type,'cdp') )
    if numM<=1 %add by lqs 2017.2.7
            rate=numM;
            numM=1;
            S=rand(size(Xopt))<=rate;% lqs creat sampling matrix;
            %S(1,1)=1;
    end    
    M = create_cdp_masks(m,n,numM,cdptype);  
        % add ID-"mask":
        %M(:,:,numM+1) = ones(m,n);
    if numM>1
        S=ones(size(M));
    end
    F = @(XX,tt)op_cdp_2d(XX,M,tt,S); % measurement operator 
    for col=1:c
        Y{col} = fun_general_op(F,Xopt(:,:,col)); % = abs(F(Xopt,0)).^2
    end     
else
    fprintf('Unknown type; aborting.\n');
    Xopt = []; F = []; G = []; H = []; M = []; S = [];
    return;
end
if( ~isinf(SNR) )
    for col=1:c
        Ys=Y{col}(:);
        %Yz=zeros(size(Ys));
        %indx=find(S);
        %Ys=Ys(indx);
        Yc=Ys;
        if gamma==0
           Ys=awgn(Ys,SNR,'measured','dB');          
        else
           Ys=poissrnd(gamma*Yc)/gamma;           
        end
        if outliers>0
            otindx= randperm(length(Ys),outliers);
            Ys(otindx)=1.2*max(Yc(:));
        end
        fprintf('The SNR of the noisy measurement is: %.2f dB\n',calc_snr(Yc,Ys));
        fprintf('The Rnoise of the noisy measurement is %.2f %% \n',100*Rnoise(Yc,Ys));
         Y=Ys;
    %       Y{col} = reshape(Ys,size(Y{col}));
    end
end
Y=max(0,Y);
wvar=var(sqrt(Y(:))-sqrt(Yc(:)));
wvar=max(eps,wvar);

if( exist('savefile','var') && ~isempty(savefile) )
    save(savefile,'Xopt','Y','F','G','H','M','S','type');
end
