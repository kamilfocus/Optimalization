function res = grad_S_q_tau(i, tau, g, u, T_size)

% tau = tau(i);
% if(tau == 1)
%     res = 2*g(tau)*u(tau);
% else
%     res = g(tau) * (u(tau)-u(tau-1));

i = i+1;
tau = [0, tau, T_size];

n = 0;
if(tau(i-1) <= tau(i) && tau(i) < tau(i+1))
    n = 1;
end

if(tau(i-1) < tau(i) && tau(i) == tau(i+1))
    n = -1;
end

if(tau(i-1) == tau(i) && tau(i) == tau(i+1))
    disp('grad not defined');
end

res = 2*n*g(tau(i))*(u(tau(i)));

end