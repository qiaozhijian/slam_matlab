%根据线的世界坐标和Twc获得每一帧的相机坐标系的参数
function [line_c] = updateLineByTwc(line_w,Twc,cam)
Tcw=Twc^-1;
Rcw=Tcw(1:3,1:3);
tcw=Tcw(1:3,4);
line_c=struct('sp',zeros(3,1),'ep',zeros(3,1),'sP',zeros(3,1),'eP',zeros(3,1),'sdisp',0,'edisp',0,'L',0,'orth',0);

line_c.sP=Rcw*line_w.sP+tcw;
line_c.eP=Rcw*line_w.eP+tcw;

line_c.sp=projectMono(line_c.sP,cam);
line_c.ep=projectMono(line_c.eP,cam);

line_c.sdisp=cam.b*cam.fx/line_c.sP(3);
line_c.edisp=cam.b*cam.fx/line_c.eP(3);
[line_c.L,line_c.orth]=point2line(line_c.sP,line_c.eP);
end