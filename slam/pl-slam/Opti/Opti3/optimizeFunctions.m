
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
            lineK=[cam.fy 0 0;0 cam.fx 0;-cam.fy*cam.cx -cam.fx*cam.cy cam.fx*cam.fy];
            l_obs=lineK*line_c_predict.L.n;
            l1=l_obs(1);l2=l_obs(2);
            ln2=l1*l1+l2*l2;ln=sqrt(ln2);
            
            line_obs=line_c{poseI,lineI};
            e1=line_obs.sp'*l_obs;
            e2=line_obs.ep'*l_obs;
            err_i(1,1)=e1/ln;err_i(2,1)=e2/ln;err_i_norm=norm(err_i);
             
            jacobiErr_l=[line_obs.sp(1)-l1*e1/ln2 line_obs.sp(2)-l2*e1/ln2 1;...
                         line_obs.ep(1)-l1*e2/ln2 line_obs.ep(2)-l2*e2/ln2 1]/ln;
            jacobil_Lc=[lineK zeros(3,3)];
            jacobiLc_x=-adse3(line_c_predict.L.nv);
            J_pose=jacobiErr_l*jacobil_Lc*jacobiLc_x;
            
            jacobiLc_Lw=adjointSE3(Tcp{poseI});
            jacobiLw_orth=[-toCross(line_p{lineI}.orth.w1*line_p{lineI}.orth.u1) -line_p{lineI}.orth.w2*line_p{lineI}.orth.u1;...
                -toCross(line_p{lineI}.orth.w2*line_p{lineI}.orth.u2) line_p{lineI}.orth.w1*line_p{lineI}.orth.u2];
            J_line=jacobiErr_l*jacobil_Lc*jacobiLc_Lw*jacobiLw_orth;
            
            poseIdx=(poseI-1)*6+1;
            lineIdx=6*nPose+(lineI-1)*4+1;
            
            H(poseIdx:poseIdx+5,poseIdx:poseIdx+5) = H(poseIdx:poseIdx+5,poseIdx:poseIdx+5) + J_pose' * J_pose;
            H(poseIdx:poseIdx+5,lineIdx:lineIdx+3) = H(poseIdx:poseIdx+5,lineIdx:lineIdx+3) + J_pose' * J_line;
            H(lineIdx:lineIdx+3,poseIdx:poseIdx+5) = H(lineIdx:lineIdx+3,poseIdx:poseIdx+5) + J_line' * J_pose;
            H(lineIdx:lineIdx+3,lineIdx:lineIdx+3) = H(lineIdx:lineIdx+3,lineIdx:lineIdx+3) + J_line' * J_line;
            g(poseIdx:poseIdx+5) = g(poseIdx:poseIdx+5) - J_pose' * err_i;
            g(lineIdx:lineIdx+3) = g(lineIdx:lineIdx+3) - J_line' * err_i;
            
            e = e + err_i_norm;
        end
    end
end
e=e/nLine;
end
