function [P] = to3D_stereo(point,d,cam)
%2DTO3D_STEREO 此处显示有关此函数的摘要
%   此处显示详细说明
u=point(1);
v=point(2);
bd = cam.b/d;
P(1,1) = bd*(u-cam.cx);
P(2,1) = bd*(v-cam.cy);
P(3,1) = bd*cam.fx;
end

