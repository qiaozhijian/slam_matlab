function [euler] = AccToEuler2(acc_x,acc_y,acc_z)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
euler=[atan2d(-acc_y,-acc_z) asind(acc_x) zeros(length(acc_x),1)];
end

