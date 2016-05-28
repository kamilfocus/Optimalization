function dpsi=crane_rhs_psi(t, x, u)

%global g mi1 mi2
g = 9.81;


%Model suwnicy

mc=1;

mw=2.49;

ms=4.09;

%k1=30.12048192771084;

%k2=11.39817629179331;

%k1=75;

%k2=75;

k1=30.12;

k2=11.39;

k3=75;



mi1=mc/mw;

mi2=mc/(mw+ms);



c5=cos(x(5));

c7=cos(x(7));

s5=sin(x(5));

s7=sin(x(7));



V5=c5*s5*x(8)^2*x(9)-2*x(10)*x(6)+g*c5*c7;

V6=2*x(8)*(c5*x(6)*x(9)+s5*x(10))+g*s7;

V7=s5^2*x(8)^2*x(9)+g*s5*c7+x(6)^2*x(9);



N1=u(1)-k1*x(2);

N2=u(2)-k2*x(4);

%N3=u(3)+k3*x(10)+g;
N3 = 0;


dx = zeros(10, 1);

dx(1)=x(2);

dx(2)=N1+mi1*c5*N3;

dx(3)=x(4);

dx(4)=N2+mi2*s5*s7*N3;

dx(5)=x(6);

dx(6)=(s5*N1-c5*s7*N2+(mi1-mi2*s7^2)*c5*s5*N3+V5)/x(9);

dx(7)=x(8);

dx(8)=-(c7*N2+mi2*s5*c7*s7*N3+V6)/(s5*x(9));

dx(9)= 0;

dx(10)= 0;



A=zeros(10);

A(2,1)=1; A(4,3)=1; A(6,5)=1; A(8,7)=1; A(10,9)=1;

A(2,2)=-k1;

A(2,6)=-k1*s5/x(9);

A(2,10)=k1*c5;

A(4,4)=-k2;

A(4,6)=k2*c5*s7/x(9);

A(4,8)=k2*c7/(s5*x(9));

A(4,10)=k2*s5*s7;

A(5,2)=-mi1*s5*N3;

A(5,4)=mi2*c5*s7*N3;

A(5,6)=(c5*N1+s5*s7*N2+(mi1-mi2*s7^2)*(c5^2-s5^2)*N3-g*s5*c7)/x(9)+(c5^2-s5^2)*x(8)^2;

A(5,8)=((c7*N2+g*s7)*c5/x(9)+2*x(6)*x(8))/s5^2;

A(5,10)=s5*N1-c5*s7*N2+2*c5*s5*((mi1-mi2*s7^2)*N3+x(8)^2*x(9))+g*c5*c7;

A(6,6)=-2*x(10)/x(9);

A(6,8)=-2*x(8)*c5/s5;

A(6,10)=2*x(6)*x(9);

A(7,4)=mi2*s5*c7*N3;

A(7,6)=-c5*(c7*N2+2*mi2*s5*c7*s7*N3+g*s7)/x(9);

A(7,8)=(s7*N2-mi2*s5*N3*(c7^2-s7^2)-g*c7)/(s5*x(9));

A(7,10)=-(c7*N2+2*mi2*s5*s7*c7*N3+g*s7)*s5;

A(8,6)=2*c5*s5*x(8);

A(8,8)=-2*(c5*x(6)/s5+x(10)/x(9));

A(8,10)=2*x(8)*x(9)*s5^2;

A(9,6)=(-s5*N1+c5*s7*N2-(mi1-mi2*s7^2)*c5*s5*N3+2*x(6)*x(10)-g*c5*c7)/x(9)^2;

A(9,8)=(c7*N2+mi2*s5*c7*s7*N3+2*x(8)*s5*x(10)+g*s7)/(s5*x(9)^2);

A(9,10)=(s5*x(8))^2+x(6)^2;

A(10,2)=mi1*k3*c5;

A(10,4)=mi2*k3*s5*s7;

A(10,6)=(k3*(mi1-mi2*s7^2)*c5*s5-2*x(6))/x(9);

A(10,8)=-(mi2*k3*c7*s7+2*x(8))/x(9);

A(10,10)=-k3*(1+mi1*c5^2+mi2*(s5*s7)^2);


dpsi=-A'*x(11:20);
dpsi=[dx; dpsi];
