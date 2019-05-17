function [x] = logSE3(T)
R=eye(3);Id3=eye(3);
V=eye(3);w_hat=zeros(3);
Vt=T(1:3,4);
w=zeros(3,1);
R = T(1:3,1:3);
cosine = (trace(R) - 1)/2;
if(cosine > 1.0)
    cosine = 1;
elseif cosine < -1
    cosine = -1;
end
sine = sqrt(1.0-cosine*cosine);
theta  = acos(cosine);
sine=sin(theta);
if( theta > 0.000001 )
    w_hat = theta*(R-R')/(2.0*sine);
    %w = invCross(w_hat);
    w=invCross(logm(R));
    s = toCross(w) / theta;
    V = Id3 + s * (1.0-cosine) / theta + s * s * (theta - sine) / theta;
end
t = inv(V) * Vt;
x(1:3,1) = t;
x(4:6,1) = w;
x=limitToPi_Li(x);
end

%%测试，so3李代数一定要模长小于pi
%%clear r
% for i=1:100000
% x=randn(6,1);
% if norm(x(4:6))>pi
% x(4:6)=x(4:6)/norm(x(4:6))*abs(norm(x(4:6))-pi);
% end
% r(i)=norm(abs(logSE3(expse3(x))-x));
% end
% max(r)