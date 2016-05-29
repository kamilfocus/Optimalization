function [J, grad] = S_q_simple(tau)

init_globals;
%tau

horizon = tau(end);
tau = tau(1:end-1);

tau = sort(tau);
tau = convert_tau(tau);

u_in = u_bang_bang(t, t(tau), u0);
u_in = u_in(1,:);

[t, x] = rk4(fun_rhs, u_in, t, x0);

J = 0.5*(x(:,end)-x_f)'*ro*(x(:,end)-x_f) + q*T;
dJ = ro*(x(:,end)-x_f);

[t, psi] = rk4_b(fun_rhs_psi, u_in, t, [x(:,length(x)); -dJ]);
psi = psi(3:4, :);
g = fun_rhs_psi_u(t,x, psi);

grad = zeros(1, length(tau)+1);
for i = 1:length(tau)  
    %grad = [grad grad_S_q_tau(tau(i), g ,u_in)];
    grad(i) = grad_S_q_tau(i, tau, g ,u_in, length(t));
end
    grad(end) = grad_S_q_T(x(:,end),-dJ, u_in(end), horizon, q);
%[J, grad]
end