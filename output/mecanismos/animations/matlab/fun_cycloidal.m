%Cycloidal function

function [s,v,a,j,theta]=fun_cycloidal(beta,h)
dtheta=beta/160;
i=1;
for theta=0:dtheta:beta
	s(i)=h*(theta/beta-sin(2*pi*theta/beta)/2/pi);
	v(i)=h*(1-cos(2*pi*theta/beta))/beta;
	a(i)=2*pi*h*sin(2*pi*theta/beta)/beta^2;
	j(i)=4*pi^2*h*cos(2*pi*theta/beta)/beta^3;
   i=i+1;
end
theta=0:dtheta:beta;