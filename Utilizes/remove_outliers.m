function y=remove_outliers(x)
%kernel=[1 1 1; 1 4 1; 1 1 1]/12;
xxm=medfilt2(x,[3,3]);%imfilter(x,kernel, 'symmetric','same');
xx=x-xxm;
mx=abs(xx)>8*std((xx(:)));
y=x;
y(mx==1)=xxm(mx==1);