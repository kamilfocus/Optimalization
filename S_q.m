function [J, grad] = S_q(tau, tau1_len, tau2_len)

init_globals;
tau1 = convert_tau(tau(1:tau1_len));
tau2 = convert_tau(tau(tau1_len+1:tau1_len+tau2_len));
tau = [tau1 tau2];

u_in = u_bang_bang(t, tau1, u0(1));
u_in = [u_in; u_bang_bang(t, tau2, u0(2))];

[t, x] = rk4(fun_rhs, u_in, t, x0);

J = 0.5*(x(:,end)-x_f)'*ro*(x(:,end)-x_f) + q*T;
dJ = ro*(x(:,end)-x_f);

[t, psi] = rk4_b(fun_rhs_psi, u_in, t, [x(:,length(x)); -dJ]);
psi = psi(11:20, :);
g = fun_rhs_psi_u(t,x, psi);

grad = zeros(1, length(tau));
for i = 1:tau1_len  
    %grad = [grad grad_S_q_tau(tau(i), g ,u_in)];
    grad(i) = grad_S_q_tau(tau(i), g(1,:) ,u_in(1,:));
end

for i = tau1_len+1:tau1_len+tau2_len
    grad(i) = grad_S_q_tau(tau(i), g(2,:) ,u_in(2,:));
end
[J, grad];
end