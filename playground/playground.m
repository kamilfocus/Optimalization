close all; clear all;
addpath('../.');

x0 = [10, -0.5]';
ro = 2;
t = 0:0.001:1;

u_in = u_bang_bang(t, [0.9 t(end)], [], 3);
u_in = u_in(1,:);
[t, x] = rk4(@rhs_simple, u_in, t, x0);
[t, psi] = rk4_b(@rhs_psi_simple, u_in, t, [x(:,length(x)); -ro*x(:,length(x))]);

subplot(3,1,1);
plot(t,x);
title('Stan systemu x'' = -x + u');
subplot(3,1,2);
plot(t,psi(4,:));
hold on;
plot(t, 0, 'r');
title('Funkcja sprzezona');
subplot(3,1,3);
plot(t,u_in);
title('Sterowanie');