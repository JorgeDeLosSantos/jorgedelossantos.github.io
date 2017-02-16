function varargout = gear_contour_export(varargin)
% GEAR_CONTOUR_EXPORT Application M-file for gear_contour_export.fig
%    FIG = GEAR_CONTOUR_EXPORT launch gear_contour_export GUI.
%    GEAR_CONTOUR_EXPORT('callback_name', ...) invoke the named callback.

% Last Modified by GUIDE v2.5 22-Sep-2002 22:12:17

if nargin == 0  % LAUNCH GUI

	fig = openfig(mfilename,'reuse');

	% Use system color scheme for figure:
	set(fig,'Color',get(0,'defaultUicontrolBackgroundColor'));

	% Generate a structure of handles to pass to callbacks, and store it. 
	handles = guihandles(fig);
	guidata(fig, handles);

	if nargout > 0
		varargout{1} = fig;
	end

elseif ischar(varargin{1}) % INVOKE NAMED SUBFUNCTION OR CALLBACK

	try
		if (nargout)
			[varargout{1:nargout}] = feval(varargin{:}); % FEVAL switchyard
		else
			feval(varargin{:}); % FEVAL switchyard
		end
	catch
		disp(lasterr);
	end

end


%| ABOUT CALLBACKS:
%| GUIDE automatically appends subfunction prototypes to this file, and 
%| sets objects' callback properties to call them through the FEVAL 
%| switchyard above. This comment describes that mechanism.
%|
%| Each callback subfunction declaration has the following form:
%| <SUBFUNCTION_NAME>(H, EVENTDATA, HANDLES, VARARGIN)
%|
%| The subfunction name is composed using the object's Tag and the 
%| callback type separated by '_', e.g. 'slider2_Callback',
%| 'figure1_CloseRequestFcn', 'axis1_ButtondownFcn'.
%|
%| H is the callback object's handle (obtained using GCBO).
%|
%| EVENTDATA is empty, but reserved for future use.
%|
%| HANDLES is a structure containing handles of components in GUI using
%| tags as fieldnames, e.g. handles.figure1, handles.slider2. This
%| structure is created at GUI startup using GUIHANDLES and stored in
%| the figure's application data using GUIDATA. A copy of the structure
%| is passed to each callback.  You can store additional information in
%| this structure at GUI startup, and you can change the structure
%| during callbacks.  Call guidata(h, handles) after changing your
%| copy to replace the stored original so that subsequent callbacks see
%| the updates. Type "help guihandles" and "help guidata" for more
%| information.
%|
%| VARARGIN contains any extra arguments you have passed to the
%| callback. Specify the extra arguments by editing the callback
%| property in the inspector. By default, GUIDE sets the property to:
%| <MFILENAME>('<SUBFUNCTION_NAME>', gcbo, [], guidata(gcbo))
%| Add any extra arguments after the last argument, before the final
%| closing parenthesis.



% --------------------------------------------------------------------
function varargout = addendum_button_Callback(h, eventdata, handles, varargin)

% gears.m
%This program plots an involute gear. 
% ----------------------------------------------------------------------------
% Written by Shih-Liang (Sid) Wang	6/24/98
% ----------------------------------------------------------------------------
%The parameters of gear
n=10;			%The number of teeth
pd=6;			%The diametral pitch
phi_d=20;	%The pressure angle in degrees 
% ----------------------------------------------------------------------------
r_fillet=0.05;		%The radius of fillet
% ----------------------------------------------------------------------------
%To declare variables
xp=zeros(10,1);yp=zeros(10,1);
xo=zeros(5,1);yo=zeros(5,1);
xr=zeros(3,1);yr=zeros(3,1);
xro=zeros(5,1);yro=zeros(5,1);
xf=zeros(5,1);yf=zeros(5,1);
theta=zeros(10,1);
f=zeros(2,28);
M=[];c=[];e=[];g=[];h=[];
% ----------------------------------------------------------------------------
%To calculate the basic parameters of a gear
d=n/pd;				%pitch diamter
phi=phi_d*pi/180;	%pressure angle in radians
db=d*cos(phi);		%diameter of base circle
do=d+2/pd;			%addendum (outside) diameter
tt=pi/(2*pd);		%tooth thickness at the pitch circle
dr=d-2*1.25/pd;	%dedendum (root) diameter
% ----------------------------------------------------------------------------
%To calculate the coordinates of the involute profile
n1=10;
tp=pi*d/(2*n);
for i=1:n1;
	r=do/2-(do-db)*(i-1)/(2*(n1-1));
	pha=acos(db/(2*r));
	t=2*r*(tp/d+(tan(phi)-phi)-(tan(pha)-pha));	%tooth tickness at any angle phi
																%involute equation - 
																%refer to Shigley's book
	theta(i)=t/(2*r);
	xp(i)=r*sin(theta(i));		%change from polar coordinates to cartesian coordinates
	yp(i)=r*cos(theta(i));
end
xp=xp';yp=yp';
% ----------------------------------------------------------------------------
%To calculate the addendum circle
n2=5;
for i=1:n2;
	theta_o=theta(1)*(i-1)/(n2-1);
	xo(i)=(do/2)*sin(theta_o);
	yo(i)=(do/2)*cos(theta_o);
end
xo=xo';yo=yo';
% ----------------------------------------------------------------------------
%To calculate the non-involute portion of the curve- between the base circle and 
% dedendum circle - in this case, a straight line parallel to the y axis and connects 
% to the fillet arc
for i=1:3;
	theta0=asin((xp(1,n1)+r_fillet)/(dr/2)); 
%to find the angle between the central line (y-axis) and the line from the center 
%to the last point of the involute curve.
	xr(i)=xp(1,10);
	yr(i)=yp(1,10)-(yp(1,10)-r_fillet-(dr/2)*cos(theta0))*i/3;
end
xr=xr';yr=yr';
% ----------------------------------------------------------------------------
%To calculate the dedendum circle
n3=5;
for i=1:n3;
   thetar=theta0+(pi/n-theta0)*(i-1)/(n3-1);	
   %(pi/n-theta0) angle subtended for dededem arc
   xro(i)=dr*sin(thetar)/2;	%xro(1) is the beginning point
	yro(i)=dr*cos(thetar)/2;
end
xro=xro';yro=yro';
% ----------------------------------------------------------------------------
%To calculate fillet
% to draw the quarter of a circle from the last point of the non-involute part to 
% the tangent of the dedenum circle.
n4=5;
for i=1:n4;
   xf(i)=xro(1)-r_fillet*cos((i-1)*pi/(2*n4-2));
   yf(i)=yro(1)+r_fillet*(1-sin((i-1)*pi/(2*n4-2)));	%yf(5)=yro(1)-r_fillet*sin(4*pi/8)
