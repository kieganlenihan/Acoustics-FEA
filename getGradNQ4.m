function [N, G] = getGradN_Q4(x,y)
N = 1/4*[(1-x)*(1-y) (1+x)*(1-y) (1+x)*(1+y) (1-x)*(1+y)];
G = 1/4*[-(1-y) 1-y 1+y -(1+y); -(1-x) -(1+x) 1+x 1-x];
end
