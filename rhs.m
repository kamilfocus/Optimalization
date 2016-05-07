function dx=rhs(x,u)
global g

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
N3=u(3)+k3*x(10)+g;

dx(1)=x(2);
dx(2)=N1+mi1*c5*N3;
dx(3)=x(4);
dx(4)=N2+mi2*s5*s7*N3;
dx(5)=x(6);
dx(6)=(s5*N1-c5*s7*N2+(mi1-mi2*s7^2)*c5*s5*N3+V5)/x(9);
dx(7)=x(8);
dx(8)=-(c7*N2+mi2*s5*c7*s7*N3+V6)/(s5*x(9));
dx(9)=x(10);
dx(10)=-c5*N1-s5*s7*N2-(1+mi1*c5^2+mi2*s5^2*s7^2)*N3+V7;