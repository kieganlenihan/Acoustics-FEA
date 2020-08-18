%% ACOUSTICS 2D Code (kl252)
close all; clear
global NodalCoord
global Pexact
%% Initial Conditions
[c, meshSize, length, ~, f, w, k, wavelength, wavesInDomain, rho0, beta, X, angle] = initialConditions();
% Governing Matrices
[Kg, Mg, Bg] = getStiffnessMassMatQ4(meshSize,length, X);
P = zeros(size(Kg,1),1);
F = P;
H = (Kg-k^2*Mg+1i*w*Bg);
F(1) = 10; % Force Input
%% Solve Equations
F = sparse(F);
P = H\F;
plotPoissonSolution(meshSize+1, meshSize+1,NodalCoord,real(P))
%% Plane Wave Plot
Pexact = getPexact(meshSize, angle,k);
plotPoissonSolution(meshSize+1, meshSize+1,NodalCoord,real(Pexact))
%% Boundary Pressure Plot
[pBound, ~] = getpBound(length, k, meshSize, angle);
plotPoissonSolution(meshSize+1, meshSize+1,NodalCoord,real(pBound))
%% Test of Plane Wave Plot
[Pmod, ~, Hmod, Fmod] = getPmod(length, k, meshSize, H, angle);
plotPoissonSolution(meshSize+1, meshSize+1,NodalCoord,real(Pmod))
%% Verification
noTest = 15; % Number of error tests
[err , l] = Verification(noTest);
l = log(l); err = log(err);
figure(100)
plot(l,err,'rx'); xlabel('logarithmic elemental length'); ylabel('Logarithmic error');
coeffs = polyfit(l, err,1);
xFit = min(l):.5:max(l); yFit = polyval(coeffs, xFit);
hold on
grid on
plot(xFit, yFit,'k-');
xBest = min(l)+1/6*(max(l)-min(l));
yBest = min(err)+3/4*(max(err)-min(err));
text(xBest,yBest,['y = ' num2str(coeffs(1),'%04f') 'x +' num2str(coeffs(2),'%04f')], 'FontSize', 14)
