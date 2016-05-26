function dy=rhs_psi_simple(t, x, u)

dx = rhs_simple(t,x(1:2), u);
A = [0 1; 0 0];
dpsi= -A'*x(3:end);

dy = [dx; dpsi];