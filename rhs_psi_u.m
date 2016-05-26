function g=rhs_psi_u(t, x, psi)

%System postaci: x' = f(x,u) = f_0(x) + f_1(x)*u
f1_u1 = zeros(10, length(t)); %Sk³adowa f_1 od sterowania u1 -> Pochodna z f(x,u) po u1
f1_u2 = zeros(10, length(t)); %Sk³adowa f_1 od sterowania u2 -> Pochodna z f(x,u) po u2

g_u1 = zeros(1, length(t));
g_u2 = zeros(1, length(t));

for i=1:length(t)
    %Inicjalizuj f1
    f1_u1(2, i) = 1;
    f1_u1(6, i) = sin(x(5, i))/x(9, i);
    
    %Inicjalizuj f2
    f1_u2(4, i) = 1;
    f1_u2(6, i) = -cos(x(5,i))*sin(x(7, i))/x(9, i);
    f1_u2(8, i) = -cos(x(7,i))/(sin(x(5, i))*x(9, i));
    
    g_u1(i) = psi(:,i)'*f1_u1(:,i);
    g_u2(i) = psi(:,i)'*f1_u2(:,i);
end

g=[g_u1;g_u2];