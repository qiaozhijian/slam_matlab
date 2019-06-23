function [AdjT] = adjointSE3(T)
AdjT = zeros(6,6);
R = T(1:3,1:3);
AdjT(1:3,1:3) = R;
AdjT(1:3,4:6) = toCross( T(1:3,4) ) * R ;
AdjT(4:6,4:6) = R;
end



