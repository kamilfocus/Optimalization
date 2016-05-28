function ntau = convert_tau(tau)

global t;
if(isempty(tau))
    ntau = [];
    return;
end

ntau = zeros(1, length(tau));

j = 1;
for i=2:length(t)
    if(tau(j) >= t(i-1) && tau(j) <= t(i))
        if(abs(tau(j) - t(i-1)) < abs(tau(j) - t(i)) )
            ntau(j) = i-1;
        else
            ntau(j) = i;
        end
        
        j = j + 1;
    end
    if(j > length(tau))
        break;
    end
    
    if(i == length(t))
        disp('there is no index for given time');
    end
    
end



end