end
xf=xf';yf=yf';
% ----------------------------------------------------------------------------
%To append each piece of curve to generate one-half of a tooth profile
c=[c,xo,xp,xr,xf,xro];
e=[e,yo,yp,yr,yf,yro];
g=[c',e'];
g=g';						%the one-half  tooth profile
% ----------------------------------------------------------------------------
%To reflecte the involute curve about y axis to get the whole tooth
ff=[-1 0;0 1]*g;		%reflection 
n5=n1+n2+n3+n4+3
for i=1:n5;				%n4 points =n1(involute)+n2(addendum)+n4(fillet)
   						%			+3(noninvolute)+n3(dedendum)
   f(1,i)=ff(1,n5+1-i);	%reverse the order of the points, easy for plotting 
	f(2,i)=ff(2,n5+1-i);
end
h=[h,f,g];				%the whole tooth profile
% ----------------------------------------------------------------------------
%To rotate and append the tooth to generate the gear
for i=1:n;
	kk=[cos(2*pi*(i-1)/n) sin(2*pi*(i-1)/n);-sin(2*pi*(i-1)/n) cos(2*pi*(i-1)/n)];
  												 		%rotation matrix
	mm=kk*h;		%rotate
	M=[M,mm];	%append
end
M=[M,h(:,1)]; %add the first point, so the curve returns to the original point
% ----------------------------------------------------------------------------
%plot (g(1,:),g(2,:))	%plot one-half tooth
%plot (h(1,:),h(2,:))	%plot one tooth
%plot (M(1,:),M(2,:))	%plot the whole gear - the first row (x) and second row (y)
plot (g(1,:),g(2,:),'-.b',xo,yo,'-r', 'linewidth',4)  %plot one-half tooth, the addendum part is red
axis('equal')
M=M';						%transpose the matrix to get only two columns, 
							% each row (x,y) easy for plotting.
                     %Output=[M]
                     
%fid = fopen(gear_data,w);
%fprintf(M);
%status = fclose('all');                     
                     


% --------------------------------------------------------------------
function varargout = involute_button_Callback(h, eventdata, handles, varargin)

% gears.m
%This program plots an involute gear. 
% ----------------------------------------------------------------------------
% Written by Shih-Liang (Sid) Wang	6/24/98
% ----------------------------------------------------------------------------
%The parameters of gear
n=10;			%The number of teeth
pd=6;			%The diametral pitch
phi_d=20;	%The pressure angle in degrees 
% ----------------------------------------------------------------------------
r_fillet=0.05;		%The radius of fillet
% ----------------------------------------------------------------------------
%To declare variables
xp=zeros(10,1);yp=zeros(10,1);
xo=zeros(5,1);yo=zeros(5,1);
xr=zeros(3,1);yr=zeros(3,1);
xro=zeros(5,1);yro=zeros(5,1);
xf=zeros(5,1);yf=zeros(5,1);
theta=zeros(10,1);
f=zeros(2,28);
M=[];c=[];e=[];g=[];h=[];
% ----------------------------------------------------------------------------
%To calculate the basic parameters of a gear
d=n/pd;				%pitch diamter
phi=phi_d*pi/180;	%pressure angle in radians
db=d*cos(phi);		%diameter of base circle
do=d+2/pd;			%addendum (outside) diameter
tt=pi/(2*pd);		%tooth thickness at the pitch circle
dr=d-2*1.25/pd;	%dedendum (root) diameter
% ----------------------------------------------------------------------------
%To calculate the coordinates of the involute profile
n1=10;
tp=pi*d/(2*n);
for i=1:n1;
	r=do/2-(do-db)*(i-1)/(2*(n1-1));
	pha=acos(db/(2*r));
	t=2*r*(tp/d+(tan(phi)-phi)-(tan(pha)-pha));	%tooth tickness at any angle phi
																%involute equation - 
																%refer to Shigley's book
	theta(i)=t/(2*r);
	xp(i)=r*sin(theta(i));		%change from polar coordinates to cartesian coordinates
	yp(i)=r*cos(theta(i));
end
xp=xp';yp=yp';
% ----------------------------------------------------------------------------
%To calculate the addendum circle
n2=5;
for i=1:n2;
	theta_o=theta(1)*(i-1)/(n2-1);
	xo(i)=(do/2)*sin(theta_o);
	yo(i)=(do/2)*cos(theta_o);
end
xo=xo';yo=yo';
% ----------------------------------------------------------------------------
%To calculate the non-involute portion of the curve- between the base circle and 
% dedendum circle - in this case, a straight line parallel to the y axis and connects 
% to the fillet arc
for i=1:3;
	theta0=asin((xp(1,n1)+r_fillet)/(dr/2)); 
%to find the angle between the central line (y-axis) and the line from the center 
%to the last point of the involute curve.
	xr(i)=xp(1,10);
	yr(i)=yp(1,10)-(yp(1,10)-r_fillet-(dr/2)*cos(theta0))*i/3;
end
xr=xr';yr=yr';
% ----------------------------------------------------------------------------
%To calculate the dedendum circle
n3=5;
for i=1:n3;
   thetar=theta0+(pi/n-theta0)*(i-1)/(n3-1);	
   %(pi/n-theta0) angle subtended for dededem arc
   xro(i)=dr*sin(thetar)/2;	%xro(1) is the beginning point
	yro(i)=dr*cos(thetar)/2;
end
xro=xro';yro=yro';
% ----------------------------------------------------------------------------
%To calculate fillet
% to draw the quarter of a circle from the last point of the non-involute part to 
% the tangent of the dedenum circle.
n4=5;
for i=1:n4;
   xf(i)=xro(1)-r_fillet*cos((i-1)*pi/(2*n4-2));
   yf(i)=yro(1)+r_fillet*(1-sin((i-1)*pi/(2*n4-2)));	%yf(5)=yro(1)-r_fillet*sin(4*pi/8)
end
xf=xf';yf=yf';
% ----------------------------------------------------------------------------
%To append each piece of curve to generate one-half of a tooth profile
c=[c,xo,xp,xr,xf,xro];
e=[e,yo,yp,yr,yf,yro];
g=[c',e'];
g=g';						%the one-half  tooth profile
% ----------------------------------------------------------------------------
%To reflecte the involute curve about y axis to get the whole tooth
ff=[-1 0;0 1]*g;		%reflection 
n5=n1+n2+n3+n4+3
for i=1:n5;				%n4 points =n1(involute)+n2(addendum)+n4(fillet)
   						%			+3(noninvolute)+n3(dedendum)
   f(1,i)=ff(1,n5+1-i);	%reverse the order of the points, easy for plotting 
	f(2,i)=ff(2,n5+1-i);
