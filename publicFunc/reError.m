function [reErr] = reError(esti,real,interval)
[m n]=size(esti);
K=floor(m/interval);
for i=1:K
realSet=real((i-1)*interval+1:i*interval,:);
estiSet=esti((i-1)*interval+1:i*interval,:);
reErr(i)=ateError(estiSet,realSet);
end
reErr=mean(reErr);
end

