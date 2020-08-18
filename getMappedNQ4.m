function [Nx, Ny] = getMappedN_Q4(x,y)
    Nx = 1/4*[1-x 1+x 1+x 1-x];
    Ny = 1/4*[1-y 1-y 1+y 1+y];
end
