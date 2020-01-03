function [ ax ] = platFilter1d( x,m )
ax=zeros(length(x)-m+1,1);
for i=m:length(x)
ax(i-m+1)=mean(x(i-m+1:i));
end
end

