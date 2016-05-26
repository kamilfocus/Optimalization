function dx=rhs_simple(t,x,u)

dx(1) = x(2);
dx(2) = u;

dx = dx';