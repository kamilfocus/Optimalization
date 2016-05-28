function res = grad_S_q_T(x_T, psi_T, u_T, T, q)

res =  -psi_T'*rhs_simple(T, x_T, u_T) + q;

end