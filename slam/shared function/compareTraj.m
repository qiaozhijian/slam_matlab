function [err]=compareTraj(Twc_,Twc)
n=length(Twc);
twc=zeros(3,1);
twc_=zeros(3,1);
err=zeros(1,n);
for i=1:n
    twc(:,i)=Twc{i}(1:3,4);
    twc_(:,i)=Twc_{i}(1:3,4);
    Rwc{i}=Twc{i}(1:3,1:3);
    Rwc_{i}=Twc_{i}(1:3,1:3);
end
for i=1:n
err(i)=norm(twc(:,i)-twc_(:,i));
errAngle(i)=norm(logSO3(Rwc{i})-logSO3(Rwc_{i}));
end
err=sqrt(mean(err.^2));
errAngle=sqrt(mean(errAngle.^2));
figure
plot3(twc_(1,:),twc_(2,:),twc_(3,:))
hold on
plot3(twc(1,:),twc(2,:),twc(3,:))
legend('esti','real')

title(['¹ì¼£Îó²î = ' num2str(err) ' Ðý×ªÎó²î = ' num2str(errAngle)])
end
