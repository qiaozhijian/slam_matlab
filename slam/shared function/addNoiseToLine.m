function [line]=addNoiseToLine(line,std,cam)
    line.sp=line.sp+[std*randn(2,1);0];
    line.ep=line.ep+[std*randn(2,1);0];
    line.sdisp=line.sdisp+std*randn(1);
    line.edisp=line.edisp+std*randn(1);
    line.sP(3)=cam.b*cam.fx/line.sdisp;
    line.sP(1)=(line.sp(1)-cam.cx)*line.sP(3)/cam.fx;
    line.sP(2)=(line.sp(2)-cam.cy)*line.sP(3)/cam.fy;
    line.eP(3)=cam.b*cam.fx/line.edisp;
    line.eP(1)=(line.ep(1)-cam.cx)*line.eP(3)/cam.fx;
    line.eP(2)=(line.ep(2)-cam.cy)*line.eP(3)/cam.fy;
end