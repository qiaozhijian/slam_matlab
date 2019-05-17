
%根据估计Tcp对当前帧的线参数进行预测
function [line_c] = updateLineByTcp(line_p,Tcp,cam)
Rcp=Tcp(1:3,1:3);
tcp=Tcp(1:3,4);
line_c=struct('sp',zeros(3,1),'ep',zeros(3,1),'sP',zeros(3,1),'eP',zeros(3,1),'sdisp',0,'edisp',0);

line_c.sP=Rcp*line_p.sP+tcp;
line_c.eP=Rcp*line_p.eP+tcp;

line_c.sp=projectMono(line_c.sP,cam);
line_c.ep=projectMono(line_c.eP,cam);

line_c.sdisp=cam.b*cam.fx/line_c.sP(3);
line_c.edisp=cam.b*cam.fx/line_c.eP(3);
end