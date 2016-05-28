function [ J ] = quality( q, xT, xf, T )
%QUALITY Computes quality coefficient

J = (xT-xf)'*eye(length(xT))*(xT-xf) + q*T;

end

