function [ quaternion ] = quatInt( quaternion , palstance,dT)
% 四元数积分(使用四阶龙哥库塔)

  palstance=palstance/180.0*pi;

  for grade=1:1:4
    temp_quarterion=quaternion;
    switch grade
    case 1
      dif_quarterion_1=calculateK(temp_quarterion,palstance,dT);
    case 2
      temp_quarterion=temp_quarterion+dif_quarterion_1/2.0;
      dif_quarterion_2=calculateK(temp_quarterion,palstance,dT);
    case 3
      temp_quarterion=temp_quarterion+dif_quarterion_2/2.0;
      dif_quarterion_3=calculateK(temp_quarterion,palstance,dT);
    case 4
      temp_quarterion=temp_quarterion+dif_quarterion_3;
      dif_quarterion_4=calculateK(temp_quarterion,palstance,dT);
    end
  end
  
  quaternion=quaternion+1/6*(dif_quarterion_1+2.0*dif_quarterion_2+2.0*dif_quarterion_3+dif_quarterion_4);
end

function [ dif_quarterion ] = calculateK(quaternion,data,dT)
  jacobi=getJacobi(quaternion,data);
  dif_quarterion(0+1)=jacobi(0+1)*dT;
  dif_quarterion(1+1)=jacobi(1+1)*dT;
  dif_quarterion(2+1)=jacobi(2+1)*dT;
  dif_quarterion(3+1)=jacobi(3+1)*dT; 
end


function [ dif_quarterion ] = getJacobi(quaternion,data)
  dif_quarterion(0+1)=(-quaternion(1+1)*data(0+1) - quaternion(2+1)*data(1+1) - quaternion(3+1)*data(2+1))*0.5;
  dif_quarterion(1+1)=( quaternion(0+1)*data(0+1) + quaternion(2+1)*data(2+1) - quaternion(3+1)*data(1+1))*0.5;
  dif_quarterion(2+1)=( quaternion(0+1)*data(1+1) - quaternion(1+1)*data(2+1) + quaternion(3+1)*data(0+1))*0.5;
  dif_quarterion(3+1)=( quaternion(0+1)*data(2+1) + quaternion(1+1)*data(1+1) - quaternion(2+1)*data(0+1))*0.5;
end