end
h=[h,f,g];				%the whole tooth profile
% ----------------------------------------------------------------------------
%To rotate and append the tooth to generate the gear
for i=1:n;
	kk=[cos(2*pi*(i-1)/n) sin(2*pi*(i-1)/n);-sin(2*pi*(i-1)/n) cos(2*pi*(i-1)/n)];
  												 		%rotation matrix
	mm=kk*h;		%rotate
	M=[M,mm];	%append
end
M=[M,h(:,1)]; %add the first point, so the curve returns to the original point
% ----------------------------------------------------------------------------
%plot (g(1,:),g(2,:))	%plot one-half tooth
%plot (h(1,:),h(2,:))	%plot one tooth
%plot (M(1,:),M(2,:))	%plot the whole gear - the first row (x) and second row (y)
plot (g(1,:),g(2,:),'-.b',xp,yp,'-r', 'linewidth',4)  %plot one-half tooth, the involute curve part is red
axis('equal')
M=M';						%transpose the matrix to get only two columns, 
							% each row (x,y) easy for plotting.
                     %Output=[M]
                     
%fid = fopen(gear_data,w);
%fprintf(M);
%status = fclose('all');                     
                     
% --------------------------------------------------------------------
function varargout = dedendum_button_Callback(h, eventdata, handles, varargin)
% gears.m
%This program plots an involute gear. 
% ----------------------------------------------------------------------------
% Written by Shih-Liang (Sid) Wang	6/24/98
% ----------------------------------------------------------------------------
%The parameters of gear
n=10;			%The number of teeth
pd=6;			%The diametral pitch
phi_d=20;	%The pressure angle in degrees 
% ----------------------------------------------------------------------------
r_fillet=0.05;		%The radius of fillet
% ----------------------------------------------------------------------------
%To declare variables
xp=zeros(10,1);yp=zeros(10,1);
xo=zeros(5,1);yo=zeros(5,1);
xr=zeros(3,1);yr=zeros(3,1);
xro=zeros(5,1);yro=zeros(5,1);
xf=zeros(5,1);yf=zeros(5,1);
theta=zeros(10,1);
f=zeros(2,28);
M=[];c=[];e=[];g=[];h=[];
% ----------------------------------------------------------------------------
%To calculate the basic parameters of a gear
d=n/pd;				%pitch diamter
phi=phi_d*pi/180;	%pressure angle in radians
db=d*cos(phi);		%diameter of base circle
do=d+2/pd;			%addendum (outside) diameter
tt=pi/(2*pd);		%tooth thickness at the pitch circle
dr=d-2*1.25/pd;	%dedendum (root) diameter
% ----------------------------------------------------------------------------
%To calculate the coordinates of the involute profile
n1=10;
tp=pi*d/(2*n);
for i=1:n1;
	r=do/2-(do-db)*(i-1)/(2*(n1-1));
	pha=acos(db/(2*r));
	t=2*r*(tp/d+(tan(phi)-phi)-(tan(pha)-pha));	%tooth tickness at any angle phi
																%involute equation - 
																%refer to Shigley's book
	theta(i)=t/(2*r);
	xp(i)=r*sin(theta(i));		%change from polar coordinates to cartesian coordinates
	yp(i)=r*cos(theta(i));
end
xp=xp';yp=yp';
% ----------------------------------------------------------------------------
%To calculate the addendum circle
n2=5;
for i=1:n2;
	theta_o=theta(1)*(i-1)/(n2-1);
	xo(i)=(do/2)*sin(theta_o);
	yo(i)=(do/2)*cos(theta_o);
end
xo=xo';yo=yo';
% ----------------------------------------------------------------------------
%To calculate the non-involute portion of the curve- between the base circle and 
% dedendum circle - in this case, a straight line parallel to the y axis and connects 
% to the fillet arc
for i=1:3;
	theta0=asin((xp(1,n1)+r_fillet)/(dr/2)); 
%to find the angle between the central line (y-axis) and the line from the center 
%to the last point of the involute curve.
	xr(i)=xp(1,10);
	yr(i)=yp(1,10)-(yp(1,10)-r_fillet-(dr/2)*cos(theta0))*i/3;
end
xr=xr';yr=yr';
% ----------------------------------------------------------------------------
%To calculate the dedendum circle
n3=5;
for i=1:n3;
   thetar=theta0+(pi/n-theta0)*(i-1)/(n3-1);	
   %(pi/n-theta0) angle subtended for dededem arc
   xro(i)=dr*sin(thetar)/2;	%xro(1) is the beginning point
	yro(i)=dr*cos(thetar)/2;
end
xro=xro';yro=yro';
% ----------------------------------------------------------------------------
%To calculate fillet
% to draw the quarter of a circle from the last point of the non-involute part to 
% the tangent of the dedenum circle.
n4=5;
for i=1:n4;
   xf(i)=xro(1)-r_fillet*cos((i-1)*pi/(2*n4-2));
   yf(i)=yro(1)+r_fillet*(1-sin((i-1)*pi/(2*n4-2)));	%yf(5)=yro(1)-r_fillet*sin(4*pi/8)
end
xf=xf';yf=yf';
% ----------------------------------------------------------------------------
%To append each piece of curve to generate one-half of a tooth profile
c=[c,xo,xp,xr,xf,xro];
e=[e,yo,yp,yr,yf,yro];
g=[c',e'];
g=g';						%the one-half  tooth profile
% ----------------------------------------------------------------------------
%To reflecte the involute curve about y axis to get the whole tooth
ff=[-1 0;0 1]*g;		%reflection 
n5=n1+n2+n3+n4+3
for i=1:n5;				%n4 points =n1(involute)+n2(addendum)+n4(fillet)
   						%			+3(noninvolute)+n3(dedendum)
   f(1,i)=ff(1,n5+1-i);	%reverse the order of the points, easy for plotting 
	f(2,i)=ff(2,n5+1-i);
end
h=[h,f,g];				%the whole tooth profile
% ----------------------------------------------------------------------------
%To rotate and append the tooth to generate the gear
for i=1:n;
	kk=[cos(2*pi*(i-1)/n) sin(2*pi*(i-1)/n);-sin(2*pi*(i-1)/n) cos(2*pi*(i-1)/n)];
  												 		%rotation matrix
	mm=kk*h;		%rotate
	M=[M,mm];	%append
