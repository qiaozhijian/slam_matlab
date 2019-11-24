function [R] = quat2dcm_self(Q)
  sum=sqrt(quaternion(0+1)*quaternion(0+1)+quaternion(1+1)*quaternion(1+1)+quaternion(2+1)*quaternion(2+1)+quaternion(3+1)*quaternion(3+1));
  quaternion=quaternion/sum;
  q0=quaternion(0+1);
  q1=quaternion(1+1);
  q2=quaternion(2+1);
  q3=quaternion(3+1);
  R=[ 1-2*(q2^2+q3^2) 2*(q1*q2-q0*q3) 2*(q1*q3+q0*q2);
      2*(q1*q2+q0*q3) 1-2*(q1^2+q3^2) 2*(q2*q3-q0*q1);
      2*(q1*q3-q0*q2) 2*(q2*q3+q0*q1) 1-2*(q1^2+q2^2)];
end

