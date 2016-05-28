function plot_data(t, x, g, u)
figure
subplot(3,1,1);
plot(t,x);
title('Stan systemu x'''' = u');
subplot(3,1,2);
plot(t,g);
hold on;
plot(t, zeros(1, length(t)), 'r');
title('Funkcja przelaczen');
subplot(3,1,3);
plot(t,u);
title('Sterowanie');

end