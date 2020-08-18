function [Be] = getImpedanceMatQ4(C,N,l,length)
Be = zeros(4,4);
x = ismember(C,[0 length]);
    if sum(x(:)) > 0 % element in on boundary
            Jbound = 1/2*(l);
            Be = Be + N'*N*det(Jbound); % Compute impedance matrix
    else
        Be = zeros(4,4); % Be is 0 if not on boundary
    end
end
