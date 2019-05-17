function [x]=updateX(x,delta_x,nPose,nLine)

for i=1:nPose
    poseIdx=(i-1)*6+1;
    tempT=expse3(delta_x(poseIdx:poseIdx+5))*expse3(x(poseIdx:poseIdx+5));
    x(poseIdx:poseIdx+5)=logSE3(tempT);
end

for i=1:nLine
    lineIdx=6*nPose+(i-1)*6+1;
    orthIdx=6*nPose+(i-1)*4+1;
    [L orth]=point2line(x(lineIdx:lineIdx+2),x(lineIdx+3:lineIdx+5));
    orth.U=expm(toCross(delta_x(orthIdx:orthIdx+2)))*orth.U;
    a=delta_x(orthIdx+3);
    orth.W=[cos(a) -sin(a);sin(a) cos(a)]*orth.W;
    [sp,ep]=line2point(orth.U,orth.W);
    x(lineIdx:lineIdx+5) = [sp;ep];
end

end