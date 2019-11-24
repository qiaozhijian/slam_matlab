function [p] = plane3(x1,x2,x3)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
if length(x1)==4
x1_=x1(1:3); x2_=x2(1:3); x3_=x3(1:3);
p=[cross((x1_-x3_),(x2_-x3_));-x3_'*cross(x1_,x2_)];
else
p=[cross((x1-x3),(x2-x3));-x3'*cross(x1,x2)];
end
%p=p/p(4);
end