end
M=[M,h(:,1)]; %add the first point, so the curve returns to the original point
% ----------------------------------------------------------------------------
%plot (g(1,:),g(2,:))	%plot one-half tooth
%plot (h(1,:),h(2,:))	%plot one tooth
%plot (M(1,:),M(2,:))	%plot the whole gear - the first row (x) and second row (y)
plot (g(1,:),g(2,:),'-.b',xro,yro,'-r', 'linewidth',4)  %plot one-half tooth, the dedendum part is red
axis('equal')
M=M';						%transpose the matrix to get only two columns, 
							% each row (x,y) easy for plotting.
                     %Output=[M]
                     
%fid = fopen(gear_data,w);
%fprintf(M);
%status = fclose('all');                     
                     
% --------------------------------------------------------------------
function varargout = fillet_button_Callback(h, eventdata, handles, varargin)

% gears.m
%This program plots an involute gear. 
% ----------------------------------------------------------------------------
% Written by Shih-Liang (Sid) Wang	6/24/98
% ----------------------------------------------------------------------------
%The parameters of gear
n=10;			%The number of teeth
pd=6;			%The diametral pitch
phi_d=20;	%The pressure angle in degrees 
% ----------------------------------------------------------------------------
r_fillet=0.05;		%The radius of fillet
% ----------------------------------------------------------------------------
%To declare variables
xp=zeros(10,1);yp=zeros(10,1);
xo=zeros(5,1);yo=zeros(5,1);
xr=zeros(3,1);yr=zeros(3,1);
xro=zeros(5,1);yro=zeros(5,1);
xf=zeros(5,1);yf=zeros(5,1);
theta=zeros(10,1);
f=zeros(2,28);
M=[];c=[];e=[];g=[];h=[];
% ----------------------------------------------------------------------------
%To calculate the basic parameters of a gear
d=n/pd;				%pitch diamter
phi=phi_d*pi/180;	%pressure angle in radians
db=d*cos(phi);		%diameter of base circle
do=d+2/pd;			%addendum (outside) diameter
tt=pi/(2*pd);		%tooth thickness at the pitch circle
dr=d-2*1.25/pd;	%dedendum (root) diameter
% ----------------------------------------------------------------------------
%To calculate the coordinates of the involute profile
n1=10;
tp=pi*d/(2*n);
for i=1:n1;
	r=do/2-(do-db)*(i-1)/(2*(n1-1));
	pha=acos(db/(2*r));
	t=2*r*(tp/d+(tan(phi)-phi)-(tan(pha)-pha));	%tooth tickness at any angle phi
																%involute equation - 
																%refer to Shigley's book
	theta(i)=t/(2*r);
	xp(i)=r*sin(theta(i));		%change from polar coordinates to cartesian coordinates
	yp(i)=r*cos(theta(i));
end
xp=xp';yp=yp';
% ----------------------------------------------------------------------------
%To calculate the addendum circle
n2=5;
for i=1:n2;
	theta_o=theta(1)*(i-1)/(n2-1);
	xo(i)=(do/2)*sin(theta_o);
	yo(i)=(do/2)*cos(theta_o);
end
xo=xo';yo=yo';
% ----------------------------------------------------------------------------
%To calculate the non-involute portion of the curve- between the base circle and 
% dedendum circle - in this case, a straight line parallel to the y axis and connects 
% to the fillet arc
for i=1:3;
	theta0=asin((xp(1,n1)+r_fillet)/(dr/2)); 
%to find the angle between the central line (y-axis) and the line from the center 
%to the last point of the involute curve.
	xr(i)=xp(1,10);
	yr(i)=yp(1,10)-(yp(1,10)-r_fillet-(dr/2)*cos(theta0))*i/3;
end
xr=xr';yr=yr';
% ----------------------------------------------------------------------------
%To calculate the dedendum circle
n3=5;
for i=1:n3;
   thetar=theta0+(pi/n-theta0)*(i-1)/(n3-1);	
   %(pi/n-theta0) angle subtended for dededem arc
   xro(i)=dr*sin(thetar)/2;	%xro(1) is the beginning point
	yro(i)=dr*cos(thetar)/2;
end
xro=xro';yro=yro';
% ----------------------------------------------------------------------------
%To calculate fillet
% to draw the quarter of a circle from the last point of the non-involute part to 
% the tangent of the dedenum circle.
n4=5;
for i=1:n4;
   xf(i)=xro(1)-r_fillet*cos((i-1)*pi/(2*n4-2));
   yf(i)=yro(1)+r_fillet*(1-sin((i-1)*pi/(2*n4-2)));	%yf(5)=yro(1)-r_fillet*sin(4*pi/8)
end
xf=xf';yf=yf';
% ----------------------------------------------------------------------------
%To append each piece of curve to generate one-half of a tooth profile
c=[c,xo,xp,xr,xf,xro];
e=[e,yo,yp,yr,yf,yro];
g=[c',e'];
g=g';						%the one-half  tooth profile
% ----------------------------------------------------------------------------
%To reflecte the involute curve about y axis to get the whole tooth
ff=[-1 0;0 1]*g;		%reflection 
n5=n1+n2+n3+n4+3
for i=1:n5;				%n4 points =n1(involute)+n2(addendum)+n4(fillet)
   						%			+3(noninvolute)+n3(dedendum)
   f(1,i)=ff(1,n5+1-i);	%reverse the order of the points, easy for plotting 
	f(2,i)=ff(2,n5+1-i);
end
h=[h,f,g];				%the whole tooth profile
% ----------------------------------------------------------------------------
%To rotate and append the tooth to generate the gear
for i=1:n;
	kk=[cos(2*pi*(i-1)/n) sin(2*pi*(i-1)/n);-sin(2*pi*(i-1)/n) cos(2*pi*(i-1)/n)];
  												 		%rotation matrix
	mm=kk*h;		%rotate
	M=[M,mm];	%append
end
M=[M,h(:,1)]; %add the first point, so the curve returns to the original point
% ----------------------------------------------------------------------------
%plot (g(1,:),g(2,:))	%plot one-half tooth
%plot (h(1,:),h(2,:))	%plot one tooth
%plot (M(1,:),M(2,:))	%plot the whole gear - the first row (x) and second row (y)
plot (g(1,:),g(2,:),'-.b',xf,yf,'-r', 'linewidth',4)  %plot one-half tooth, the fillet part is red
axis('equal')
M=M';						%transpose the matrix to get only two columns, 
							% each row (x,y) easy for plotting.
                     %Output=[M]
                     
