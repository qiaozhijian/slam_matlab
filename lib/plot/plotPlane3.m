function [none] = plotPlane3(x1,x2,x3,color)
%UNTITLED 
x=[x1(1) x2(1) x3(1)];
y=[x1(2) x2(2) x3(2)];
z=[x1(3) x2(3) x3(3)];
if nargin==3
color='b';
end
h=patch(x,y,z,color);

end

