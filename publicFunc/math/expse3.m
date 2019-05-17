function [T] = expse3(x)
    x=limitToPi_Li(x);
    R = eye(3);V = eye(3);s = eye(3);I = eye(3);
    T = eye(4);
    w = x(4:6);
    t = x(1:3);
    theta = norm(w);
    if theta>0.000001
        s = toCross(w)/theta;
        R = I + s * sin(theta) + s * s * (1-cos(theta));
        V = I + s * (1 - cos(theta)) / theta + s * s * (theta - sin(theta)) / theta;
        t = V * t;
    else
        R=eye(3);
    end
    if norm(t)<0.000001
        t=[0;0;0];
    end
    T(1:3,1:4)=[R t];
end

