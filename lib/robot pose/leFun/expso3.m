function [R] = expso3(x)
    x=limitToPi_Li(x);
    R = eye(3);s = eye(3);I = eye(3);
    w = x;
    theta = norm(w);
    if theta>0.000001
        s = toCross(w)/theta;
        R = I + s * sin(theta) + s * s * (1-cos(theta));
    else
        R=eye(3);
    end
end

