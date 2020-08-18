function [] = plotPoissonSolution(nx, ny,NodalCoords, u)
Z(1:ny,1:nx)=0;
X=Z;
Y=Z;
for i=1:ny
    for j=1:nx
        nodeNum = (i-1)*nx + j;
        X(i,j)=NodalCoords(nodeNum,1);
        Y(i,j)=NodalCoords(nodeNum,2);
    Z(i,j)=u(nodeNum);
    end
end
figure
contourf(X,Y,Z);
xlabel('X axis (m)'); ylabel('Y axis (m)')
colorbar
figure
surf(X,Y,Z);
colorbar
xlabel('X axis (m)'); ylabel('Y axis (m)'); zlabel('Acoustic Pressure');
