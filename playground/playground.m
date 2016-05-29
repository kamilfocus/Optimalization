close all; clear all;
addpath('../.');

init_globals;

fun_rhs = @rhs_simple;
fun_rhs_psi = @rhs_psi_simple;
fun_rhs_psi_u = @rhs_psi_u_simple;

x0 = [10, -0.5]';
x_f = [0, 0]';
ro = 2;
q = 0.5;
T = 4;
h = 0.001;
%t = 0:h:T;
u0 = 3;

ntau = [];

options = optimoptions('fmincon', 'MaxIter', 10);
options = optimoptions(options, 'GradObj', 'on', 'Algorithm', 'interior-point');
Aeq = [];
beq = [];
nonlcon = [];

max_iter = 10;
for i= 1: max_iter
    
    t = 0:h:T;
    
    %generacja sterowania
    u_in = u_bang_bang(t, ntau, u0);
    
    [t, x] = rk4(fun_rhs, u_in, t, x0);
    psi_T = -ro*(x(:,length(x)) - x_f);
    [t, psi] = rk4_b(fun_rhs_psi, u_in, t, [x(:,length(x)); psi_T]);
    psi = psi(3:4, :);
    g = fun_rhs_psi_u(t, x, psi);
    
    plot_data(t,x, g, u_in);
    
    % generacja szpil 
    gamma = find_gamma(convert_tau(ntau), length(t), g, u_in);
    if(isempty(gamma))
        break;
    end
    
    % sclanie tau~gamma
    gamma = t(gamma);
    [ntau, u0] = new_tau(ntau, gamma, u0);
    
    % optymalizacja
    %ograniczenia, ci¹g tau niemalejacy
    ntau = [ntau, T];
    tau_len = length(ntau);
    A = -eye(tau_len) + tril(ones(tau_len),-1) - tril(ones(tau_len),-2); % poddiagonalna
    b = zeros(1, tau_len);
    
    % ogarniczenie 0<=tau(i)<=T
    lb = zeros(1, length(ntau));
    ub = T*ones(1, length(ntau));
    
    ntau = fmincon(@(ntau)S_q_simple(ntau),ntau,A,b,Aeq,beq,lb,ub,nonlcon,options);
    T = ntau(end);
    ntau = ntau(1:end-1);
    
    ntau = sort(ntau);
    ntau = reductor(ntau);
    
end

% final results
u_in = u_bang_bang(t, ntau, u0);
u_in = u_in(1,:);

[t, x] = rk4(@rhs_simple, u_in, t, x0);
psi_T = -ro*(x(:,length(x)) - x_f);
[t, psi] = rk4_b(fun_rhs_psi, u_in, t, [x(:,length(x)); psi_T]);
psi = psi(3:4, :);
g = fun_rhs_psi_u(t, x, psi);
plot_data(t, x, g, u_in);
