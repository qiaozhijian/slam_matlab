function [outputArg2] = toCross(inputArg2)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
x=inputArg2(1);
y=inputArg2(2);
z=inputArg2(3);
outputArg2 = [0 -z y;z 0 -x;-y x 0];
end

