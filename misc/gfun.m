function [ g ] = gfun( phi, x, rhs1 )
%GFUN g(t) function as in CACSD00

phis = size(phi);
g = zeros(phis);
for it = 1:phis(2)
    g(:,it) = phi(:,it)'*rhs1(x(:,it));
end

end

