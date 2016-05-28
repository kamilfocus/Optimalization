function res = grad_S_q_tau(tau, g, u)

res = g(tau) * (u(tau)-u(tau-1));

end