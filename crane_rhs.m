function dx=crane_rhs(t, x, u)

g = 9.81;
R = 10; 

%Model suwnicy


k1=30.12;

k2=11.39;


c5=cos(x(5));

c7=cos(x(7));

s5=sin(x(5));

s7=sin(x(7));



V5=c5*s5*x(8)^2*R+g*c5*c7;

V6=2*x(8)*c5*x(6)*R+g*s7;



N1=u(1)-k1*x(2);

N2=u(2)-k2*x(4);


dx = zeros(8, 1);

dx(1)=x(2);

dx(2)=N1;

dx(3)=x(4);

dx(4)=N2;

dx(5)=x(6);

dx(6)=(s5*N1-c5*s7*N2+V5)/R;

dx(7)=x(8);

dx(8)=-(c7*N2+V6)/(s5*R);

end