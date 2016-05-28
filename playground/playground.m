close all; clear all;
addpath('../.');

init_globals;

x0 = [10, -0.5]';
x_f = [0, 0]';
ro = 2;
q = 1;
T = 4;
h = 0.001;
t = 0:h:T;
u0 = 3;

ntau = [];

options = optimoptions('fmincon', 'MaxIter', 10);
options = optimoptions(options, 'GradObj', 'on');
Aeq = [];
beq = [];
nonlcon = [];

max_iter = 3;
for i= 1: max_iter
    
    %generacja sterowania
    u_in = u_bang_bang(t, ntau, [], u0);
    u_in = u_in(1,:);
    
    [t, x] = rk4(@rhs_simple, u_in, t, x0);
    psi_T = -ro*(x(:,length(x)) - x_f);
    [t, psi] = rk4_b(@rhs_psi_simple, u_in, t, [x(:,length(x)); psi_T]);
    psi = psi(3:4, :);
    g = rhs_psi_u_simple(t, x, psi);
    
    plot_data(t,x, g, u_in);
    
    % generacja szpil 
    gamma = find_gamma(convert_tau(ntau), t, x, psi, u_in);
    if(isempty(gamma))
        break;
    end
    
    % sclanie tau~gamma
    gamma = t(gamma);
    [ntau, nu0] = new_tau(ntau, gamma, u0);
    u0 = nu0;
    
    % optymalizacja
    %ograniczenia, ci¹g tau niemalejacy
    tau_len = length(ntau);
    A = -eye(tau_len) + tril(ones(tau_len),-1) - tril(ones(tau_len),-2); % poddiagonalna
    b = zeros(1, tau_len);
    
    % ogarniczenie 0<=tau(i)<=T
    lb = zeros(1, length(ntau));
    ub = T*ones(1, length(ntau));

    ntau = fmincon(@(ntau)S_q(ntau),ntau,A,b,Aeq,beq,lb,ub,nonlcon,options);

end

% final results
u_in = u_bang_bang(t, ntau, [], u0);
u_in = u_in(1,:);

[t, x] = rk4(@rhs_simple, u_in, t, x0);
psi_T = -ro*(x(:,length(x)) - x_f);
[t, psi] = rk4_b(@rhs_psi_simple, u_in, t, [x(:,length(x)); psi_T]);
psi = psi(3:4, :);
g = rhs_psi_u_simple(t, x, psi);
plot_data(t, x, g, u_in);
