function [ Rn] = Rnoise( Fabs,Fabs_n )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
Rn=sum(sum(abs(Fabs-Fabs_n)))./sum(sum(Fabs));

end

