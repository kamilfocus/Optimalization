function [ time, u_v1,u_v2 ] = time_vectors( t, u1, u2, u0 ,MSHDNS)


    bangs=sort([u1 u2]);
    bangs=unique(bangs);
    tmp_t0=t(1);
    u1_tmp=u0;
    u1_tmp=u0;

    T=t(end);
    n=length(bangs(bangs~=0));
    
    time=zeros(n+1,MSHDNS);
    u_v1=ones(n+1,MSHDNS)*u0;
    u_v2=ones(n+1,MSHDNS)*u0;
    
   %% Przelaczenie w zerze
     if any(u1==0)
            u_v1(1,:)=-u_v1(1,:);
     end
    if any(u2==0)
            u_v2(1,:)=-u_v2(1,:);
    end
    %%%%%%%%%%%%%%%%%%%%%
    bangs=bangs(bangs~=0);
    if n>0  %% czas do 1 prze³¹czenia
            tmp_T=bangs(1);
            time(1,:)=linspace(tmp_t0,tmp_T,MSHDNS);
    end
    % od 1 prze³¹czenia do ostatniego prze³¹czenia
    if n>=2
        for i=2:n
             tmp_t0=bangs(i-1); 
             tmp_T=bangs(i); 
             time(i,:)=linspace(tmp_t0,tmp_T,MSHDNS);
             
             if any(tmp_t0==u1)
                u_v1(i,:)=-u_v1(i-1,:);
             else
                 u_v1(i,:)=u_v1(i-1,:);
            end
             if any(tmp_t0==u2)
                u_v2(i,:)=-u_v2(i-1,:);
             else
                 u_v2(i,:)=u_v2(i-1,:);
            end

        end
    end
    %% od ostatniego prze³¹czenia do koñca/lub od poczatku do konca przy braku przelaczen
    if n>0
        tmp_t0=bangs(n);
        if any(tmp_t0==u1)
            u_v1(n+1,:)=-u_v1(n,:);
        else
            u_v1(n+1,:)=u_v1(n,:);
        end
         if any(tmp_t0==u2)
            u_v2(n+1,:)=-u_v2(n,:);
         else
             u_v2(n+1,:)=u_v2(n,:);
        end
    else
        tmp_t0=t(1);
       
    end
    time(n+1,:)=linspace(tmp_t0,T,MSHDNS);
    
end