%fid = fopen(gear_data,w);
%fprintf(M);
%status = fclose('all');                     
                     


% --------------------------------------------------------------------
function varargout = line_button_Callback(h, eventdata, handles, varargin)


% gears.m
%This program plots an involute gear. 
% ----------------------------------------------------------------------------
% Written by Shih-Liang (Sid) Wang	6/24/98
% ----------------------------------------------------------------------------
%The parameters of gear
n=10;			%The number of teeth
pd=6;			%The diametral pitch
phi_d=20;	%The pressure angle in degrees 
% ----------------------------------------------------------------------------
r_fillet=0.05;		%The radius of fillet
% ----------------------------------------------------------------------------
%To declare variables
xp=zeros(10,1);yp=zeros(10,1);
xo=zeros(5,1);yo=zeros(5,1);
xr=zeros(3,1);yr=zeros(3,1);
xro=zeros(5,1);yro=zeros(5,1);
xf=zeros(5,1);yf=zeros(5,1);
theta=zeros(10,1);
f=zeros(2,28);
M=[];c=[];e=[];g=[];h=[];
% ----------------------------------------------------------------------------
%To calculate the basic parameters of a gear
d=n/pd;				%pitch diamter
phi=phi_d*pi/180;	%pressure angle in radians
db=d*cos(phi);		%diameter of base circle
do=d+2/pd;			%addendum (outside) diameter
tt=pi/(2*pd);		%tooth thickness at the pitch circle
dr=d-2*1.25/pd;	%dedendum (root) diameter
% ----------------------------------------------------------------------------
%To calculate the coordinates of the involute profile
n1=10;
tp=pi*d/(2*n);
for i=1:n1;
	r=do/2-(do-db)*(i-1)/(2*(n1-1));
	pha=acos(db/(2*r));
	t=2*r*(tp/d+(tan(phi)-phi)-(tan(pha)-pha));	%tooth tickness at any angle phi
																%involute equation - 
																%refer to Shigley's book
	theta(i)=t/(2*r);
	xp(i)=r*sin(theta(i));		%change from polar coordinates to cartesian coordinates
	yp(i)=r*cos(theta(i));
end
xp=xp';yp=yp';
% ----------------------------------------------------------------------------
%To calculate the addendum circle
n2=5;
for i=1:n2;
	theta_o=theta(1)*(i-1)/(n2-1);
	xo(i)=(do/2)*sin(theta_o);
	yo(i)=(do/2)*cos(theta_o);
end
xo=xo';yo=yo';
% ----------------------------------------------------------------------------
%To calculate the non-involute portion of the curve- between the base circle and 
% dedendum circle - in this case, a straight line parallel to the y axis and connects 
% to the fillet arc
for i=1:3;
	theta0=asin((xp(1,n1)+r_fillet)/(dr/2)); 
%to find the angle between the central line (y-axis) and the line from the center 
%to the last point of the involute curve.
	xr(i)=xp(1,10);
	yr(i)=yp(1,10)-(yp(1,10)-r_fillet-(dr/2)*cos(theta0))*i/3;
end
xr=xr';yr=yr';
% ----------------------------------------------------------------------------
%To calculate the dedendum circle
n3=5;
for i=1:n3;
   thetar=theta0+(pi/n-theta0)*(i-1)/(n3-1);	
   %(pi/n-theta0) angle subtended for dededem arc
   xro(i)=dr*sin(thetar)/2;	%xro(1) is the beginning point
	yro(i)=dr*cos(thetar)/2;
end
xro=xro';yro=yro';
% ----------------------------------------------------------------------------
%To calculate fillet
% to draw the quarter of a circle from the last point of the non-involute part to 
% the tangent of the dedenum circle.
n4=5;
for i=1:n4;
   xf(i)=xro(1)-r_fillet*cos((i-1)*pi/(2*n4-2));
   yf(i)=yro(1)+r_fillet*(1-sin((i-1)*pi/(2*n4-2)));	%yf(5)=yro(1)-r_fillet*sin(4*pi/8)
end
xf=xf';yf=yf';
% ----------------------------------------------------------------------------
%To append each piece of curve to generate one-half of a tooth profile
c=[c,xo,xp,xr,xf,xro];
e=[e,yo,yp,yr,yf,yro];
g=[c',e'];
g=g';						%the one-half  tooth profile
% ----------------------------------------------------------------------------
%To reflecte the involute curve about y axis to get the whole tooth
ff=[-1 0;0 1]*g;		%reflection 
n5=n1+n2+n3+n4+3
for i=1:n5;				%n4 points =n1(involute)+n2(addendum)+n4(fillet)
   						%			+3(noninvolute)+n3(dedendum)
   f(1,i)=ff(1,n5+1-i);	%reverse the order of the points, easy for plotting 
	f(2,i)=ff(2,n5+1-i);
end
h=[h,f,g];				%the whole tooth profile
% ----------------------------------------------------------------------------
%To rotate and append the tooth to generate the gear
for i=1:n;
	kk=[cos(2*pi*(i-1)/n) sin(2*pi*(i-1)/n);-sin(2*pi*(i-1)/n) cos(2*pi*(i-1)/n)];
  												 		%rotation matrix
	mm=kk*h;		%rotate
	M=[M,mm];	%append
end
M=[M,h(:,1)]; %add the first point, so the curve returns to the original point
% ----------------------------------------------------------------------------
%plot (g(1,:),g(2,:))	%plot one-half tooth
%plot (h(1,:),h(2,:))	%plot one tooth
%plot (M(1,:),M(2,:))	%plot the whole gear - the first row (x) and second row (y)
plot (g(1,:),g(2,:),'-.b',xr,yr,'-r', 'linewidth',4)  %plot one-half tooth, the non-involute part is red
axis('equal')
M=M';						%transpose the matrix to get only two columns, 
							% each row (x,y) easy for plotting.
                     %Output=[M]
                     
%fid = fopen(gear_data,w);
%fprintf(M);
%status = fclose('all');                     
                     

% --------------------------------------------------------------------
function varargout = half_tooth_button_Callback(h, eventdata, handles, varargin)


