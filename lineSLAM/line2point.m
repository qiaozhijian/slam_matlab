%%
function [p0 p1] = line2point(U,W)
w1=W(1,1);
w2=W(2,1);
u1=U(:,1);
u2=U(:,2);
n=w1*u1;
v=w2*u2;
d=[cross(v,n);v'*v];
d=d(1:3)/d(4);
p0=d;
p1=d+v/norm(v);
end
