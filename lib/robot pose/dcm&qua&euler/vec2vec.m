function [R] = vec2vec(v1,v2)
%UNTITLED3 此处显示有关此函数的摘要
%   输出向量v1到向量v2的旋转矩阵
v1=v1/norm(v1);
v2=v2/norm(v2);
n=cross(v1,v2);
t=acos(v1'*v2/norm(v1)/norm(v2));
M = makehgtform('axisrotate',n,t);
R=M(1:3,1:3);
v=R*v1;
err=norm(v-v2);
if err>0.0001
    M = makehgtform('axisrotate',n,-t);
    R=M(1:3,1:3);
    v=R*v1;
    err=norm(v-v2);
    if err>0.0001
    'wrong'
    end
end
end
