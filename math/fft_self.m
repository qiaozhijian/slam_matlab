function [ result ] = fft_self( data,Fs )
%输入数据和数据的采样频率               
T = 1/Fs;             % 计算采样周期     
L = length(data);     % 计算序列长度
Y = fft(data);        %对data进行fft变化
P2 = abs(Y/L);        %求出相对幅度大小
P1 = P2(1:floor(L/2+1));%把双边序列变成单边序列
P1(2:end-1) = 2*P1(2:end-1);%双边序列的幅值叠加
f = Fs*(0:(L/2))/L;   %绘制横轴坐标    
[m n]=size(P1);
if m==1
P1=P1';
end
f=f';
result=[f P1];
% plot(f,P1) 
% title('Single-Sided Amplitude Spectrum of X(n)')
% xlabel('f (Hz)')
% ylabel('相对能量大小')
end

