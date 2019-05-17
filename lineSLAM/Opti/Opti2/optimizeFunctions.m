function [H, g, e]=optimizeFunctions(line_p,line_c,Tcp,graph,cam)
if iscell(Tcp)==0
    temp=Tcp;
    clear Tcp
    Tcp{1}=temp;
end
nPose=length(Tcp);nLine=length(line_p);
H=zeros(6*(nPose+nLine));
g=zeros(6*(nPose+nLine),1);
e=0;
for poseI=1:nPose
    for lineI=1:nLine
        if graph(poseI,lineI)==1
            line_c_predict=updateLineByTcp(line_p{lineI},Tcp{poseI},cam);
            l_obs=cross(line_c{poseI,lineI}.sp,line_c{poseI,lineI}.ep);
            l_obs=l_obs/sqrt(l_obs(1)*l_obs(1)+l_obs(2)*l_obs(2));
            err_i(1,1)=line_c_predict.sp'*l_obs;
            err_i(2,1)=line_c_predict.ep'*l_obs;
            err_i_norm=norm(err_i);
            ds=err_i(1);de=err_i(2);lx=l_obs(1);ly=l_obs(2);
            gx=line_c_predict.sP(1);gy=line_c_predict.sP(2);gz=line_c_predict.sP(3);
            gz2 = gz*gz;fgz2=cam.fx/gz2;
            Js_aux=[+ fgz2 * lx * gz,...
                    + fgz2 * ly * gz,...
                    - fgz2 * ( gx*lx + gy*ly ),...
                    - fgz2 * ( gx*gy*lx + gy*gy*ly + gz*gz*ly ),...
                    + fgz2 * ( gx*gx*lx + gz*gz*lx + gx*gy*ly ),...
                    + fgz2 * ( gx*gz*ly - gy*gz*lx )];
            J_sp=[fgz2*lx*gz,fgz2*ly*gz,-fgz2*(lx*gx+ly*gy)];
            J_sp=J_sp*Tcp{poseI}(1:3,1:3);
                    
            gx=line_c_predict.eP(1);gy=line_c_predict.eP(2);gz=line_c_predict.eP(3);
            gz2 = gz*gz;fgz2=cam.fx/gz2;
            Je_aux=[+ fgz2 * lx * gz,...
                    + fgz2 * ly * gz,...
                    - fgz2 * ( gx*lx + gy*ly ),...
                    - fgz2 * ( gx*gy*lx + gy*gy*ly + gz*gz*ly ),...
                    + fgz2 * ( gx*gx*lx + gz*gz*lx + gx*gy*ly ),...
                    + fgz2 * ( gx*gz*ly - gy*gz*lx )];
            J_pose = [Js_aux ; Je_aux];
            J_ep=[fgz2*lx*gz,fgz2*ly*gz,-fgz2*(lx*gx+ly*gy)];
            J_ep=J_ep*Tcp{poseI}(1:3,1:3);
            
            J_line=[J_sp zeros(1,3);zeros(1,3) J_ep];
            
            poseIdx=(poseI-1)*6+1;
            lineIdx=6*nPose+(lineI-1)*6+1;
            
            H(poseIdx:poseIdx+5,poseIdx:poseIdx+5) = H(poseIdx:poseIdx+5,poseIdx:poseIdx+5) + J_pose' * J_pose;
            H(poseIdx:poseIdx+5,lineIdx:lineIdx+5) = H(poseIdx:poseIdx+5,lineIdx:lineIdx+5) + J_pose' * J_line;
            H(lineIdx:lineIdx+5,poseIdx:poseIdx+5) = H(lineIdx:lineIdx+5,poseIdx:poseIdx+5) + J_line' * J_pose;
            H(lineIdx:lineIdx+5,lineIdx:lineIdx+5) = H(lineIdx:lineIdx+5,lineIdx:lineIdx+5) + J_line' * J_line;
            g(poseIdx:poseIdx+5) = g(poseIdx:poseIdx+5) - J_pose' * err_i;
            g(lineIdx:lineIdx+5) = g(lineIdx:lineIdx+5) - J_line' * err_i;
            e = e + err_i_norm;
        end
    end
end
e=e/nLine;
end