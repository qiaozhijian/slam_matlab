
function [H, g, e]=optimizeFunctions(line_p,line_c,Tcp,graph,cam)
if iscell(Tcp)==0
    temp=Tcp;
    clear Tcp
    Tcp{1}=temp;
end
nPose=length(Tcp);nLine=length(line_p);
H=zeros(6*nPose+4*nLine);
g=zeros(6*nPose+4*nLine,1);
e=0;
for poseI=1:nPose
    for lineI=1:nLine
        if graph(poseI,lineI)==1
            line_c_predict=updateLineByTcp(line_p{lineI},Tcp{poseI},cam);
            n=line_c_predict.L.n;v=line_c_predict.L.v;
            n_=line_c{poseI,lineI}.L.n;v_=line_c{poseI,lineI}.L.v;
            err_i=[cross(v,n)/(v'*v)-cross(v_,n_)/(v_'*v_);cross(v,v_)];
            
            jacobiErr_Lc=zeros(6,6);
            jacobiErr_Lc(1:3,1:3)=toCross(v)/(v'*v);
            jacobiErr_Lc(4:6,4:6)=-toCross(v_);
            v4=(v'*v)^2;a=v(1);b=v(2);c=v(3);
            jacobiErr_Lc(1:3,4:6)=[ -a^2+b^2+c^2 -2*b -2*c;...
                                    -2*a a^2-b^2+c^2 -2*c;...
                                        -2*a -2*b a^2+b^2-c^2 ]/v4;
            jacobiLc_x=-adse3(line_c_predict.L.nv);
            J_pose=jacobiErr_Lc*jacobiLc_x;
            
            jacobiLc_Lw=adjointSE3(Tcp{poseI});
            jacobiLw_orth=[-toCross(line_p{lineI}.orth.w1*line_p{lineI}.orth.u1) -line_p{lineI}.orth.w2*line_p{lineI}.orth.u1;...
                -toCross(line_p{lineI}.orth.w2*line_p{lineI}.orth.u2) line_p{lineI}.orth.w1*line_p{lineI}.orth.u2];
            J_line=jacobiErr_Lc*jacobiLc_Lw*jacobiLw_orth;
            
            poseIdx=(poseI-1)*6+1;
            lineIdx=6*nPose+(lineI-1)*4+1;
            
            H(poseIdx:poseIdx+5,poseIdx:poseIdx+5) = H(poseIdx:poseIdx+5,poseIdx:poseIdx+5) + J_pose' * J_pose;
            H(poseIdx:poseIdx+5,lineIdx:lineIdx+3) = H(poseIdx:poseIdx+5,lineIdx:lineIdx+3) + J_pose' * J_line;
            H(lineIdx:lineIdx+3,poseIdx:poseIdx+5) = H(lineIdx:lineIdx+3,poseIdx:poseIdx+5) + J_line' * J_pose;
            H(lineIdx:lineIdx+3,lineIdx:lineIdx+3) = H(lineIdx:lineIdx+3,lineIdx:lineIdx+3) + J_line' * J_line;
            g(poseIdx:poseIdx+5) = g(poseIdx:poseIdx+5) - J_pose' * err_i;
            g(lineIdx:lineIdx+3) = g(lineIdx:lineIdx+3) - J_line' * err_i;
            
            e = e + norm(err_i);
        end
    end
end
e=e/nLine;
end