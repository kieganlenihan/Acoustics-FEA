function [Z] = getElementImpedance(nEl)
Zwood = 1.57*10^(6);
Zair = 413;
Znull = 10^(-10);
Z = ones(nEl,1)*Zwood;
% Z(1:sqrt(nEl)) = Zwood;
% Z(1:round(sqrt(nEl)/3)) = Znull;
% Z(2*round(sqrt(nEl)/3):sqrt(nEl)) = Znull;
% for i = 1:round(nEl/3)
%     Z(3*i-1) = 1.57*10^(6); % Make every 3rd element have wood as boundary
% end
end
