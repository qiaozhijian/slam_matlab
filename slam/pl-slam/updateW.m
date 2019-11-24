%% 
function [W]=updateW(W,theta)
W=[cos(theta) -sin(theta);sin(theta) cos(theta)]*W;
end
