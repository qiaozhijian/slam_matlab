function [ quaternion ] = euler2quat_self( Rad )
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
Rad=Rad/180*pi;
quaternion(1)=cos(Rad(1)/2)*cos(Rad(2)/2)*cos(Rad(3)/2)+sin(Rad(1)/2)*sin(Rad(2)/2)*sin(Rad(3)/2);
quaternion(2)=sin(Rad(1)/2)*cos(Rad(2)/2)*cos(Rad(3)/2)-cos(Rad(1)/2)*sin(Rad(2)/2)*sin(Rad(3)/2);
quaternion(3)=cos(Rad(1)/2)*sin(Rad(2)/2)*cos(Rad(3)/2)+sin(Rad(1)/2)*cos(Rad(2)/2)*sin(Rad(3)/2);
quaternion(4)=cos(Rad(1)/2)*cos(Rad(2)/2)*sin(Rad(3)/2)-sin(Rad(1)/2)*sin(Rad(2)/2)*cos(Rad(3)/2);

end

