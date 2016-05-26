clear all;
close all;

ro = 2;
u0 = 20;

x0 = [0, 0.5, 0, 0.5, 0.25*pi,-0.5,0.25*pi,-0.5,1,0]';
t = 0:0.001:0.25;
u = u_bang_bang(t, [], [], u0);
[t, x] = rk4(@crane_rhs, u, t, x0);
[~, psi] = rk4_b(@rhs_psi, u, t, -ro*x(:,length(x)));
g = rhs_psi_u(t, x, psi);


subplot(3,1,1);
plot(t, x([1 3 5 7],:));
title('Stan systemu crane rhs');
subplot(3,1,2);
plot(t, g(1,:));
hold on;
plot(t, u(1,:), 'r');
title('Funkcja g_1(t) oraz u_1(t)');
subplot(3,1,3);
plot(t, g(2,:));
hold on;
plot(t, u(2,:), 'r');
title('Funkcja g_2(t) oraz u_2(t)');
