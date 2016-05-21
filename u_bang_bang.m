function retval = u_bang_bang(t, sw1, sw2, sw3, A)
    u_in = u(t, sw1, sw2, sw3);
    u_in = A*u_in;
    dim = size(u_in);
    for i=1:dim(1)
        for j=1:dim(2)
            if u_in(i,j) == 0
                u_in(i,j) = -A;
            end
        end
    end
    retval = u_in;
    