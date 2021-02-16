% Randy R Daniels  

% MEEN 660-02

% Project 2

% April 26, 2000

% pj2_cam_subroutine_mod_sine_fun_randy_daniels



%Modified Sinusoidal subroutine function



function [s,v,a,j,theta]=fun_mod_sine(beta,h)


i=1;


dtheta=beta/160;


for theta1=0:dtheta:beta/8


	s(i)=h*(0.43990085*theta1/beta-0.0350062*sin(4*pi*theta1/beta));


	v(i)=0.43990085*h*(1-cos(4*pi*theta1/beta))/beta;


	a(i)=5.5279571*h*sin(4*pi*theta1/beta)/beta^2;


	j(i)=69.4663577*h*cos(4*pi*theta1/beta)/beta^3;


	i=i+1;


end


theta_1=0:dtheta:beta/8;


%------------------------------------------


for theta2=beta/8:dtheta:7*beta/8


   s(i)=h*(0.28004957+0.43990085*(theta2/beta)-0.31505577*cos(4*pi*theta2/(3*beta)-pi/6));


   v(i)=0.43990085*h*(1+3*sin(4*pi*theta2/(3*beta)-pi/6))/beta;


   a(i)=5.5279571*(h*cos(4*pi*theta2/(3*beta)-pi/6))/beta^2;


   j(i)=-23.1553*h*sin(4*pi*theta2/(3*beta)-pi/6)/beta^3;


   i=i+1;


end


theta_2=beta/8:dtheta:7*beta/8;


%------------------------------------------


for theta3=7*beta/8:dtheta:beta


   s(i)=h*(0.56009915+0.43990085*(theta3/beta)-0.0350062*sin(2*pi*(2*theta3/beta-1)));


   v(i)=0.43990085*h*(1-cos(2*pi*(2*theta3/beta-1)))/beta;


   a(i)=5.5279571*(h*sin(2*pi*(2*theta3/beta-1)))/beta^2;


   j(i)=69.4663577*h*cos(2*pi*(2*theta3/beta-1))/beta^3;


	i=i+1;


end


theta_3=7*beta/8:dtheta:beta;


%------------------------------------------



theta=[theta_1,theta_2,theta_3];


