%Modified trapozoidal function

function [s,v,a,j,theta]=fun_mod_trap(beta,h)
i=1;
dtheta=beta/160;
for theta1=0:dtheta:beta/8
	s(i)=h*(0.38898448*theta1/beta-0.0309544*sin(4*pi*theta1/beta));
	v(i)=0.38898448*h*(1-cos(4*pi*theta1/beta))/beta;
	a(i)=4.888124*h*sin(4*pi*theta1/beta)/beta^2;
	j(i)=61.425769*h*cos(4*pi*theta1/beta)/beta^3;
	i=i+1;
end
theta_1=0:dtheta:beta/8;
%------------------------------------------
for theta2=beta/8:dtheta:3*beta/8
   s(i)=h*(2.44406184*(theta2/beta).^2-0.22203097*(theta2/beta)+0.00723407);
   v(i)=h*(4.888124*(theta2/beta)-0.22203097)/beta;
   a(i)=4.888124*h/beta^2;
   j(i)=0;
   i=i+1;
end
theta_2=beta/8:dtheta:3*beta/8;
%------------------------------------------
for theta3=3*beta/8:dtheta:5*beta/8
   s(i)=h*(1.6110154*theta3/beta-0.0309544*sin(4*pi*theta3/beta-pi)-0.3055077);
   v(i)=h*(1.6110154-0.38898448*cos(4*pi*theta3/beta-pi))/beta;
   a(i)=4.888124*h*sin(4*pi*theta3/beta-pi)/beta^2;
   j(i)=61.425769*h*cos(4*pi*theta3/beta-pi)/beta^3;
	i=i+1;
end
theta_3=3*beta/8:dtheta:5*beta/8;
%------------------------------------------
for theta4=5*beta/8:dtheta:7*beta/8
   s(i)=h*(-2.44406184*(theta4/beta).^2+4.6660917*(theta4/beta)-1.2292648);
   v(i)=h*(-4.888124*(theta4/beta)+4.6660917)/beta;
   a(i)=-4.888124*h/beta^2;
   j(i)=0;
   i=i+1;
end
theta_4=5*beta/8:dtheta:7*beta/8;
%------------------------------------------
for theta5=7*beta/8:dtheta:beta
   s(i)=h*(0.38898448*theta5/beta+0.0309544*sin(4*pi*theta5/beta-3*pi)+0.6110154);
   v(i)=0.38898448*h*(1+cos(4*pi*theta5/beta-3*pi))/beta;
   a(i)=-4.888124*h*sin(4*pi*theta5/beta-3*pi)/beta^2;
   j(i)=-61.425769*h*cos(4*pi*theta5/beta-3*pi)/beta^3;
	i=i+1;
end
theta_5=7*beta/8:dtheta:beta;
%------------------------------------------
theta=[theta_1,theta_2,theta_3,theta_4,theta_5];
