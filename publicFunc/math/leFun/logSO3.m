function [x] = logSO3(R)
w_hat=zeros(3);
w=zeros(3,1);
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
    w = invCross(w_hat);
    w=invCross(logm(R));
end
x = w;
x=limitToPi_Li(x);
end