function [ateErr] = ateError(esti,real)
[m n]=size(esti);
%计算初试转换矩阵差
if n==7 %旋转用四元数表示的
    realt=real(:,1:3);
    realQ=real(:,4:7);
    estit=esti(:,1:3);
    estiQ=esti(:,4:7);
    %EIGEN算的q，实部在后。matlab和公认的，实部在前
    if(estiQ(1,1))<0.9
        estiQ=[estiQ(:,4) estiQ(:,1:3)];
    end
    estiT_start=qrt2T(estiQ(1,:),estit(1,:));
    realT_start=qrt2T(realQ(1,:),realt(1,:));
    for i=1:m
        Tm=qrt2T(estiQ(i,:),estit(i,:));
        deltaT=Tm/estiT_start;
        esti_aligned=deltaT*realT_start;
        estit2(i,:)=esti_aligned(1:3,4)';
    end
elseif n==12
    realt=real(:,1:3);
    realR=real(:,4:12);
    estit=esti(:,[4 8 12]);
    estiR=[esti(:,1:3) esti(:,5:7) esti(:,9:11)];
    estiT_start=qrt2T(estiR(1,:),estit(1,:));
    realT_start=qrt2T(realR(1,:),realt(1,:));
    for i=1:m
        Tm=qrt2T(estiR(i,:),estit(i,:));
        deltaT=Tm/estiT_start;
        esti_aligned=deltaT*realT_start;
        estit2(i,:)=esti_aligned(1:3,4)';
    end
end

err=estit2-realt;
ateErr=sqrt(mean(err(:,1).^2+err(:,2).^2+err(:,3).^2));

% figure 
% plot3(realt(:,1),realt(:,2),realt(:,3),'.')
% hold on
% plot3(estit(:,1),estit(:,2),estit(:,3),'.')
% plot3(estit2(:,1),estit2(:,2),estit2(:,3),'.')
% view([0,0])%指定视角
% legend('real','esti','esti2');
% xlabel('X轴');ylabel('Y轴');zlabel('Z轴');

end

