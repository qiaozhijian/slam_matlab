function [x,P]=ukf(fstate,x,P,hmeas,z,Q,R,w,T)
% UKF   Unscented Kalman Filter for nonlinear dynamic systems
% [x, P] = ukf(f,x,P,h,z,Q,R) returns state estimate, x and state covariance, P 
% for nonlinear dynamic system (for simplicity, noises are assumed as additive):
%           x_k+1 = f(x_k) + w_k
%           z_k   = h(x_k) + v_k
% where w ~ N(0,Q) meaning w is gaussian noise with covariance Q
%       v ~ N(0,R) meaning v is gaussian noise with covariance R
% Inputs:   f: function handle for f(x)
%           x: "a priori" state estimate
%           P: "a priori" estimated state covariance
%           h: fanction handle for h(x)
%           z: current measurement
%           Q: process noise covariance 
%           R: measurement noise covariance
% Output:   x: "a posteriori" state estimate
%           P: "a posteriori" state covariance
%%
%初始值的设定
n=numel(x);                                 %状态空间维数
m=numel(z);                                 %测量值维数
alpha=1e-3;                                 %default, tunable（可调的）
kappa=0;                                       %default, tunable
beta=2;                                     %default, tunable beta=2表示认为分布完全为高斯分布
lambda=alpha^2*(n+kappa)-n;                    %scaling factor lambda is constant! --zhijain
c=n+lambda;                                 %scaling factor
%%
%Wm和Wc的计算 （他们后2n项都一样，都为1/(n+lambda)）
Wm=[lambda/c 0.5/c+zeros(1,2*n)];           %weights for means
Wc=Wm;
Wc(1)=Wc(1)+(1-alpha^2+beta);               %weights for covariance
%%
c=sqrt(c);
X=sigmas(x,P,c);                            %sigma points around x
[x1,X1,P1,X2]=ut(fstate,X,Wm,Wc,n,Q,w,T);          %unscented transformation of process
% X1=sigmas(x1,P1,c);                         %sigma points around x1
% X2=X1-x1(:,ones(1,size(X1,2)));             %deviation of X1
[z1,Z1,P2,Z2]=ut(hmeas,X1,Wm,Wc,m,R,w,T);       %unscented transformation of measurments
P12=X2*diag(Wc)*Z2';                        %transformed cross-covariance
K=P12*inv(P2);
x=x1+K*(z-z1);                              %state update
P=P1-K*P12';                                %covariance update
   
