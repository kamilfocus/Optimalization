function g=rhs_psi_u_simple(t, x, psi)

f1_u1 = zeros(2, length(t));
g_u1 = zeros(1, length(t));

for i=1:length(t)
    %Inicjalizuj f1
    f1_u1(2, i) = 1;
    
    g_u1(i) = psi(:,i)'*f1_u1(:,i);
end

g = g_u1;