% gears.m
%This program plots an involute gear. 
% ----------------------------------------------------------------------------
% Written by Shih-Liang (Sid) Wang	6/24/98
% ----------------------------------------------------------------------------
%The parameters of gear
n=10;			%The number of teeth
pd=6;			%The diametral pitch
phi_d=20;	%The pressure angle in degrees 
% ----------------------------------------------------------------------------
r_fillet=0.05;		%The radius of fillet
% ----------------------------------------------------------------------------
%To declare variables
xp=zeros(10,1);yp=zeros(10,1);
xo=zeros(5,1);yo=zeros(5,1);
xr=zeros(3,1);yr=zeros(3,1);
xro=zeros(5,1);yro=zeros(5,1);
xf=zeros(5,1);yf=zeros(5,1);
theta=zeros(10,1);
f=zeros(2,28);
M=[];c=[];e=[];g=[];h=[];
% ----------------------------------------------------------------------------
%To calculate the basic parameters of a gear
d=n/pd;				%pitch diamter
phi=phi_d*pi/180;	%pressure angle in radians
db=d*cos(phi);		%diameter of base circle
do=d+2/pd;			%addendum (outside) diameter
tt=pi/(2*pd);		%tooth thickness at the pitch circle
dr=d-2*1.25/pd;	%dedendum (root) diameter
% ----------------------------------------------------------------------------
%To calculate the coordinates of the involute profile
n1=10;
tp=pi*d/(2*n);
for i=1:n1;
	r=do/2-(do-db)*(i-1)/(2*(n1-1));
	pha=acos(db/(2*r));
	t=2*r*(tp/d+(tan(phi)-phi)-(tan(pha)-pha));	%tooth tickness at any angle phi
																%involute equation - 
																%refer to Shigley's book
	theta(i)=t/(2*r);
	xp(i)=r*sin(theta(i));		%change from polar coordinates to cartesian coordinates
	yp(i)=r*cos(theta(i));
end
xp=xp';yp=yp';
% ----------------------------------------------------------------------------
%To calculate the addendum circle
n2=5;
for i=1:n2;
	theta_o=theta(1)*(i-1)/(n2-1);
	xo(i)=(do/2)*sin(theta_o);
	yo(i)=(do/2)*cos(theta_o);
end
xo=xo';yo=yo';
% ----------------------------------------------------------------------------
%To calculate the non-involute portion of the curve- between the base circle and 
% dedendum circle - in this case, a straight line parallel to the y axis and connects 
% to the fillet arc
for i=1:3;
	theta0=asin((xp(1,n1)+r_fillet)/(dr/2)); 
%to find the angle between the central line (y-axis) and the line from the center 
%to the last point of the involute curve.
	xr(i)=xp(1,10);
	yr(i)=yp(1,10)-(yp(1,10)-r_fillet-(dr/2)*cos(theta0))*i/3;
end
xr=xr';yr=yr';
% ----------------------------------------------------------------------------
%To calculate the dedendum circle
n3=5;
for i=1:n3;
   thetar=theta0+(pi/n-theta0)*(i-1)/(n3-1);	
   %(pi/n-theta0) angle subtended for dededem arc
   xro(i)=dr*sin(thetar)/2;	%xro(1) is the beginning point
	yro(i)=dr*cos(thetar)/2;
end
xro=xro';yro=yro';
% ----------------------------------------------------------------------------
%To calculate fillet
% to draw the quarter of a circle from the last point of the non-involute part to 
% the tangent of the dedenum circle.
n4=5;
for i=1:n4;
   xf(i)=xro(1)-r_fillet*cos((i-1)*pi/(2*n4-2));
   yf(i)=yro(1)+r_fillet*(1-sin((i-1)*pi/(2*n4-2)));	%yf(5)=yro(1)-r_fillet*sin(4*pi/8)
end
xf=xf';yf=yf';
% ----------------------------------------------------------------------------
%To append each piece of curve to generate one-half of a tooth profile
c=[c,xo,xp,xr,xf,xro];
e=[e,yo,yp,yr,yf,yro];
g=[c',e'];
g=g';						%the one-half  tooth profile
% ----------------------------------------------------------------------------
%To reflecte the involute curve about y axis to get the whole tooth
ff=[-1 0;0 1]*g;		%reflection 
n5=n1+n2+n3+n4+3
for i=1:n5;				%n4 points =n1(involute)+n2(addendum)+n4(fillet)
   						%			+3(noninvolute)+n3(dedendum)
   f(1,i)=ff(1,n5+1-i);	%reverse the order of the points, easy for plotting 
	f(2,i)=ff(2,n5+1-i);
end
h=[h,f,g];				%the whole tooth profile
% ----------------------------------------------------------------------------
%To rotate and append the tooth to generate the gear
for i=1:n;
	kk=[cos(2*pi*(i-1)/n) sin(2*pi*(i-1)/n);-sin(2*pi*(i-1)/n) cos(2*pi*(i-1)/n)];
  												 		%rotation matrix
	mm=kk*h;		%rotate
	M=[M,mm];	%append
end
M=[M,h(:,1)]; %add the first point, so the curve returns to the original point
% ----------------------------------------------------------------------------
%plot (g(1,:),g(2,:))	%plot one-half tooth
%plot (h(1,:),h(2,:))	%plot one tooth
%plot (M(1,:),M(2,:))	%plot the whole gear - the first row (x) and second row (y)
plot (h(1,:),h(2,:),'-.b', g(1,:),g(2,:),'-r', 'linewidth',4) %plot whole tooth, one-half tooth is red
axis('equal')
M=M';						%transpose the matrix to get only two columns, 
							% each row (x,y) easy for plotting.
                     %Output=[M]
                     
%fid = fopen(gear_data,w);
%fprintf(M);
%status = fclose('all');                     
                     

% --------------------------------------------------------------------
function varargout = one_tooth_button_Callback(h, eventdata, handles, varargin)

% gears.m
%This program plots an involute gear. 
% ----------------------------------------------------------------------------
% Written by Shih-Liang (Sid) Wang	6/24/98
% ----------------------------------------------------------------------------
%The parameters of gear
n=10;			%The number of teeth
pd=6;			%The diametral pitch
phi_d=20;	%The pressure angle in degrees 
% ----------------------------------------------------------------------------
r_fillet=0.05;		%The radius of fillet
% ----------------------------------------------------------------------------
%To declare variables
xp=zeros(10,1);yp=zeros(10,1);
xo=zeros(5,1);yo=zeros(5,1);
xr=zeros(3,1);yr=zeros(3,1);
xro=zeros(5,1);yro=zeros(5,1);
xf=zeros(5,1);yf=zeros(5,1);
theta=zeros(10,1);
f=zeros(2,28);
M=[];c=[];e=[];g=[];h=[];
% ----------------------------------------------------------------------------
%To calculate the basic parameters of a gear
d=n/pd;				%pitch diamter
phi=phi_d*pi/180;	%pressure angle in radians
db=d*cos(phi);		%diameter of base circle
do=d+2/pd;			%addendum (outside) diameter
tt=pi/(2*pd);		%tooth thickness at the pitch circle
dr=d-2*1.25/pd;	%dedendum (root) diameter
% ----------------------------------------------------------------------------
%To calculate the coordinates of the involute profile
n1=10;
tp=pi*d/(2*n);
for i=1:n1;
	r=do/2-(do-db)*(i-1)/(2*(n1-1));
	pha=acos(db/(2*r));
	t=2*r*(tp/d+(tan(phi)-phi)-(tan(pha)-pha));	%tooth tickness at any angle phi
																%involute equation - 
																%refer to Shigley's book
	theta(i)=t/(2*r);
	xp(i)=r*sin(theta(i));		%change from polar coordinates to cartesian coordinates
	yp(i)=r*cos(theta(i));
