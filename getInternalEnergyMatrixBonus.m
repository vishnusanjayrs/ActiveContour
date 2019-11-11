function [Ainv] = getInternalEnergyMatrixBonus(nPoints, alpha, beta, gamma)
% 
% nPoints = 10
% alpha = 0.4 
% beta = 0.2 
% gamma = 0.5

A_core = [beta ,-(alpha + 4*beta),(2*alpha + 6 *beta),-(alpha + 4*beta),beta ];
% A_core = [beta ,(alpha - 4*beta),(-2*alpha + 6 *beta),(alpha - 4*beta),beta ];
pad_size = nPoints - 5;
A_row = [A_core zeros(1,pad_size)];
A_row = circshift(A_row,[1,-2]);
A = A_row;

for i = 2:nPoints
    A_row = circshift(A_row,[1,1]);
    A(i,:) = A_row ;
end

Ainv=inv(A + gamma.* eye(nPoints));
end

