close all
clear all

addpath('./playground');

init_globals;

fun_rhs = @crane_rhs;
fun_rhs_psi = @crane_rhs_psi;
fun_rhs_psi_u = @rhs_psi_u;

x0 = [0, 0.5, 0, 0.5, 0.25*pi,-0.5,0.25*pi,-0.5,1,0]';
x_f = [1, 0, 1, 0, 0.5*pi, 0, 0, 0, 1, 0]';
%x_f = zeros(10, 1);
%x_f(9) = 1;

ro = 2;
q = 1;

T = 0.25;
h = 0.001;
t = 0:h:T;
u0 = [1, 2];

ntau1 = [];
ntau2 = [];

options = optimoptions('fmincon', 'MaxIter', 10);
options = optimoptions(options, 'GradObj', 'on', 'Algorithm', 'interior-point');
Aeq = [];
beq = [];
nonlcon = [];

max_iter = 3;
for i= 1: max_iter
    
    %generacja sterowania
    u_in = u_bang_bang(t, ntau1, u0(1));
    u_in = [u_in; u_bang_bang(t, ntau2, u0(2))];
    
    [t, x] = rk4(fun_rhs, u_in, t, x0);
    psi_T = -ro*(x(:,length(x)) - x_f);
    [t, psi] = rk4_b(fun_rhs_psi, u_in, t, [x(:,length(x)); psi_T]);
    psi = psi(11:20, :);
    g = fun_rhs_psi_u(t, x, psi);
   
    plot_data(t,x, g, u_in);
    
    % generacja szpil 
    gamma1 = find_gamma(convert_tau(ntau1), length(t), g(1,:), u_in(1,:));
    gamma2 = find_gamma(convert_tau(ntau2), length(t), g(2,:), u_in(2,:));
    
    if(isempty(gamma1) && isempty(gamma2))
        break;
    end
    
    % sclanie tau~gamma
    if(~isempty(gamma1))
        gamma1 = t(gamma1);
        [ntau1, u0(1)] = new_tau(ntau1, gamma1, u0(1));
    end
    
    if(~isempty(gamma2))
        gamma2 = t(gamma2);
        [ntau2, u0(2)] = new_tau(ntau2, gamma2, u0(2));
    end
    
    % optymalizacja
    %ograniczenia, ci¹g tau niemalejacy
    tau_len1 = length(ntau1);
    tau_len2 = length(ntau2);
    
    ntau = [ntau1 ntau2];
    tau_len = length(ntau);
    A = -eye(tau_len) + tril(ones(tau_len),-1) - tril(ones(tau_len),-2); % poddiagonalna
    b = zeros(1, tau_len);
    A(tau_len1+1, tau_len1) = 0;
    
    % ogarniczenie 0<=tau(i)<=T
    lb = zeros(1, length(ntau));
    ub = T*ones(1, length(ntau));

    ntau = fmincon(@(ntau)S_q(ntau, tau_len1, tau_len2),ntau,A,b,Aeq,beq,lb,ub,nonlcon,options);
    
    ntau1 = ntau(1:tau_len1);
    ntau1 = sort(ntau1);
    
    ntau2 = ntau(tau_len1+1 : end);
    ntau2 = sort(ntau2);

end

%final results
u_in = u_bang_bang(t, ntau1, u0(1));
u_in = [u_in; u_bang_bang(t, ntau2, u0(2))];

[t, x] = rk4(fun_rhs, u_in, t, x0);
psi_T = -ro*(x(:,length(x)) - x_f);
[t, psi] = rk4_b(fun_rhs_psi, u_in, t, [x(:,length(x)); psi_T]);
psi = psi(11:20, :);
g = fun_rhs_psi_u(t, x, psi);
plot_data(t, x, g, u_in);
