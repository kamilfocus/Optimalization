function retval = u_bang_bang(t, sw1, A)
    
    if(mod(length(sw1), 2) == 1)
        sw1 = [sw1 t(end)];
    end
    
    u_in = u(t, sw1);
    temp = -2*A*u_in;
    retval = temp + A;
    
end
    