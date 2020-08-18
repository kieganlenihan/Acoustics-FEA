function [err, l] = Verification(noTests)
global NodalCoord
global L
[~, ~, length, ~, f, ~, k, ~, ~, ~, ~, X, angle] = initialConditions();
err = zeros(noTests,1); meshSize = round(logspace(1,2,noTests)); l = err;
dx = cos(angle*pi/180);
dy = sin(angle*pi/180);
%% Verification
for q = 1:noTests
    l(q) = length/meshSize(q); % Elemental length
    [Kg, Mg, ~] = getStiffnessMassMatQ4(meshSize(q),length, X);
    HnoZ = Kg-k^2*Mg; % Verification test involves no boundary impedance
    [Pmod, ~] = getPmod(length, k, meshSize(q), HnoZ, angle);
    for n =1:meshSize(q)^2
        Nodes = L(n,:);
        C = NodalCoord(Nodes,:);
        for i = 1:2
            for j = 1:2
            x = X(i);
            y = X(j);
            [Nx, Ny] = getMappedN_Q4(x,y);
            x = Nx*C(:,1);
            y = Ny*C(:,2);
            pPlane = exp(-1i*k*(x*dx+y*dy)); % plane wave pressure at integration point
            [N, ~] = getGradN_Q4(X(i),X(j));
            pInterp = N*Pmod(Nodes); % interp pressure
            err(q) = err(q) + (real(pPlane-pInterp))^2;
            end
        end
    end
err(q) = real(err(q));
plotPoissonSolution(meshSize(q)+1, meshSize(q)+1,NodalCoord,real(Pmod))
end
end
