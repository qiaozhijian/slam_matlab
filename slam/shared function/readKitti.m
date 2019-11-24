function [t,q,angle] = readKitti(path,mode)

real=textread(path);
num=length(real);
t=[];
q=[];
angle=[];
if mode == 0
    for i=1:num
        R=[real(i,1:3);real(i,5:7);real(i,9:11)];
        [angleZ angleY angleX]=dcm2angle(R,'ZYX');
        temp_q=dcm2quat(R);
        temp_t=[real(i,4) real(i,8) real(i,12)];
        temp_angle=[angleX angleY angleZ];
        t=[t;temp_t];
        q=[q;temp_q];
        angle=[angle;temp_angle];
    end
else
    for i=1:num
        R=[real(i,1:3);real(i,5:7);real(i,9:11)];
        [angleZ angleY angleX]=dcm2angle(R,'ZYX');
        temp_q=[real(i,1:3) real(i,5:7) real(i,9:11)];
        temp_t=[real(i,4) real(i,8) real(i,12)];
        temp_angle=[angleX angleY angleZ];
        t=[t;temp_t];
        q=[q;temp_q];
        angle=[angle;temp_angle];
    end
end
end

