function [ntau nu0] = new_tau(tau, gamma, u0)

ntau = [tau, gamma];
ntau = sort(ntau);

nu0 = u0;

cnt = 0;
for i=1:length(ntau)
    if(ntau(i) == 0)
        cnt = cnt + 1;
    else
        break;
    end
end

if( mod(cnt, 2) == 1)
    nu0 = -u0;

end