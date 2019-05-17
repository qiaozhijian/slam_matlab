function [p] = projectMono(x,cam)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
K=[cam.fx 0 cam.cx;0 cam.fy cam.cy;0 0 1];
if length(x)==4
x=x(1:3);
end
x=x/x(3);
p=K*x;
end

