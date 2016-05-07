clear all;
close all;

ro = 2;

x0 = [0, 0.5, 0, 0.5, 0.25*pi,-0.5,0.25*pi,-0.5,1,0]';
t = 0:0.001:0.25;
u_temp_2 = [sin(t);sin(t);sin(t)];
%u_temp_2 = u(t, [0 0.3 0.6 0.9], [0.5 0.8], [0.25 0.5 0.75 1]);
[t, y] = rk4(@crane_rhs, u_temp_2, t, x0);
%[t2, y2] = rk4(@crane_rhs, fliplr(u_temp_2), fliplr(t), y(:,length(y)));
[t2, y2] = rk4_b(@rhs_psi, u_temp_2, t, -ro*y(:,length(y)));
% for i=1:3
%     subplot(3, 1, i)
%     plot(t, u_temp_2(i,:));
% end

%figure(2);
% w2 = 1:30;
% w  = (length(t)-length(w2)):length(t);
% t = t(w);
% t2 = t2(w2);
hold on;
plot(t, y([1 3 5 7],:));
figure(2);
plot(t2, y2([1 3 5 7],:));
%figure(2);
%plot(t2, y2([1 3 5 7 9],w2));