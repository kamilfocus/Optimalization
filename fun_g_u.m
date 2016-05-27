function [ g_u ] = fun_g_u( g,u,u_max)
% wzor (5) z VARIABLE CONTROL PARAMETERIZATION FOR TIME-OPTIMAL PROBLEMS1
g_u=zeros(size(g));
for i=1:length(g)
    if(u(1,i)*sign(g(1,i))~=u_max)
        g_u(1,i)=g(1,i);
    end
    if(u(2,i)*sign(g(2,i))~=u_max)
        g_u(2,i)=g(2,i);
    end
    
end
    
end

