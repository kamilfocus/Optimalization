function retval = u(t, sw1, sw2)
  
  retval = zeros(2, length(t));

  for it=1:2:length(sw1)-1
    vect = t>=sw1(it) & t <= sw1(it+1);
    retval(1,:) = retval(1,:) + vect;
  end
  
  for it=1:2:length(sw2)-1
    vect = t>=sw2(it) & t <= sw2(it+1);
    retval(2,:) = retval(2,:) + vect;
  end

end