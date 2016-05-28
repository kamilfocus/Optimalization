function [ G ] = Gfun( u, phi, x, rhs1 )
%GFUN G(t) function as in CACSD00

G = u.*gfun(phi, x, rhs1);

end

