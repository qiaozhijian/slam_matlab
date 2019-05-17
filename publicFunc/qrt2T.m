function [T] = qrt2T(q,t)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
if length(q)==4 && length(t)==3
dcm=quat2dcm(q);
T=[dcm t';0 0 0 1];
end
if length(q)==9 && length(t)==3
dcm=dcm9to33(q);
T=[dcm t';0 0 0 1];
end
if length(q)==12 
dcm=dcm9to33(q(4:12));
t=q(1:3);
T=[dcm t';0 0 0 1];
end
if length(q)==7
dcm=quat2dcm(q(4:7));
t=q(1:3);
T=[dcm t';0 0 0 1];
end

end

