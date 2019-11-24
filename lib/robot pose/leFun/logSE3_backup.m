function [x] = logSE3_backup(T)
R=eye(3);
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
sine=abs(sin(theta));
if( theta > 0.000001 )
    w = invCross(logm(R));
    if det(expso3(w)-R)> 0.000001
        w = -v*theta;
        if det(expso3(w)-R)> 0.000001
            'wr'
        end
    end
    s = toCross(w) / theta;
    V = eye(3) + s * (1.0-cosine) / theta + s * s * (theta - sine) / theta;
end
t = inv(V) * Vt;
x(1:3,1) = t;
x(4:6,1) = w;
x=limitToPi_Li(x);
end

% for i=1:1000
% x=randn(6,1);
% r(i)=norm(logSE3(expse3(x))-limitToPi_Li(x));
% end
% max(r)