function [ result ] = fft_self( data,Fs )
%�������ݺ����ݵĲ���Ƶ��               
T = 1/Fs;             % �����������     
L = length(data);     % �������г���
Y = fft(data);        %��data����fft�仯
P2 = abs(Y/L);        %�����Է��ȴ�С
P1 = P2(1:floor(L/2+1));%��˫�����б�ɵ�������
P1(2:end-1) = 2*P1(2:end-1);%˫�����еķ�ֵ����
f = Fs*(0:(L/2))/L;   %���ƺ�������    
[m n]=size(P1);
if m==1
P1=P1';
end
f=f';
result=[f P1];
% plot(f,P1) 
% title('Single-Sided Amplitude Spectrum of X(n)')
% xlabel('f (Hz)')
% ylabel('���������С')
end

