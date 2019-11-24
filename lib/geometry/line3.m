%%
function [none]=line3(p0,p1)
if nargin==2
plot3([p0(1) p1(1)],[p0(2) p1(2)],[p0(3) p1(3)]);
end
if nargin==1
plot3([0 p0(1)],[0 p0(2)],[0 p0(3)]);
end
end