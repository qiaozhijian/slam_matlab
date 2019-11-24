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
    [v e]=eig(R);
    e=diag(e);
    v=v(:,find(abs(e-1)==min(abs(e-1))));
    w = v*theta;
    if max(max(abs(expso3(w)-R)))> 1e-5
        w = -w;
        if max(max(abs(expso3(w)-R)))> 1e-5
            'wr'
        end
    end
end
x = w;
x=limitToPi_Li(x);
end