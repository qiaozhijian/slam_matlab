function [plucker orth] = point2line(p0, p1,w)
   if (nargin<3)
        w = 1;
   end
   L=[cross(p0,p1);w*p1-w*p0];
   n=L(1:3,1);
   v=L(4:6,1);
   distance=norm(n)/norm(v);
   d=[cross(v,n);v'*v];
   d=d(1:3)/d(4);
   w1=norm(n);
   w2=norm(v);
   W=[w1 -w2;w2 w1];
   U=[n/norm(n) v/norm(v) cross(n,v)/norm(cross(n,v))];
   plucker=struct('n',n,'v',v,'nv',[n;v],'distance',distance,'d',d);
   orth=struct('U',U,'W',W,'w1',w1,'w2',w2,'u1',U(:,1),'u2',U(:,2));
end





