function [ output_args ] = xcorr_self( data,fs )
% 求自相关系数
[a,b]=xcorr(data,'unbiased');
plot(b/fs,a)
end

