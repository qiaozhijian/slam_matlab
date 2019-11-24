
function X=sigmas(x,P,c)
%Sigma points around reference point
%Inputs:
%       x: reference point
%       P: covariance
%       c: coefficient
%Output:
%       X: Sigma points
n=numel(x);
A = c*chol(P)';
%copy x for n times --zhijian
Y = x(:,ones(1,n));
X = [x Y+A Y-A];