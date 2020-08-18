function [pBound, boundNodes] = getpBound(length, k, meshSize, angle)
global NodalCoord
nElx = meshSize+1; % Number of elements in each direction
%% Determine Global Stiffness/Mass Matrix
% Find nodes on boundary
boundNodes = zeros(1, 4*meshSize);
Nodes = flip(getNodes(meshSize));
for i = 1:nElx
    boundNodes(i) = Nodes(1,i);
    boundNodes(nElx+i) = Nodes(nElx, i);
end
for i = 1:nElx-2
    boundNodes(2*nElx+i) = Nodes(1+i,1);
    boundNodes(3*meshSize+1+i) = Nodes(1+i,end);
end
% get vector of essential pressure vectors
p = zeros(nElx^2,1);
for i = 1:size(boundNodes,2)
    x = NodalCoord(boundNodes(i),1);
    y = NodalCoord(boundNodes(i),2);
    dx = cos(angle*pi/180);
    dy = sin(angle*pi/180);
    p(boundNodes(i)) = exp(-1i*k*(x*dx+y*dy));
end
pBound = p;
end
