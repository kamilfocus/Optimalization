function dpsi=crane_rhs_psi(t, x, u)


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




A=zeros(8);

A(1,2) = 1;

A(2,2) = -k1;

A(3,4) = 1;

A(4,4) = -k2;

A(5,6) = 1;

A(6,2) = -(s5*k1)/R;
A(6,4) = (c5*s7*k2)/R;
A(6,5) = (c5*N1 + s5*s7*N2 + (c5*c5 - s5*s5)*x(8)*x(8)*R - s5*g*c7)/R;
A(6,7) = (-c5*c7*N2 - g*c5*s7)/R;
A(6,8) = 2*x(8)*c5*s5;

A(7,8) = 1;

A(8,4) = (c7*k2)/(s5*R);
A(8,5) = ( (c5*(c7*N2+g*s7)/R) + 2*x(8)*x(6) ) / (s5*s5);
A(8,6) = -(2*x(8)*c5)/s5;
A(8,7) = (s7*N2 - c7*g)/(s5*R);
A(8,8) = (-2*x(6)*c5)/s5;

%A'

dpsi=-A'*x(9:16);
dpsi=[dx; dpsi];
