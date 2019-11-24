%%
function [U]=updateU(U,theta)
U=expm(toCross(theta))*U;
end