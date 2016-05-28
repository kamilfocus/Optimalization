function [ h ] = hcoef( q, phiT, xT, rhs0 )
%HCOEF h coefficient as in CACSD00

h = q - phiT'*rhs0(xT);

end

