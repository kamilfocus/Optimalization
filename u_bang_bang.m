function retval = u_bang_bang(t, sw1, sw2, A)
    
    if(mod(length(sw1), 2) == 1)
        sw1 = [sw1 t(end)];
    end
    
    if(mod(length(sw2), 2) == 1)
        sw2 = [sw2 t(end)];
    end

    u_in = u(t, sw1, sw2);
    temp = -2*A*u_in;
    retval = temp + A;
    
end
    