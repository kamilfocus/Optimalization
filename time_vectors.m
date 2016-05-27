function [ time ] = time_vectors( t, u1, u2 ,MSHDNS)


    bangs=sort([u1 u2]);
    tmp_t0=t(1);

    T=t(end);
    n=length(bangs);
    time=zeros(n+1,MSHDNS)
    if n>0
        tmp_T=bangs(1);
        time(1,:)=linspace(tmp_t0,tmp_T,MSHDNS);
    end
    if n>2
        for i=2:n
         tmp_t0=bangs(i-1); 
         tmp_T=bangs(i); 
         time(i,:)=linspace(tmp_t0,tmp_T,MSHDNS);

        end
    end
    if n>0
        tmp_t0=bangs(n);
    else
        tmp_t0=t(1);
    end
    time(n+1,:)=linspace(tmp_t0,T,MSHDNS);
end

