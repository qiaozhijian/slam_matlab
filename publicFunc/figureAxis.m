function [k]=figureAxis(ll)
hold on
ax=gca;
limit=[ax.XLim;ax.YLim;ax.ZLim];

maxp=(limit(:,2)+[1;1;1]);
maxn=(limit(:,1)-[1;1;1]);

plot3(maxp(1),0,0,'r.','markersize',20)
plot3(0,maxp(2),0,'r.','markersize',20)
plot3(0,0,maxp(3),'r.','markersize',20)
plot3(0,0,0,'r.','markersize',6)
line([maxn(1) maxp(1)],[0 0],[0 0],'Color','k','LineStyle','--')
line([0 0],[maxn(2) maxp(2)],[0 0],'Color','k','LineStyle','--')
line([0 0],[0 0],[maxn(3) maxp(3)],'Color','k','LineStyle','--')
text(0,0,(limit(3,2)+limit(3,1))/2,'z','Color','red','FontSize',14)
text(0,(limit(2,2)+limit(2,1))/2,0,'y','Color','red','FontSize',14)
text((limit(1,2)+limit(1,1))/2,0,0,'x','Color','red','FontSize',14)
xlabel('x');ylabel('y');zlabel('z');
view(30,10)
grid on;
end

