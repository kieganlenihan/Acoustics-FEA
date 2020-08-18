function [c, meshSize, length, l, f, w, k, wavelength, wavesInDomain, rho0, beta, X, angle] = initialConditions()
%% Initial Conditions
c = 343; % Speed of sound (m/s) at T = 25 C
meshSize = 100; % Number of elements per side
length = 10; %Total length
l = length/meshSize; % Elemental length
k = sqrt(3); %.15
% Bad [1.976129928793171 2.470137958845563]
% Good [2.25 2.55]
w = k*c;    % hz
f = w/(2*pi); % rad/s
wavelength = c/f;
wavesInDomain = length/wavelength;
rho0 = 1.255; % Density of air (kg/m^3) at T = 25 C
beta = rho0*c^2; % Bulk modulus of air
X = [-1/sqrt(3) 1/sqrt(3)];
angle = 45; % degrees
display(['elementsPerWave = ' num2str(wavelength/l,'%0.3f')])
end