end
xp=xp';yp=yp';
% ----------------------------------------------------------------------------
%To calculate the addendum circle
n2=5;
for i=1:n2;
	theta_o=theta(1)*(i-1)/(n2-1);
	xo(i)=(do/2)*sin(theta_o);
	yo(i)=(do/2)*cos(theta_o);
end
xo=xo';yo=yo';
% ----------------------------------------------------------------------------
%To calculate the non-involute portion of the curve- between the base circle and 
% dedendum circle - in this case, a straight line parallel to the y axis and connects 
% to the fillet arc
for i=1:3;
	theta0=asin((xp(1,n1)+r_fillet)/(dr/2)); 
%to find the angle between the central line (y-axis) and the line from the center 
%to the last point of the involute curve.
	xr(i)=xp(1,10);
	yr(i)=yp(1,10)-(yp(1,10)-r_fillet-(dr/2)*cos(theta0))*i/3;
end
xr=xr';yr=yr';
% ----------------------------------------------------------------------------
%To calculate the dedendum circle
n3=5;
for i=1:n3;
   thetar=theta0+(pi/n-theta0)*(i-1)/(n3-1);	
   %(pi/n-theta0) angle subtended for dededem arc
   xro(i)=dr*sin(thetar)/2;	%xro(1) is the beginning point
	yro(i)=dr*cos(thetar)/2;
end
xro=xro';yro=yro';
% ----------------------------------------------------------------------------
%To calculate fillet
% to draw the quarter of a circle from the last point of the non-involute part to 
% the tangent of the dedenum circle.
n4=5;
for i=1:n4;
   xf(i)=xro(1)-r_fillet*cos((i-1)*pi/(2*n4-2));
   yf(i)=yro(1)+r_fillet*(1-sin((i-1)*pi/(2*n4-2)));	%yf(5)=yro(1)-r_fillet*sin(4*pi/8)
end
xf=xf';yf=yf';
% ----------------------------------------------------------------------------
%To append each piece of curve to generate one-half of a tooth profile
c=[c,xo,xp,xr,xf,xro];
e=[e,yo,yp,yr,yf,yro];
g=[c',e'];
g=g';						%the one-half  tooth profile
% ----------------------------------------------------------------------------
%To reflecte the involute curve about y axis to get the whole tooth
ff=[-1 0;0 1]*g;		%reflection 
n5=n1+n2+n3+n4+3
for i=1:n5;				%n4 points =n1(involute)+n2(addendum)+n4(fillet)
   						%			+3(noninvolute)+n3(dedendum)
   f(1,i)=ff(1,n5+1-i);	%reverse the order of the points, easy for plotting 
	f(2,i)=ff(2,n5+1-i);
end
h=[h,f,g];				%the whole tooth profile
% ----------------------------------------------------------------------------
%To rotate and append the tooth to generate the gear
for i=1:n;
	kk=[cos(2*pi*(i-1)/n) sin(2*pi*(i-1)/n);-sin(2*pi*(i-1)/n) cos(2*pi*(i-1)/n)];
  												 		%rotation matrix
	mm=kk*h;		%rotate
	M=[M,mm];	%append
end
M=[M,h(:,1)]; %add the first point, so the curve returns to the original point
% ----------------------------------------------------------------------------
%plot (g(1,:),g(2,:))	%plot one-half tooth
%plot (h(1,:),h(2,:))	%plot one tooth
%plot (M(1,:),M(2,:))	%plot the whole gear - the first row (x) and second row (y)
plot (M(1,:),M(2,:),'-.b', h(1,:),h(2,:),'-r', 'linewidth',4) %plot whole gear, the original tooth is red
axis('equal')
M=M';						%transpose the matrix to get only two columns, 
							% each row (x,y) easy for plotting.
                     %Output=[M]
                     
%fid = fopen(gear_data,w);
%fprintf(M);
%status = fclose('all');                     
                     


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


close(gcf);



% --- Creates and returns a handle to the GUI figure. 
function h1 = openfig(filename, policy)
% policy - create a new figure or use a singleton. 'new' or 'reuse'.

persistent hsingleton;
if strcmpi(policy, 'reuse') & ishandle(hsingleton)
    h1 = hsingleton;
    return;
end

h1 = figure(...
'Units','characters',...
'Color',[0.831372549019608 0.815686274509804 0.784313725490196],...
'Colormap',[0 0 0.5625;0 0 0.625;0 0 0.6875;0 0 0.75;0 0 0.8125;0 0 0.875;0 0 0.9375;0 0 1;0 0.0625 1;0 0.125 1;0 0.1875 1;0 0.25 1;0 0.3125 1;0 0.375 1;0 0.4375 1;0 0.5 1;0 0.5625 1;0 0.625 1;0 0.6875 1;0 0.75 1;0 0.8125 1;0 0.875 1;0 0.9375 1;0 1 1;0.0625 1 1;0.125 1 0.9375;0.1875 1 0.875;0.25 1 0.8125;0.3125 1 0.75;0.375 1 0.6875;0.4375 1 0.625;0.5 1 0.5625;0.5625 1 0.5;0.625 1 0.4375;0.6875 1 0.375;0.75 1 0.3125;0.8125 1 0.25;0.875 1 0.1875;0.9375 1 0.125;1 1 0.0625;1 1 0;1 0.9375 0;1 0.875 0;1 0.8125 0;1 0.75 0;1 0.6875 0;1 0.625 0;1 0.5625 0;1 0.5 0;1 0.4375 0;1 0.375 0;1 0.3125 0;1 0.25 0;1 0.1875 0;1 0.125 0;1 0.0625 0;1 0 0;0.9375 0 0;0.875 0 0;0.8125 0 0;0.75 0 0;0.6875 0 0;0.625 0 0;0.5625 0 0],...
'IntegerHandle','off',...
'InvertHardcopy',get(0,'defaultfigureInvertHardcopy'),...
'MenuBar','none',...
'Name','Gear Contours',...
'NumberTitle','off',...
'PaperPosition',get(0,'defaultfigurePaperPosition'),...
'Position',[46.2 19.7692307692308 112 32.3076923076923],...
'Resize','off',...
'HandleVisibility','callback',...
'Tag','figure1');

