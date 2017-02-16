%Simple Harmonic function

function [s,v,a,j,theta]=fun_harmonic(beta,h)
dtheta=beta/160;
i=1;
for theta=0:dtheta:beta
	s(i)=h*(1-cos(pi*theta/beta))/2;
	v(i)=pi*h*sin(pi*theta/beta)/beta/2;
	a(i)=pi^2*h*cos(pi*theta/beta)/beta^2/2;
	j(i)=-pi^3*h*sin(pi*theta/beta)/beta^3/2;
   i=i+1;
end
theta=0:dtheta:beta;