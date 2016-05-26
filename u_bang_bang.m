function retval = u_bang_bang(t, sw1, sw2, A)
    u_in = u(t, sw1, sw2);
    temp = 2*A*u_in;
    retval = temp - A;
    