function gamma = find_gamma(tau, T_size, g, u)

%global fun_rhs_psi_u;

%g = fun_rhs_psi_u(t,x,psi);

tau = [tau T_size];

flag = 0;
minimum = [];
current_tau = 0;
gamma = [];

for i = 1:T_size
   g_u = g(i)*u(i);
   
   if( sign(g_u) < 0 && flag == 0 )
       flag = 1;
       minimum = i;
       min_G = g_u;
       continue;
   end
   
   if(flag == 1 && g_u < min_G)
       minimum = i;
       min_G = g_u;
   end
   
   if( i == tau(current_tau + 1) )
       current_tau = current_tau+1;
       if(flag == 1)
            flag = 0;
            if(minimum == 1 || minimum == T_size)
                gamma = [gamma, minimum];
            else
                gamma = [gamma, minimum, minimum];
            end
      
       end
   end
  
end

%gamma = sort(gamma);
  
end
