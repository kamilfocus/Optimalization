close all; clear all;
addpath('../.');

B = [0;1];
x0 = [1;1];
ti = 0:0.01:10;
up = -ones(size(ti));
[to,xo] = rk4(@rhs, up, ti, x0);
[tp,psi] = rk4_b(@rhsp, up, ti, -2*xo(:,end));
figure
plot(to,xo)
figure
plot(tp,psi)
up = ((psi(2,:) > 0)*2 - 1);
[to,xo] = rk4(@rhs, up, ti, x0);
[tp,psi] = rk4_b(@rhsp, up, ti, -2*xo(:,end));
figure
plot(to,xo)
figure
plot(tp,psi)
