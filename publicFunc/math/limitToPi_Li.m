function [x] = limitToPi_Li(x)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
if length(x)==6
    if norm(x(4:6))>pi
        x(4:6)=x(4:6)/norm(x(4:6))*abs(norm(x(4:6))-pi);
    end
end
if length(x)==3
    if norm(x)>pi
        x=x/norm(x)*abs(norm(x)-pi);
    end    
end

end

