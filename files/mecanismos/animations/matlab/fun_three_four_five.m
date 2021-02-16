%Haile Lindsay
%660 Project #2
%3-4-5 Polynomial Program

function [s,v,a,j,theta]=three_four_five(beta,h)
i=1;
dtheta=beta/160;
for theta1=0:dtheta:beta
   s(i)=h*((10*(theta1/beta)^3) - (15*(theta1/beta)^4) + (6*(theta1/beta)^5));
	v(i)=h*(1/(beta))*((30*(theta1/beta)^2)-(60*(theta1/beta)^3) + (30*(theta1/beta)^4));
	a(i)=h*(1/(beta)^2)*((60*(theta1/beta))-(180*(theta1/beta)^2) + (120*(theta1/beta)^3));
   j(i)=h*(1/(beta)^3)*(60-(360*(theta1/beta)) + (240*(theta1/beta)^2));
   i=i+1;
end
theta_1=0:dtheta:beta;
theta=[theta_1];

