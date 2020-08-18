%% ACOUSTICS 2D Code (kl252)
function [Kg, Mg, Bg] = getStiffnessMassMatQ4(meshSize,length, X)
global NodalCoord
global L
% Q4 Elements
n = 2; % Number of integration points
nNoEl = 4;  % 4 Nodes in a Q4 Element
nEl = meshSize^2; % Number of elements
nNodes = (meshSize+1)^2; % Number of global nodes
nDof = nNodes; % Number of global dofs
l = length/meshSize; % elemental length
w = [1 1]; % Integration weights
Z = getElementImpedance(nEl); % Get impedance of each elemental boundary
%% Determine Globabl Stiffness/Mass Matrix
[NodalCoord, L] = getMesh(length, length, meshSize,meshSize);
Kg = zeros(nDof);
Mg = Kg;
Bg = Mg;
for m = 1:nEl
    Nodes = L(m,:);
    C = NodalCoord(Nodes,:);
%% Compute Ke, Me for each element
Ke = zeros(nNoEl,nNoEl);
Me = Ke;
    for i = 1:n
        for j = 1:n
            x=X(i); % Set integration points
            y=X(j);
            [N, G] = getGradN_Q4(x,y);
            J = G*C;
            B = J\G;
            Ke = Ke + B'*B*det(J)*w(i)*w(j); % Compute Stiffness matrix
            Me = Me + N'*N*det(J)*w(i)*w(j); % Compute Mass matrix
            Be = 1/Z(m)*getImpedanceMatQ4(C,N,l,length);
        end
    end
Kg(Nodes,Nodes) = Kg(Nodes,Nodes)+Ke;
Mg(Nodes,Nodes) = Mg(Nodes,Nodes)+Me;
Bg(Nodes,Nodes) = Bg(Nodes,Nodes)+Be;
end
Kg=sparse(Kg);
Mg=sparse(Mg);
Bg=sparse(Bg);
end
