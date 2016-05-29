function retval = u(t, sw1)
  
  retval = zeros(1, length(t));

  for it=1:2:length(sw1)-1
    vect = t>=sw1(it) & t < sw1(it+1);
    retval(1,:) = retval(1,:) + vect;
  end
  
end