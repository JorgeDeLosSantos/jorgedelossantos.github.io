%Haile Lindsay
%660 Project #2
%4-5-6-7 Polynomial Program

function [s,v,a,j,theta]=fun_four_five_six_seven(beta,h)
i=1;
dtheta=beta/160;
for theta1=0:dtheta:beta
   s(i)=h*((35*(theta1/beta)^4) - (84*(theta1/beta)^5) + (70*(theta1/beta)^6) - (20*(theta1/beta)^7));
	v(i)=h*(1/beta)*((140*(theta1/beta)^3)-(420*(theta1/beta)^4) + (420*(theta1/beta)^5) - (140*(theta1/beta)^6));
	a(i)=h*(1/beta^2)*((420*(theta1/beta)^2)-(1680*(theta1/beta)^3) + (2100*(theta1/beta)^4) - (840*(theta1/beta)^5));
   j(i)=h*(1/beta^3)*((840*(theta1/beta))-(5040*(theta1/beta)^2) + (8400*(theta1/beta)^3) - (4200*(theta1/beta)^4));
   i=i+1;
end
theta_1=0:dtheta:beta;
theta=[theta_1];

