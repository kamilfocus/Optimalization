function res = grad_S_q_tau(tau, g, u)

if(tau == 1)
    res = g(tau)*u(tau);
else
    res = g(tau) * (u(tau)-u(tau-1));

% init_globals;
% 
% i = i+1;
% tau = [0, tau, length(t)];
% 
% n = 0;
% if(tau(i-1) <= tau(i) && tau(i) < tau(i+1))
%     n = 1;
% end
% 
% if(tau(i-1) < tau(i) && tau(i) == tau(i+1))
%     n = -1;
% end
% 
% res = 2*n*g(tau(i))*(u(tau(i)));

end