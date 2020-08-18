%% get pExact is finding plane wave pressure at every node
function [Pexact] = getPexact(meshSize, angle,k)
% given node number (for loop)
% find coordnates of that node
% calculate plane wave pressure
global NodalCoord
Pexact = zeros((meshSize+1)^2,1);
dx = cos(angle*pi/180);
dy = sin(angle*pi/180);
for i = 1:(meshSize+1)^2
    x = NodalCoord(i,1);
    y = NodalCoord(i,2);
    Pexact(i) = exp(-1i*k*(x*dx+y*dy)); % + 1
end
end
