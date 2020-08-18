function [Pmod, pBound,Hmod, Fmod] = getPmod(length, k, meshSize, H, angle)
%% Verification test
[pBound, boundNodes] = getpBound(length, k, meshSize, angle);
Hmod = H; Fmod = zeros(size(pBound,1),1);
% Set boundary nodes of Hmod and Fmod to 0
for i = 1:size(boundNodes,2) % only rewriting rows/cols of boundary nodes
    Hmod(boundNodes(i),:) = 0; % set row of boundary nodes to 0
    Hmod(:,boundNodes(i)) = 0; % set row of boundary nodes to 0
    Hmod(boundNodes(i),boundNodes(i)) = 1; % set diagonal of boundary nodes to 1
    Fmod(boundNodes(i)) = pBound(boundNodes(i)); % set row of Fmod on boundary nodes to known pressures
end
nodeList = zeros(size(H,1),1);
for i = 1:size(H,1)
    nodeList(i) = i;
end
% Set unknown nodes of Fmod to Hvalues of unknown nodes
unk = setdiff(nodeList,boundNodes); % list of unknown nodes
for i = 1:(size(pBound,1)-size(boundNodes,2)) % only rewriting rows of unknown nodes
    Fmod(unk(i)) = Fmod(unk(i))-H(unk(i),:)*pBound;
end
Fmod = sparse(Fmod); Hmod = sparse(Hmod);
Pmod = Hmod\Fmod;
end
