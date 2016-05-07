function [to xo] = rk4_b(rhs, u, t, x0)
	xs = size(x0);
	xo = zeros(xs(1), length(t));
	xp = x0;
	xo(:,length(t)) = x0;
	to = t;
	for it = length(t):-1:2
		dt = -t(it) + t(it - 1);
		dt2 = dt/2;
		k1 = rhs(t(it), xp, u(:,it));
		k2 = rhs(t(it) + dt2, xp + dt2*k1,  u(:,it));
		k3 = rhs(t(it) + dt2, xp + dt2*k2,  u(:,it));
		k4 = rhs(t(it) + dt, xp + dt*k3,  u(:,it));
		xo(:,it-1) = xp + (dt/6)*(k1 + 2*k2 + 2*k3 + k4);
		xp = xo(:,it-1);
	end