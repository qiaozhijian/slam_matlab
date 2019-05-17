function [ Rad ] = Quaternion_to_Euler( quaternion )
  
  sum=sqrt(quaternion(0+1)*quaternion(0+1)+quaternion(1+1)*quaternion(1+1)+quaternion(2+1)*quaternion(2+1)+quaternion(3+1)*quaternion(3+1));
  quaternion=quaternion/sum;
  q0=quaternion(0+1);
  q1=quaternion(1+1);
  q2=quaternion(2+1);
  q3=quaternion(3+1);
  
  y=2 * q0 * q1 + 2 * q2 * q3;
  x=q3*q3 - q2 * q2 - q1 * q1 +q0 * q0;
  Rad(1)= atan2( y , x);
  x=2.0*(q1*q3 - q0*q2);
  Rad(2)= asin(-x);
  Rad(3)=atan2(2*q1*q2+2*q0*q3,-q2*q2-q3*q3+q0*q0+q1*q1);

%   %���л���ת�Ƕ�
  Rad=Rad/pi*180;
end

