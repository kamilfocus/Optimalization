clear all
close all

ro = 1;
rhs1 = @(t, x, u) (-x + u);
rhs_psi1 = @(t,x,u) (x);

ti = 0:0.001:0.4;
ui= u(ti, [0 0.3 0.6 0.9], [0.5 0.8], [0.25 0.5 0.75 1]);
ui = ui(1,:);
ui = 2*ui -1;

ui = -ones(size(ti));

[to1 yo1] = rk4(rhs1, ui, ti, 1);
[to2 yo2] = rk4_b(rhs_psi1, ui, ti, -ro*yo1(length(yo1)));
%plot(to1, yo1, to2, yo2+0.01)
plot(to1, yo1);
figure(2);
plot(to2, yo2);
figure(3);
plot(ti, ui);