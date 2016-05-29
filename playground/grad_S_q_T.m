function res = grad_S_q_T(x_T, psi_T, u_T, T, q)

global fun_rhs;

res =  -psi_T'*fun_rhs(T, x_T, u_T) + q;

end