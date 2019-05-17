
function [x]=updateX(x,delta_x,nPose,nLine)

for i=1:nPose
    poseIdx=(i-1)*6+1;
    tempT=expse3(delta_x(poseIdx:poseIdx+5))*expse3(x(poseIdx:poseIdx+5));
    x(poseIdx:poseIdx+5)=logSE3(tempT);
end
for i=1:nLine
    lineIdx=6*nPose+(i-1)*6+1;
    x(lineIdx:lineIdx+5) = x(lineIdx:lineIdx+5) + delta_x(lineIdx:lineIdx+5);
end

end