setappdata(h1, 'GUIDEOptions', struct(...
'active_h', [], ...
'taginfo', struct(...
'figure', 2, ...
'pushbutton', 9, ...
'axes', 2, ...
'text', 7, ...
'frame', 3), ...
'override', 0, ...
'resize', 'none', ...
'accessibility', 'callback', ...
'mfile', 1, ...
'callbacks', 1, ...
'singleton', 1, ...
'blocking', 0, ...
'syscolorfig', 1, ...
'lastSavedFile', 'C:\summer_02\erin\matlab_r13\kinmeatics\norton\gear_contour\gear_contour.m', ...
'release', 12));


h2 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[0.882352941176471 0.874509803921569 0.866666666666667],...
'ListboxTop',0,...
'Position',[0.6 13.8461538461538 24.4 15.6153846153846],...
'String',{ '' },...
'Style','frame',...
'Tag','frame2');


h3 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','gear_contour_export(''addendum_button_Callback'',gcbo,[],guidata(gcbo))',...
'ListboxTop',0,...
'Position',[1.6 25.7692307692308 22.8 1.76923076923077],...
'String','Addendum Circle',...
'Tag','addendum_button');


h4 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','gear_contour_export(''involute_button_Callback'',gcbo,[],guidata(gcbo))',...
'ListboxTop',0,...
'Position',[2 22.8461538461538 22.2 2],...
'String','Involute Profile',...
'Tag','involute_button');


h5 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','gear_contour_export(''dedendum_button_Callback'',gcbo,[],guidata(gcbo))',...
'ListboxTop',0,...
'Position',[2 14.2307692307692 21.6 1.76923076923077],...
'String','Dedendum Circle',...
'Tag','dedendum_button');


h6 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','gear_contour_export(''fillet_button_Callback'',gcbo,[],guidata(gcbo))',...
'ListboxTop',0,...
'Position',[2 17.2307692307692 22.4 1.92307692307692],...
'String','Fillet',...
'Tag','fillet_button');


h7 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','gear_contour_export(''line_button_Callback'',gcbo,[],guidata(gcbo))',...
'ListboxTop',0,...
'Position',[2 20 22.4 1.84615384615385],...
'String','Non-Involute - Str. Ln',...
'Tag','line_button');


h8 = axes(...
'Parent',h1,...
'Units','characters',...
'CameraPosition',[0.5 0.5 9.16025403784439],...
'CameraPositionMode',get(0,'defaultaxesCameraPositionMode'),...
'Color',get(0,'defaultaxesColor'),...
'ColorOrder',get(0,'defaultaxesColorOrder'),...
'Position',[29.8 3.69230769230769 72.2 24.6923076923077],...
'XColor',get(0,'defaultaxesXColor'),...
'YColor',get(0,'defaultaxesYColor'),...
'ZColor',get(0,'defaultaxesZColor'),...
'Tag','axes1');


h9 = get(h8,'title');

set(h9,...
'Parent',h8,...
'Color',[0 0 0],...
'HorizontalAlignment','center',...
'Position',[0.498633879781421 1.01857142857143 9.16025403784439],...
'VerticalAlignment','bottom',...
'HandleVisibility','off');

h10 = get(h8,'xlabel');

set(h10,...
'Parent',h8,...
'Color',[0 0 0],...
'HorizontalAlignment','center',...
'Position',[0.498633879781421 -0.0671428571428569 9.16025403784439],...
'VerticalAlignment','cap',...
'HandleVisibility','off');

h11 = get(h8,'ylabel');

set(h11,...
'Parent',h8,...
'Color',[0 0 0],...
'HorizontalAlignment','center',...
'Position',[-0.0778688524590164 0.495714285714286 9.16025403784439],...
'Rotation',90,...
'VerticalAlignment','baseline',...
'HandleVisibility','off');

h12 = get(h8,'zlabel');

set(h12,...
'Parent',h8,...
'Color',[0 0 0],...
'HorizontalAlignment','right',...
'Position',[-0.225409836065574 1.15285714285714 9.16025403784439],...
'HandleVisibility','off',...
'Visible','off');

h13 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','gear_contour_export(''half_tooth_button_Callback'',gcbo,[],guidata(gcbo))',...
'ListboxTop',0,...
'Position',[6.2 9.84615384615385 13.2 1.69230769230769],...
'String','Half Tooth',...
'Tag','half_tooth_button');


h14 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','gear_contour_export(''one_tooth_button_Callback'',gcbo,[],guidata(gcbo))',...
'ListboxTop',0,...
'Position',[6.2 7.38461538461539 13.2 1.69230769230769],...
'String','One Tooth',...
'Tag','one_tooth_button');


h15 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[0.492 0.497 0.492],...
'ListboxTop',0,...
'Position',[39.8 29.1538461538462 29.8 3],...
'String',{ '' },...
'Style','frame',...
'Tag','frame1');


h16 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'FontSize',14,...
'ListboxTop',0,...
'Position',[41 29.6153846153846 27.6 2.15384615384615],...
'String','Gear Contours',...
'Style','text',...
'Tag','text2');


h17 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'FontWeight','bold',...
'ListboxTop',0,...
'Position',[11.8 -0.0769230769230769 90.2 1.38461538461538],...
'String','Software copyright  2004 by The McGraw-Hill Companies, Inc.',...
'Style','text',...
'Tag','text3');


h18 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','gear_contour_export(''pushbutton8_Callback'',gcbo,[],guidata(gcbo))',...
'ListboxTop',0,...
'Position',[97.6 28.9230769230769 10.2 2.38461538461538],...
'String','Quit',...
'Tag','pushbutton8');


h19 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'FontSize',10,...
'FontWeight','bold',...
'ListboxTop',0,...
'Position',[6.8 30 10.2 1.15384615384615],...
'String','Plot',...
'Style','text',...
'Tag','text4');


h20 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[0.894117647058823 0.882352941176471 0.862745098039216],...
'FontSize',10,...
'ListboxTop',0,...
'Position',[4.4 27.6153846153846 16.4 1.53846153846154],...
'String','Tooth Profile',...
'Style','text',...
'Tag','text5');



hsingleton = h1;
