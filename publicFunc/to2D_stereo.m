function [uv_unit] = to2D_stereo(P,cam)
%2DTO3D_STEREO 此处显示有关此函数的摘要
%   此处显示详细说明
 uv_unit(1) = cam.cx + cam.fx * P(1) / P(3);
 uv_unit(2) = cam.cy + cam.fy * P(2) / P(3);
end

