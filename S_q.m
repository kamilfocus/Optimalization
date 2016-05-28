function [J, grad] = S_q(tau)

init_globals;

tau = convert_tau(tau);

u_in = u_bang_bang(t, t(tau), [], u0);
u_in = u_in(1,:);

[t, x] = rk4(@rhs_simple, u_in, t, x0);

J = 0.5*(x(:,end)-x_f)'*ro*(x(:,end)-x_f) + q*T;
dJ = ro*(x(:,end)-x_f);

[t, psi] = rk4_b(@rhs_psi_simple, u_in, t, [x(:,length(x)); -dJ]);
psi = psi(3:4, :);
g = rhs_psi_u_simple(t,x, psi);

grad = [];
for i = 1:length(tau)  
    grad = [grad grad_S_q_tau(tau(i), g ,u_in)];
end
    
end