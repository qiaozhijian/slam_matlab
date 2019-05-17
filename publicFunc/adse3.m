function [AdjT] = adse3(x)
w=x(4:6);
t=x(1:3);
AdjT(1:3,1:3) = toCross(w);
AdjT(1:3,4:6) = toCross(t);
AdjT(4:6,1:3) = zeros(3,3);
AdjT(4:6,4:6) = toCross(w);
end