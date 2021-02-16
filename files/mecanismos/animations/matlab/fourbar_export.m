function varargout = fourbar_export(varargin)
% FOURBAR_EXPORT M-file for fourbar_export.fig
%      FOURBAR_EXPORT, by itself, creates a new FOURBAR_EXPORT or raises the existing
%      singleton*.
%
%      H = FOURBAR_EXPORT returns the handle to a new FOURBAR_EXPORT or the handle to
%      the existing singleton*.
%
%      FOURBAR_EXPORT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FOURBAR_EXPORT.M with the given input arguments.
%
%      FOURBAR_EXPORT('Property','Value',...) creates a new FOURBAR_EXPORT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fourbar_export_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fourbar_export_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fourbar_export

% Last Modified by GUIDE v2.5 22-Sep-2002 13:59:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fourbar_export_OpeningFcn, ...
                   'gui_OutputFcn',  @fourbar_export_OutputFcn, ...
                   'gui_LayoutFcn',  @fourbar_export_LayoutFcn, ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before fourbar_export is made visible.
function fourbar_export_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fourbar_export (see VARARGIN)

% Choose default command line output for fourbar_export
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fourbar_export wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = fourbar_export_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in pushbutton_plot_4bar.
function pushbutton_plot_4bar_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot_4bar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a1= str2double(get(handles.edit_a, 'String'));
b1= str2double(get(handles.edit_b, 'String'));
c1= str2double(get(handles.edit_c, 'String'));
d1= str2double(get(handles.edit_d, 'String'));
% theta1= str2double(get(handles.theta_1_button, 'String'));
theta1= 0;
theta2= str2double(get(handles.edit_theta2, 'String'));
delta= str2double(get(handles.edit_delta3, 'String'));
p1= str2double(get(handles.edit_p, 'String'));

%fourbar_export.m
% ----------------------------------------------------------------------------
%This program performs the position, velocity, and acceleration analyses of 
% a four-bar linkage.
% ----------------------------------------------------------------------------
%This program can be used to check HW 4.6, 4.7, 6.4, 6.6, 7.3, and 7.4 of 
% Robert Norton's Design of Machinery. All parameters are defined in figures 
% P4-1, P6-1, and P7-1 respectively. 
%Each row of tables P4-1, P6-1, and P7-1 represents a different problem.
%To work on a different problem (row), edit this file to modify the link parameters 
% (a, b, c, d, etc.) and kinematic parameters (theta_2, omega_2, alpha_2, etc.)
% ----------------------------------------------------------------------------
%In addition to calculate kinematic parameters at a single position, as in  
% HW problems, this program also caculates these parameters as the linkage goes 
% through one cycle of motion.
%One cycle of motion is either that the input link is back to the original position, 
%	or that the linkage is stopped at a motion limit. 
%Linkage motion is accomplished by increasing the crank angle (theta_2) in the 
% beginning of each loop. 
%The program also simulates linkage motion graphically.
% ----------------------------------------------------------------------------
% This program also calculates transmission angle.
% It also calculates the location of instant centers at every position and shows it in animation.
% ----------------------------------------------------------------------------
%clear
a=a1;b=b1;c=c1;d=d1;									% Length of link 2,3,4 and 1 respectively.
	%Modify these parameters to get a new linkage.   
% ----------------------------------------------------------------------------
delta_theta_2=2;									%Increment of crank angle in degrees. 
delta_theta_2=delta_theta_2*pi/180;			%Increment of crank angle converted to radians.
n=2*pi/delta_theta_2;							%Total number of animation intervals in a 
														% complete revolution.
	%Decreases delta_theta to get a smoother animation. 
   %Increases delta_theta to 360 degrees (so that n=1) for a quick calculation at 
   %	one position with no animation. This will be useful for checking HW results.    
% ----------------------------------------------------------------------------
theta=zeros(4,n+1);					%Initializes matrices.  
omega=zeros(4,n+1);					 
alpha=zeros(4,n+1);					
transmission_angle=zeros(1,n+1);
theta(1,1)=theta1;
% ----------------------------------------------------------------------------
%The first index of the matrix, from 1 to 4, denotes the link number, and the 
%	corresponding elements are theta_1, omega_2, etc.
%The second index of the matrix, from 1 to n+1, denotes the iteration number in a 
%	motion simulation. 
%For example, theta(2,1) denotes the initial joint angle of theta_2.
%The maximum number of iteration is n+1 so that the link returns to the original 
%	position. 
% ----------------------------------------------------------------------------
delta_3=delta;								%Coupler point angle in degrees. 
delta_3=delta_3*pi/180;				%Coupler point angle onverted to radians.
p=p1;										%Distance from point A to the coupler point. 
% ----------------------------------------------------------------------------
theta(2,1)=45; 						%Initial joint angle theta_2 in degrees
	%Modify this angle to get a new inital linkage position
theta(2,1)=theta(2,1)*pi/180; 	%Initial joint angle theta_2 converted to radians
omega(2,1)=-15;		       		%Initial angular velocity in rad/s
%Note that data given in HW is already in rad/s. No need for conversion.
alpha(2,1)=-10;                  %Initial angular acceleration in rad/s^2
% ----------------------------------------------------------------------------
wflag=1; 					%Initializes the flag of linkage existance. 
i=1;							%Initializes the counter of while loop for motion simulation.
% ----------------------------------------------------------------------------
%Checks if the linkage is beyond its limits or lengths are not permissible for a 4bar 
% ----------------------------------------------------------------------------
K1=d/a;									%Eq. (4.8a)
K4=d/b;
K5=(c^2-d^2-a^2-b^2)/(2*a*b); 	%Eq. (4.11a)
											%Make sure to have parentheses in the denominator.
D=cos(theta(2,i))-K1+K4*cos(theta(2,i))+K5;	%Preceding Eq. (4.13)
E=-2*sin(theta(2,i));
F=K1+(K4-1)*cos(theta(2,i))+K5;
if (E^2-4.*D*F<0) 									% No solution for theta_3 in Eq. (4.13).
   wflag=0;
   	% If wflag=0, The linkage is beyond its limits, or the lengths 
      %		are not permissible for a 4bar. 
      % For example, if a^2+d^2+2a*d*cos(theta_2) > (b+c)^2,
      %		the fourbar_export linkage can not be constructed.
      % At the motion limit, the fourbar_export becomes a triagle, as shown in 
      %		Figure 4.16.  If the crank is over the limit, the law of cosine will not 
      %		be valid, and the fourbar_export can not be connected.
end 
% ----------------------------------------------------------------------------
%Perform position, velocity, and acceleration analyses during motion (while loop). 
%If wflag=0, there is no need to set the linkage in motion in the following while loop.
% ----------------------------------------------------------------------------
while wflag==1     
   	%Note that "==" is a relational operator to return logical true or false.  
 		%If linkage is permissible (wflag==1), the while loop proceeds.       
% ----------------------------------------------------------------------------
%Position Analysis
% ----------------------------------------------------------------------------
theta(3,i)=2*atan((-E-sqrt(E^2-4.*D*F))/(2*D)); 				%Eq. (4.13)
	% Open configuration 
	% For crossed configuration, change the sign before sqrt.
K2=d/c;
K3=(a^2-b^2+c^2+d^2)/(2*a*c);
A=cos(theta(2,i))-K1-K2*cos(theta(2,i))+K3;
B=-2*sin(theta(2,i));
C=K1-(K2+1)*cos(theta(2,i))+K3;
theta(4,i)=2*atan((-B-sqrt(B^2-4.*A*C))/(2*A));					%Eq. (4.10)  
% ----------------------------------------------------------------------------
transmission_angle(i)=abs(theta(3,i)-theta(4,i));

if (transmission_angle(i)>pi)
transmission_angle(i)=2*pi-transmission_angle(i);
end
if (transmission_angle(i)>pi/2)
transmission_angle(i)=pi-transmission_angle(i);
end
transmission_angle(i)=transmission_angle(i)*180/pi;
%
if (i == 1)
    transmission_max = transmission_angle(1);
    transmission_min = transmission_angle(1);  
end
transmission_max = max(transmission_max, transmission_angle(i));
transmission_min = min(transmission_min, transmission_angle(i));

% set(handles.max_button,'String',transmission_max)
% set(handles.min_button,'String',transmission_min)

% ----------------------------------------------------------------------------
%Velocity Analysis
% ----------------------------------------------------------------------------
omega(3,i)=a*omega(2,i)*(sin(theta(4,i)-theta(2,i)))/(b*(sin(theta(3,i)...
  -theta(4,i))));														%Eq. (6.18a)
omega(4,i)=a*omega(2,i)*(sin(theta(2,i)-theta(3,i)))/(c*(sin(theta(4,i)...
  -theta(3,i))));														%Eq. (6.18b)
																% "..." means continuation
VA =a*omega(2,i)*(-sin(theta(2,i))+j*cos(theta(2,i)));		%Eq. (6.19a)
VB =c*omega(4,i)*(-sin(theta(4,i))+j*cos(theta(4,i)));		%Eq. (6.19c)
	%	Note that VA and VB are complex numbers.
% ----------------------------------------------------------------------------
%Acceleration Analysis
% ----------------------------------------------------------------------------
A=c*sin(theta(4,i));														%Eq. (7.12c)
B=b*sin(theta(3,i));												
C=a*alpha(2,i)*sin(theta(2,i))+a*(omega(2,i)^2)*cos(theta(2,i))...
	+b*omega(3,i)^2*cos(theta(3,i))-c*omega(4,i)^2*cos(theta(4,i));
D=c*cos(theta(4,i));
E=b*cos(theta(3,i));
F=a*alpha(2,i)*cos(theta(2,i))-a*omega(2,i)^2*sin(theta(2,i))...
	-b*omega(3,i)^2*sin(theta(3,i))+c*omega(4,i)^2*sin(theta(4,i));
alpha(3,i)= (C*D-A*F)/(A*E-B*D);										%Eq. (7.12a)
alpha(4,i)= (C*E-B*F)/(A*E-B*D);										%Eq. (7.12b)
AA=a*alpha(2,1)*(-sin(theta(2,i))+j*cos(theta(2,i)))...
	-a*omega(2,i)^2*(cos(theta(2,i))+j*sin(theta(2,i)));		%Eq. (7.13a)
AB=c*alpha(4,i)*(-sin(theta(4,i))+j*cos(theta(4,i)))...
	-c*omega(4,i)^2*(cos(theta(4,i))+j*sin(theta(4,i)));		%Eq. (7.13c)
% ----------------------------------------------------------------------------
i=i+1;		%Increses the counter to continue the while loop.
%Checks if the linkage completes a cycle. 
% ----------------------------------------------------------------------------
if (i>n+1)				%The linkage completes a cycle. 
     wflag=0;			%Signals the flag to end the while loop.
else
% ----------------------------------------------------------------------------
% Calculate theta_2, omega_2, and alpha_2 for the next position. 
% ----------------------------------------------------------------------------
omega(2,i)=omega(2,i-1); 												%Constant omega
theta(2,i)=theta(2,i-1)+delta_theta_2;								%Increases theta_2
%Alternative codes
%theta(2,i)=theta(2,1)+omega(2,1)*(delta_time*i)				%Constant omega	
%delta_theta_2=omega(2,i-1)*delta_time								%Constant omega
% Note that delta_time is not used in this program. However, delta_time is useful
%	if the results need to be compared with those from Working Model files.
% ----------------------------------------------------------------------------
%alpha(2,i)=alpha(2,i-1); 												%Constant alpha
%omega(2,i)=omega(2,i-1)+alpha(2,i-1); 							%Constant alpha
%theta(2,i)=theta(2,1)+.5*alpha(2,1)*(delta_time*i)^2			%Constant alpha
%To toggle between these two options, constant velocity or constant acceleration, 
% comment out the constant omega motion and un-comment constant angular alpha motion 
% ----------------------------------------------------------------------------
%Checks if the linkage is beyond its limits with the new theta_2.
% ----------------------------------------------------------------------------
D=cos(theta(2,i))-K1+K4*cos(theta(2,i))+K5;
E=-2*sin(theta(2,i));
F=K1+(K4-1)*cos(theta(2,i))+K5;
	if (E^2-4.*D*F<0) 				%The linkage reaches its moton limits.
  		 wflag=0;						%Signal the flag to end the while loop.
	end 									%End if
% ----------------------------------------------------------------------------
end 		%End if
end		%End while 
% ----------------------------------------------------------------------------
% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
%The following section is for animation.
% ----------------------------------------------------------------------------
XC=[];YC=[];
I13X=[];I13Y=[];I24X=[];I24Y=[];
%output=menu('Simulation Options','4bar simulation','4bar simulation with coupler curve','4bar simulation with instant centers','4bar simulation with fixed centrode');
for k=1:i-1						%"for loop" to animate linkage motion. 
	%Animation stops before the linkage reaches its moton limits or a complete cycle.   
% ----------------------------------------------------------------------------
%Calculates the coordinates of joints and the coupler point
%	based on vector equation with nomenclature in Figure 4-7.
% ----------------------------------------------------------------------------
xo2=0;									%Coordinates of point O2
yo2=0;
xo4=xo2+d*cos(theta(1,1));			%Coordinates of point O4
yo4=yo2+d*sin(theta(1,1));	
	%theta(1,k) is 0 in all HW problems.
xa=xo2+a*cos(theta(2,k));			%Coordinates of point A
ya=yo2+a*sin(theta(2,k));
xb=xa+b*cos(theta(3,k));			%Coordinates of point B
yb=ya+b*sin(theta(3,k));	
	%theta(3,k) is calculated in the position analysis section.
%Alternative codes
%xb=xo4+c*cos(theta(4,k));			%Coordinates of point B
%yb=yo4+c*sin(theta(4,k));	
xc=xa+p*cos(theta(3,k)+delta_3);	%Coordinates of coupler point 
yc=ya+p*sin(theta(3,k)+delta_3);	   
% ----------------------------------------------------------------------------
%Creates the lines representing binary links and sides of the coupler link 
% connected to the coupler point.
% ----------------------------------------------------------------------------
x_link2=[xo2 xa];			%Line of link 2
y_link2=[yo2 ya];
x_link3=[xa xb];			%Line of link 3
y_link3=[ya yb];
x_link4=[xb xo4];			%Line of link 4
y_link4=[yb yo4];
x_link1=[xo4 xo2];		%Line of link 1
y_link1=[yo4 yo2];
x_c1=[xa xc];				%Line of coupler_link side 1
y_c1=[ya yc];
x_c2=[xb xc];				%Line of coupler_link side 2
y_c2=[yb yc];
XC=[XC,xc];
YC=[YC,yc];
% ----------------------------------------------------------------------------
% Calculate the coordinate of instant centers
% ----------------------------------------------------------------------------
I13x=[xb*(yb-yo4)*(xa-xo2)-xa*(ya-yo2)*(xb-xo4)+(ya-yb)*(xb-xo4)*(xa-xo2)]/[(yb-yo4)*(xa-xo2)-(ya-yo2)*(xb-xo4)];
I13y=[yb*(xb-xo4)*(ya-yo2)-ya*(xa-xo2)*(yb-yo4)+(xa-xb)*(yb-yo4)*(ya-yo2)]/[(xb-xo4)*(ya-yo2)-(xa-xo2)*(yb-yo4)];
I24x=[xb*(yb-ya)*(xo4-xo2)-xo4*(yo4-yo2)*(xb-xa)+(yo4-yb)*(xb-xa)*(xo4-xo2)]/[(yb-ya)*(xo4-xo2)-(yo4-yo2)*(xb-xa)];
I24y=[yb*(xb-xa)*(yo4-yo2)-yo4*(xo4-xo2)*(yb-ya)+(xo4-xb)*(yb-ya)*(yo4-yo2)]/[(xb-xa)*(yo4-yo2)-(xo4-xo2)*(yb-ya)];
I13X=[I13X,I13x];
I13Y=[I13Y,I13y];
I24X=[I24X,I24x];
I24Y=[I24Y,I24y];

% val = get(h,'Value');
% switch val
% case 2 
    % --------------------------------------------------------------------
a1= str2double(get(handles.edit_a, 'String'));
b1= str2double(get(handles.edit_b, 'String'));
c1= str2double(get(handles.edit_c, 'String'));
d1= str2double(get(handles.edit_d, 'String'));
%theta1= str2double(get(handles.theta_1_button, 'String'));
theta2= str2double(get(handles.edit_theta2, 'String'));
delta= str2double(get(handles.edit_delta3, 'String'));
p1= str2double(get(handles.edit_p, 'String'));

plot(xo2,yo2,'-.ko',x_link2,y_link2,xa,ya,'-.ko',x_link3,y_link3,xb,yb,'-.ko',x_link4,y_link4,xo4,yo4,'-.ko',x_link1,y_link1,x_c1,y_c1,x_c2,y_c2)
hold on;
xmin=(xo2-a);
xmax=(xo4+c);
ymin=max(yo2-a, yo4-c)-p1*cos(delta*pi/180);
ymax=max(yo2+a, yo4+c)+p1*cos(delta*pi/180);
% axis([xmin  xmax ymin ymax]*1.5)	
axis equal      
plot([xmin  xmax ]*1.4,[0 0], '-.k', [0 0],[ymin ymax]*1.2,'-.k')
hold off;
% case 3 % instant centers
%     
%  a1= str2double(get(handles.edit_a, 'String'));
% b1= str2double(get(handles.edit_b, 'String'));
% c1= str2double(get(handles.edit_c, 'String'));
% d1= str2double(get(handles.edit_d, 'String'));
% %theta1= str2double(get(handles.theta_1_button, 'String'));
% theta2= str2double(get(handles.edit_theta2, 'String'));
% delta= str2double(get(handles.edit_delta3, 'String'));
% p1= str2double(get(handles.edit_p, 'String'));
% 
% plot(xo2,yo2,'-.ko',x_link2,y_link2,xa,ya,'-.ko',x_link3,y_link3,xb,yb,'-.ko',x_link4,y_link4,xo4,yo4,'-.ko',x_link1,y_link1, I13x,I13y,'o', I24x,I24y,'o')
%       axis([xo2-a-2 xo4+c+2 yo2-a-2 yo2-a-2+(xo4+c-xo2+a+4)]*2)	
% 
% 
% 
% case 4 % coupler curve
% a1= str2double(get(handles.edit_a, 'String'));
% b1= str2double(get(handles.edit_b, 'String'));
% c1= str2double(get(handles.edit_c, 'String'));
% d1= str2double(get(handles.edit_d, 'String'));
% %theta1= str2double(get(handles.theta_1_button, 'String'));
% theta2= str2double(get(handles.edit_theta2, 'String'));
% delta= str2double(get(handles.edit_delta3, 'String'));
% p1= str2double(get(handles.edit_p, 'String'));
% 
% plot(xo2,yo2,'-.ko',x_link2,y_link2,xa,ya,'-.ko',x_link3,y_link3,xb,yb,'-.ko',x_link4,y_link4,xo4,yo4,'-.ko',x_link1,y_link1,x_c1,y_c1,x_c2,y_c2, xc,yc,'o', XC,YC)
%       axis([xo2-a-2 xo4+c+2 yo2-a-2 yo2-a-2+(xo4+c-xo2+a+4)]*2)	
% 
% case 5 % fixed centrode
% a1= str2double(get(handles.edit_a, 'String'));
% b1= str2double(get(handles.edit_b, 'String'));
% c1= str2double(get(handles.edit_c, 'String'));
% d1= str2double(get(handles.edit_d, 'String'));
% %theta1= str2double(get(handles.theta_1_button, 'String'));
% theta2= str2double(get(handles.edit_theta2, 'String'));
% delta= str2double(get(handles.edit_delta3, 'String'));
% p1= str2double(get(handles.edit_p, 'String'));
% 
% plot(xo2,yo2,'-.ko',x_link2,y_link2,xa,ya,'-.ko',x_link3,y_link3,xb,yb,'-.ko',x_link4,y_link4,xo4,yo4,'-.ko',x_link1,y_link1, I13x,I13y,'o', I13X,I13Y)
%       axis([xo2-a-2 xo4+c+2 yo2-a-2 yo2-a-2+(xo4+c-xo2+a+4)]*2)	
% 
% 

% end

% guidata(h,handles)

% axis([xo2-a-2 xo4+c+2 yo2-a-2 yo2-a-2+(xo4+c-xo2+a+4)]*2)	
   %axis([xmin xmax ymin ymax])
	% Automatically adjusts the range of axes to show the whole linkage in the screen 
	%   when a new linkage is created.
   % This is accomplised by making the width (xmax-xmin) equal to the height (ymax-ymin)  
   %  for proper aspect ratio.
% axis off 					%Turns off all axis lines, tick marks, and labels.
drawnow; 					%Completes pending drawing events and updates the Figure window
end 							%end "for loop"
% ----------------------------------------------------------------------------
theta=theta.*180/pi;			%Converts radians to degrees for output.




% --- Executes on button press in pushbutton_instant_centers.
function pushbutton_instant_centers_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_instant_centers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a1= str2double(get(handles.edit_a, 'String'));
b1= str2double(get(handles.edit_b, 'String'));
c1= str2double(get(handles.edit_c, 'String'));
d1= str2double(get(handles.edit_d, 'String'));
% theta1= str2double(get(handles.theta_1_button, 'String'));
theta1= 0;
theta2= str2double(get(handles.edit_theta2, 'String'));
delta= str2double(get(handles.edit_delta3, 'String'));
p1= str2double(get(handles.edit_p, 'String'));

%fourbar_export.m
% ----------------------------------------------------------------------------
%This program performs the position, velocity, and acceleration analyses of 
% a four-bar linkage.
% ----------------------------------------------------------------------------
%This program can be used to check HW 4.6, 4.7, 6.4, 6.6, 7.3, and 7.4 of 
% Robert Norton's Design of Machinery. All parameters are defined in figures 
% P4-1, P6-1, and P7-1 respectively. 
%Each row of tables P4-1, P6-1, and P7-1 represents a different problem.
%To work on a different problem (row), edit this file to modify the link parameters 
% (a, b, c, d, etc.) and kinematic parameters (theta_2, omega_2, alpha_2, etc.)
% ----------------------------------------------------------------------------
%In addition to calculate kinematic parameters at a single position, as in  
% HW problems, this program also caculates these parameters as the linkage goes 
% through one cycle of motion.
%One cycle of motion is either that the input link is back to the original position, 
%	or that the linkage is stopped at a motion limit. 
%Linkage motion is accomplished by increasing the crank angle (theta_2) in the 
% beginning of each loop. 
%The program also simulates linkage motion graphically.
% ----------------------------------------------------------------------------
% This program also calculates transmission angle.
% It also calculates the location of instant centers at every position and shows it in animation.
% ----------------------------------------------------------------------------
%clear
a=a1;b=b1;c=c1;d=d1;									% Length of link 2,3,4 and 1 respectively.
	%Modify these parameters to get a new linkage.   
% ----------------------------------------------------------------------------
delta_theta_2=2;									%Increment of crank angle in degrees. 
delta_theta_2=delta_theta_2*pi/180;			%Increment of crank angle converted to radians.
n=2*pi/delta_theta_2;							%Total number of animation intervals in a 
														% complete revolution.
	%Decreases delta_theta to get a smoother animation. 
   %Increases delta_theta to 360 degrees (so that n=1) for a quick calculation at 
   %	one position with no animation. This will be useful for checking HW results.    
% ----------------------------------------------------------------------------
theta=zeros(4,n+1);					%Initializes matrices.  
omega=zeros(4,n+1);					 
alpha=zeros(4,n+1);					
transmission_angle=zeros(1,n+1);
theta(1,1)=theta1;
% ----------------------------------------------------------------------------
%The first index of the matrix, from 1 to 4, denotes the link number, and the 
%	corresponding elements are theta_1, omega_2, etc.
%The second index of the matrix, from 1 to n+1, denotes the iteration number in a 
%	motion simulation. 
%For example, theta(2,1) denotes the initial joint angle of theta_2.
%The maximum number of iteration is n+1 so that the link returns to the original 
%	position. 
% ----------------------------------------------------------------------------
delta_3=delta;								%Coupler point angle in degrees. 
delta_3=delta_3*pi/180;				%Coupler point angle onverted to radians.
p=p1;										%Distance from point A to the coupler point. 
% ----------------------------------------------------------------------------
theta(2,1)=45; 						%Initial joint angle theta_2 in degrees
	%Modify this angle to get a new inital linkage position
theta(2,1)=theta(2,1)*pi/180; 	%Initial joint angle theta_2 converted to radians
omega(2,1)=-15;		       		%Initial angular velocity in rad/s
%Note that data given in HW is already in rad/s. No need for conversion.
alpha(2,1)=-10;                  %Initial angular acceleration in rad/s^2
% ----------------------------------------------------------------------------
wflag=1; 					%Initializes the flag of linkage existance. 
i=1;							%Initializes the counter of while loop for motion simulation.
% ----------------------------------------------------------------------------
%Checks if the linkage is beyond its limits or lengths are not permissible for a 4bar 
% ----------------------------------------------------------------------------
K1=d/a;									%Eq. (4.8a)
K4=d/b;
K5=(c^2-d^2-a^2-b^2)/(2*a*b); 	%Eq. (4.11a)
											%Make sure to have parentheses in the denominator.
D=cos(theta(2,i))-K1+K4*cos(theta(2,i))+K5;	%Preceding Eq. (4.13)
E=-2*sin(theta(2,i));
F=K1+(K4-1)*cos(theta(2,i))+K5;
if (E^2-4.*D*F<0) 									% No solution for theta_3 in Eq. (4.13).
   wflag=0;
   	% If wflag=0, The linkage is beyond its limits, or the lengths 
      %		are not permissible for a 4bar. 
      % For example, if a^2+d^2+2a*d*cos(theta_2) > (b+c)^2,
      %		the fourbar_export linkage can not be constructed.
      % At the motion limit, the fourbar_export becomes a triagle, as shown in 
      %		Figure 4.16.  If the crank is over the limit, the law of cosine will not 
      %		be valid, and the fourbar_export can not be connected.
end 
% ----------------------------------------------------------------------------
%Perform position, velocity, and acceleration analyses during motion (while loop). 
%If wflag=0, there is no need to set the linkage in motion in the following while loop.
% ----------------------------------------------------------------------------
while wflag==1     
   	%Note that "==" is a relational operator to return logical true or false.  
 		%If linkage is permissible (wflag==1), the while loop proceeds.       
% ----------------------------------------------------------------------------
%Position Analysis
% ----------------------------------------------------------------------------
theta(3,i)=2*atan((-E-sqrt(E^2-4.*D*F))/(2*D)); 				%Eq. (4.13)
	% Open configuration 
	% For crossed configuration, change the sign before sqrt.
K2=d/c;
K3=(a^2-b^2+c^2+d^2)/(2*a*c);
A=cos(theta(2,i))-K1-K2*cos(theta(2,i))+K3;
B=-2*sin(theta(2,i));
C=K1-(K2+1)*cos(theta(2,i))+K3;
theta(4,i)=2*atan((-B-sqrt(B^2-4.*A*C))/(2*A));					%Eq. (4.10)  
% ----------------------------------------------------------------------------
transmission_angle(i)=abs(theta(3,i)-theta(4,i));

if (transmission_angle(i)>pi)
transmission_angle(i)=2*pi-transmission_angle(i);
end
if (transmission_angle(i)>pi/2)
transmission_angle(i)=pi-transmission_angle(i);
end
transmission_angle(i)=transmission_angle(i)*180/pi;
%
if (i == 1)
    transmission_max = transmission_angle(1);
    transmission_min = transmission_angle(1);  
end
transmission_max = max(transmission_max, transmission_angle(i));
transmission_min = min(transmission_min, transmission_angle(i));

% set(handles.max_button,'String',transmission_max)
% set(handles.min_button,'String',transmission_min)

% ----------------------------------------------------------------------------
%Velocity Analysis
% ----------------------------------------------------------------------------
omega(3,i)=a*omega(2,i)*(sin(theta(4,i)-theta(2,i)))/(b*(sin(theta(3,i)...
  -theta(4,i))));														%Eq. (6.18a)
omega(4,i)=a*omega(2,i)*(sin(theta(2,i)-theta(3,i)))/(c*(sin(theta(4,i)...
  -theta(3,i))));														%Eq. (6.18b)
																% "..." means continuation
VA =a*omega(2,i)*(-sin(theta(2,i))+j*cos(theta(2,i)));		%Eq. (6.19a)
VB =c*omega(4,i)*(-sin(theta(4,i))+j*cos(theta(4,i)));		%Eq. (6.19c)
	%	Note that VA and VB are complex numbers.
% ----------------------------------------------------------------------------
%Acceleration Analysis
% ----------------------------------------------------------------------------
A=c*sin(theta(4,i));														%Eq. (7.12c)
B=b*sin(theta(3,i));												
C=a*alpha(2,i)*sin(theta(2,i))+a*(omega(2,i)^2)*cos(theta(2,i))...
	+b*omega(3,i)^2*cos(theta(3,i))-c*omega(4,i)^2*cos(theta(4,i));
D=c*cos(theta(4,i));
E=b*cos(theta(3,i));
F=a*alpha(2,i)*cos(theta(2,i))-a*omega(2,i)^2*sin(theta(2,i))...
	-b*omega(3,i)^2*sin(theta(3,i))+c*omega(4,i)^2*sin(theta(4,i));
alpha(3,i)= (C*D-A*F)/(A*E-B*D);										%Eq. (7.12a)
alpha(4,i)= (C*E-B*F)/(A*E-B*D);										%Eq. (7.12b)
AA=a*alpha(2,1)*(-sin(theta(2,i))+j*cos(theta(2,i)))...
	-a*omega(2,i)^2*(cos(theta(2,i))+j*sin(theta(2,i)));		%Eq. (7.13a)
AB=c*alpha(4,i)*(-sin(theta(4,i))+j*cos(theta(4,i)))...
	-c*omega(4,i)^2*(cos(theta(4,i))+j*sin(theta(4,i)));		%Eq. (7.13c)
% ----------------------------------------------------------------------------
i=i+1;		%Increses the counter to continue the while loop.
%Checks if the linkage completes a cycle. 
% ----------------------------------------------------------------------------
if (i>n+1)				%The linkage completes a cycle. 
     wflag=0;			%Signals the flag to end the while loop.
else
% ----------------------------------------------------------------------------
% Calculate theta_2, omega_2, and alpha_2 for the next position. 
% ----------------------------------------------------------------------------
omega(2,i)=omega(2,i-1); 												%Constant omega
theta(2,i)=theta(2,i-1)+delta_theta_2;								%Increases theta_2
%Alternative codes
%theta(2,i)=theta(2,1)+omega(2,1)*(delta_time*i)				%Constant omega	
%delta_theta_2=omega(2,i-1)*delta_time								%Constant omega
% Note that delta_time is not used in this program. However, delta_time is useful
%	if the results need to be compared with those from Working Model files.
% ----------------------------------------------------------------------------
%alpha(2,i)=alpha(2,i-1); 												%Constant alpha
%omega(2,i)=omega(2,i-1)+alpha(2,i-1); 							%Constant alpha
%theta(2,i)=theta(2,1)+.5*alpha(2,1)*(delta_time*i)^2			%Constant alpha
%To toggle between these two options, constant velocity or constant acceleration, 
% comment out the constant omega motion and un-comment constant angular alpha motion 
% ----------------------------------------------------------------------------
%Checks if the linkage is beyond its limits with the new theta_2.
% ----------------------------------------------------------------------------
D=cos(theta(2,i))-K1+K4*cos(theta(2,i))+K5;
E=-2*sin(theta(2,i));
F=K1+(K4-1)*cos(theta(2,i))+K5;
	if (E^2-4.*D*F<0) 				%The linkage reaches its moton limits.
  		 wflag=0;						%Signal the flag to end the while loop.
	end 									%End if
% ----------------------------------------------------------------------------
end 		%End if
end		%End while 
% ----------------------------------------------------------------------------
% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
%The following section is for animation.
% ----------------------------------------------------------------------------
XC=[];YC=[];
I13X=[];I13Y=[];I24X=[];I24Y=[];
%output=menu('Simulation Options','4bar simulation','4bar simulation with coupler curve','4bar simulation with instant centers','4bar simulation with fixed centrode');
for k=1:i-1						%"for loop" to animate linkage motion. 
	%Animation stops before the linkage reaches its moton limits or a complete cycle.   
% ----------------------------------------------------------------------------
%Calculates the coordinates of joints and the coupler point
%	based on vector equation with nomenclature in Figure 4-7.
% ----------------------------------------------------------------------------
xo2=0;									%Coordinates of point O2
yo2=0;
xo4=xo2+d*cos(theta(1,1));			%Coordinates of point O4
yo4=yo2+d*sin(theta(1,1));	
	%theta(1,k) is 0 in all HW problems.
xa=xo2+a*cos(theta(2,k));			%Coordinates of point A
ya=yo2+a*sin(theta(2,k));
xb=xa+b*cos(theta(3,k));			%Coordinates of point B
yb=ya+b*sin(theta(3,k));	
	%theta(3,k) is calculated in the position analysis section.
%Alternative codes
%xb=xo4+c*cos(theta(4,k));			%Coordinates of point B
%yb=yo4+c*sin(theta(4,k));	
xc=xa+p*cos(theta(3,k)+delta_3);	%Coordinates of coupler point 
yc=ya+p*sin(theta(3,k)+delta_3);	   
% ----------------------------------------------------------------------------
%Creates the lines representing binary links and sides of the coupler link 
% connected to the coupler point.
% ----------------------------------------------------------------------------
x_link2=[xo2 xa];			%Line of link 2
y_link2=[yo2 ya];
x_link3=[xa xb];			%Line of link 3
y_link3=[ya yb];
x_link4=[xb xo4];			%Line of link 4
y_link4=[yb yo4];
x_link1=[xo4 xo2];		%Line of link 1
y_link1=[yo4 yo2];
x_c1=[xa xc];				%Line of coupler_link side 1
y_c1=[ya yc];
x_c2=[xb xc];				%Line of coupler_link side 2
y_c2=[yb yc];
XC=[XC,xc];
YC=[YC,yc];
% ----------------------------------------------------------------------------
% Calculate the coordinate of instant centers
% ----------------------------------------------------------------------------
I13x=[xb*(yb-yo4)*(xa-xo2)-xa*(ya-yo2)*(xb-xo4)+(ya-yb)*(xb-xo4)*(xa-xo2)]/[(yb-yo4)*(xa-xo2)-(ya-yo2)*(xb-xo4)];
I13y=[yb*(xb-xo4)*(ya-yo2)-ya*(xa-xo2)*(yb-yo4)+(xa-xb)*(yb-yo4)*(ya-yo2)]/[(xb-xo4)*(ya-yo2)-(xa-xo2)*(yb-yo4)];
I24x=[xb*(yb-ya)*(xo4-xo2)-xo4*(yo4-yo2)*(xb-xa)+(yo4-yb)*(xb-xa)*(xo4-xo2)]/[(yb-ya)*(xo4-xo2)-(yo4-yo2)*(xb-xa)];
I24y=[yb*(xb-xa)*(yo4-yo2)-yo4*(xo4-xo2)*(yb-ya)+(xo4-xb)*(yb-ya)*(yo4-yo2)]/[(xb-xa)*(yo4-yo2)-(xo4-xo2)*(yb-ya)];
I13X=[I13X,I13x];
I13Y=[I13Y,I13y];
I24X=[I24X,I24x];
I24Y=[I24Y,I24y];

% val = get(h,'Value');
% switch val
% case 2 
    % --------------------------------------------------------------------
a1= str2double(get(handles.edit_a, 'String'));
b1= str2double(get(handles.edit_b, 'String'));
c1= str2double(get(handles.edit_c, 'String'));
d1= str2double(get(handles.edit_d, 'String'));
%theta1= str2double(get(handles.theta_1_button, 'String'));
theta2= str2double(get(handles.edit_theta2, 'String'));
delta= str2double(get(handles.edit_delta3, 'String'));
p1= str2double(get(handles.edit_p, 'String'));
plot(xo2,yo2,'-.ko',x_link2,y_link2,xa,ya,'-.ko',x_link3,y_link3,xb,yb,'-.ko',...
    x_link4,y_link4,xo4,yo4,'-.ko',x_link1,y_link1, I13x,I13y,'ro', I24x,I24y,'ro')

hold on;
xmin=(xo2-a);
xmax=(xo4+c);
ymin=max(yo2-a, yo4-c)-p1*cos(delta*pi/180);
ymax=max(yo2+a, yo4+c)+p1*cos(delta*pi/180);
% axis([xmin  xmax ymin ymax]*1.5)	
axis equal      
plot([xmin  xmax ]*2,[0 0], '-.k', [0 0],[ymin ymax]*1.5,'-.k');
xlim([xmin  xmax ]*2);
hold off;
% case 3 % instant centers
%     
%  a1= str2double(get(handles.edit_a, 'String'));
% b1= str2double(get(handles.edit_b, 'String'));
% c1= str2double(get(handles.edit_c, 'String'));
% d1= str2double(get(handles.edit_d, 'String'));
% %theta1= str2double(get(handles.theta_1_button, 'String'));
% theta2= str2double(get(handles.edit_theta2, 'String'));
% delta= str2double(get(handles.edit_delta3, 'String'));
% p1= str2double(get(handles.edit_p, 'String'));
% 
% plot(xo2,yo2,'-.ko',x_link2,y_link2,xa,ya,'-.ko',x_link3,y_link3,xb,yb,'-.ko',x_link4,y_link4,xo4,yo4,'-.ko',x_link1,y_link1, I13x,I13y,'o', I24x,I24y,'o')
%       axis([xo2-a-2 xo4+c+2 yo2-a-2 yo2-a-2+(xo4+c-xo2+a+4)]*2)	
% 
% 
% 
% case 4 % coupler curve
% a1= str2double(get(handles.edit_a, 'String'));
% b1= str2double(get(handles.edit_b, 'String'));
% c1= str2double(get(handles.edit_c, 'String'));
% d1= str2double(get(handles.edit_d, 'String'));
% %theta1= str2double(get(handles.theta_1_button, 'String'));
% theta2= str2double(get(handles.edit_theta2, 'String'));
% delta= str2double(get(handles.edit_delta3, 'String'));
% p1= str2double(get(handles.edit_p, 'String'));
% 
% plot(xo2,yo2,'-.ko',x_link2,y_link2,xa,ya,'-.ko',x_link3,y_link3,xb,yb,'-.ko',x_link4,y_link4,xo4,yo4,'-.ko',x_link1,y_link1,x_c1,y_c1,x_c2,y_c2, xc,yc,'o', XC,YC)
%       axis([xo2-a-2 xo4+c+2 yo2-a-2 yo2-a-2+(xo4+c-xo2+a+4)]*2)	
% 
% case 5 % fixed centrode
% a1= str2double(get(handles.edit_a, 'String'));
% b1= str2double(get(handles.edit_b, 'String'));
% c1= str2double(get(handles.edit_c, 'String'));
% d1= str2double(get(handles.edit_d, 'String'));
% %theta1= str2double(get(handles.theta_1_button, 'String'));
% theta2= str2double(get(handles.edit_theta2, 'String'));
% delta= str2double(get(handles.edit_delta3, 'String'));
% p1= str2double(get(handles.edit_p, 'String'));
% 
% plot(xo2,yo2,'-.ko',x_link2,y_link2,xa,ya,'-.ko',x_link3,y_link3,xb,yb,'-.ko',x_link4,y_link4,xo4,yo4,'-.ko',x_link1,y_link1, I13x,I13y,'o', I13X,I13Y)
%       axis([xo2-a-2 xo4+c+2 yo2-a-2 yo2-a-2+(xo4+c-xo2+a+4)]*2)	
% 
% 

% end

% guidata(h,handles)

% axis([xo2-a-2 xo4+c+2 yo2-a-2 yo2-a-2+(xo4+c-xo2+a+4)]*2)	
   %axis([xmin xmax ymin ymax])
	% Automatically adjusts the range of axes to show the whole linkage in the screen 
	%   when a new linkage is created.
   % This is accomplised by making the width (xmax-xmin) equal to the height (ymax-ymin)  
   %  for proper aspect ratio.
% axis off 					%Turns off all axis lines, tick marks, and labels.
drawnow; 					%Completes pending drawing events and updates the Figure window
end 							%end "for loop"
% ----------------------------------------------------------------------------
theta=theta.*180/pi;			%Converts radians to degrees for output.



% --- Executes on button press in pushbutton_plot_coupler_curve.
function pushbutton_plot_coupler_curve_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot_coupler_curve (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a1= str2double(get(handles.edit_a, 'String'));
b1= str2double(get(handles.edit_b, 'String'));
c1= str2double(get(handles.edit_c, 'String'));
d1= str2double(get(handles.edit_d, 'String'));
% theta1= str2double(get(handles.theta_1_button, 'String'));
theta1= 0;
theta2= str2double(get(handles.edit_theta2, 'String'));
delta= str2double(get(handles.edit_delta3, 'String'));
p1= str2double(get(handles.edit_p, 'String'));

%fourbar_export.m
% ----------------------------------------------------------------------------
%This program performs the position, velocity, and acceleration analyses of 
% a four-bar linkage.
% ----------------------------------------------------------------------------
%This program can be used to check HW 4.6, 4.7, 6.4, 6.6, 7.3, and 7.4 of 
% Robert Norton's Design of Machinery. All parameters are defined in figures 
% P4-1, P6-1, and P7-1 respectively. 
%Each row of tables P4-1, P6-1, and P7-1 represents a different problem.
%To work on a different problem (row), edit this file to modify the link parameters 
% (a, b, c, d, etc.) and kinematic parameters (theta_2, omega_2, alpha_2, etc.)
% ----------------------------------------------------------------------------
%In addition to calculate kinematic parameters at a single position, as in  
% HW problems, this program also caculates these parameters as the linkage goes 
% through one cycle of motion.
%One cycle of motion is either that the input link is back to the original position, 
%	or that the linkage is stopped at a motion limit. 
%Linkage motion is accomplished by increasing the crank angle (theta_2) in the 
% beginning of each loop. 
%The program also simulates linkage motion graphically.
% ----------------------------------------------------------------------------
% This program also calculates transmission angle.
% It also calculates the location of instant centers at every position and shows it in animation.
% ----------------------------------------------------------------------------
%clear
a=a1;b=b1;c=c1;d=d1;									% Length of link 2,3,4 and 1 respectively.
	%Modify these parameters to get a new linkage.   
% ----------------------------------------------------------------------------
delta_theta_2=2;									%Increment of crank angle in degrees. 
delta_theta_2=delta_theta_2*pi/180;			%Increment of crank angle converted to radians.
n=2*pi/delta_theta_2;							%Total number of animation intervals in a 
														% complete revolution.
	%Decreases delta_theta to get a smoother animation. 
   %Increases delta_theta to 360 degrees (so that n=1) for a quick calculation at 
   %	one position with no animation. This will be useful for checking HW results.    
% ----------------------------------------------------------------------------
theta=zeros(4,n+1);					%Initializes matrices.  
omega=zeros(4,n+1);					 
alpha=zeros(4,n+1);					
transmission_angle=zeros(1,n+1);
theta(1,1)=theta1;
% ----------------------------------------------------------------------------
%The first index of the matrix, from 1 to 4, denotes the link number, and the 
%	corresponding elements are theta_1, omega_2, etc.
%The second index of the matrix, from 1 to n+1, denotes the iteration number in a 
%	motion simulation. 
%For example, theta(2,1) denotes the initial joint angle of theta_2.
%The maximum number of iteration is n+1 so that the link returns to the original 
%	position. 
% ----------------------------------------------------------------------------
delta_3=delta;								%Coupler point angle in degrees. 
delta_3=delta_3*pi/180;				%Coupler point angle onverted to radians.
p=p1;										%Distance from point A to the coupler point. 
% ----------------------------------------------------------------------------
theta(2,1)=45; 						%Initial joint angle theta_2 in degrees
	%Modify this angle to get a new inital linkage position
theta(2,1)=theta(2,1)*pi/180; 	%Initial joint angle theta_2 converted to radians
omega(2,1)=-15;		       		%Initial angular velocity in rad/s
%Note that data given in HW is already in rad/s. No need for conversion.
alpha(2,1)=-10;                  %Initial angular acceleration in rad/s^2
% ----------------------------------------------------------------------------
wflag=1; 					%Initializes the flag of linkage existance. 
i=1;							%Initializes the counter of while loop for motion simulation.
% ----------------------------------------------------------------------------
%Checks if the linkage is beyond its limits or lengths are not permissible for a 4bar 
% ----------------------------------------------------------------------------
K1=d/a;									%Eq. (4.8a)
K4=d/b;
K5=(c^2-d^2-a^2-b^2)/(2*a*b); 	%Eq. (4.11a)
											%Make sure to have parentheses in the denominator.
D=cos(theta(2,i))-K1+K4*cos(theta(2,i))+K5;	%Preceding Eq. (4.13)
E=-2*sin(theta(2,i));
F=K1+(K4-1)*cos(theta(2,i))+K5;
if (E^2-4.*D*F<0) 									% No solution for theta_3 in Eq. (4.13).
   wflag=0;
   	% If wflag=0, The linkage is beyond its limits, or the lengths 
      %		are not permissible for a 4bar. 
      % For example, if a^2+d^2+2a*d*cos(theta_2) > (b+c)^2,
      %		the fourbar_export linkage can not be constructed.
      % At the motion limit, the fourbar_export becomes a triagle, as shown in 
      %		Figure 4.16.  If the crank is over the limit, the law of cosine will not 
      %		be valid, and the fourbar_export can not be connected.
end 
% ----------------------------------------------------------------------------
%Perform position, velocity, and acceleration analyses during motion (while loop). 
%If wflag=0, there is no need to set the linkage in motion in the following while loop.
% ----------------------------------------------------------------------------
while wflag==1     
   	%Note that "==" is a relational operator to return logical true or false.  
 		%If linkage is permissible (wflag==1), the while loop proceeds.       
% ----------------------------------------------------------------------------
%Position Analysis
% ----------------------------------------------------------------------------
theta(3,i)=2*atan((-E-sqrt(E^2-4.*D*F))/(2*D)); 				%Eq. (4.13)
	% Open configuration 
	% For crossed configuration, change the sign before sqrt.
K2=d/c;
K3=(a^2-b^2+c^2+d^2)/(2*a*c);
A=cos(theta(2,i))-K1-K2*cos(theta(2,i))+K3;
B=-2*sin(theta(2,i));
C=K1-(K2+1)*cos(theta(2,i))+K3;
theta(4,i)=2*atan((-B-sqrt(B^2-4.*A*C))/(2*A));					%Eq. (4.10)  
% ----------------------------------------------------------------------------
transmission_angle(i)=abs(theta(3,i)-theta(4,i));

if (transmission_angle(i)>pi)
transmission_angle(i)=2*pi-transmission_angle(i);
end
if (transmission_angle(i)>pi/2)
transmission_angle(i)=pi-transmission_angle(i);
end
transmission_angle(i)=transmission_angle(i)*180/pi;
%
if (i == 1)
    transmission_max = transmission_angle(1);
    transmission_min = transmission_angle(1);  
end
transmission_max = max(transmission_max, transmission_angle(i));
transmission_min = min(transmission_min, transmission_angle(i));

% set(handles.max_button,'String',transmission_max)
% set(handles.min_button,'String',transmission_min)

% ----------------------------------------------------------------------------
%Velocity Analysis
% ----------------------------------------------------------------------------
omega(3,i)=a*omega(2,i)*(sin(theta(4,i)-theta(2,i)))/(b*(sin(theta(3,i)...
  -theta(4,i))));														%Eq. (6.18a)
omega(4,i)=a*omega(2,i)*(sin(theta(2,i)-theta(3,i)))/(c*(sin(theta(4,i)...
  -theta(3,i))));														%Eq. (6.18b)
																% "..." means continuation
VA =a*omega(2,i)*(-sin(theta(2,i))+j*cos(theta(2,i)));		%Eq. (6.19a)
VB =c*omega(4,i)*(-sin(theta(4,i))+j*cos(theta(4,i)));		%Eq. (6.19c)
	%	Note that VA and VB are complex numbers.
% ----------------------------------------------------------------------------
%Acceleration Analysis
% ----------------------------------------------------------------------------
A=c*sin(theta(4,i));														%Eq. (7.12c)
B=b*sin(theta(3,i));												
C=a*alpha(2,i)*sin(theta(2,i))+a*(omega(2,i)^2)*cos(theta(2,i))...
	+b*omega(3,i)^2*cos(theta(3,i))-c*omega(4,i)^2*cos(theta(4,i));
D=c*cos(theta(4,i));
E=b*cos(theta(3,i));
F=a*alpha(2,i)*cos(theta(2,i))-a*omega(2,i)^2*sin(theta(2,i))...
	-b*omega(3,i)^2*sin(theta(3,i))+c*omega(4,i)^2*sin(theta(4,i));
alpha(3,i)= (C*D-A*F)/(A*E-B*D);										%Eq. (7.12a)
alpha(4,i)= (C*E-B*F)/(A*E-B*D);										%Eq. (7.12b)
AA=a*alpha(2,1)*(-sin(theta(2,i))+j*cos(theta(2,i)))...
	-a*omega(2,i)^2*(cos(theta(2,i))+j*sin(theta(2,i)));		%Eq. (7.13a)
AB=c*alpha(4,i)*(-sin(theta(4,i))+j*cos(theta(4,i)))...
	-c*omega(4,i)^2*(cos(theta(4,i))+j*sin(theta(4,i)));		%Eq. (7.13c)
% ----------------------------------------------------------------------------
i=i+1;		%Increses the counter to continue the while loop.
%Checks if the linkage completes a cycle. 
% ----------------------------------------------------------------------------
if (i>n+1)				%The linkage completes a cycle. 
     wflag=0;			%Signals the flag to end the while loop.
else
% ----------------------------------------------------------------------------
% Calculate theta_2, omega_2, and alpha_2 for the next position. 
% ----------------------------------------------------------------------------
omega(2,i)=omega(2,i-1); 												%Constant omega
theta(2,i)=theta(2,i-1)+delta_theta_2;								%Increases theta_2
%Alternative codes
%theta(2,i)=theta(2,1)+omega(2,1)*(delta_time*i)				%Constant omega	
%delta_theta_2=omega(2,i-1)*delta_time								%Constant omega
% Note that delta_time is not used in this program. However, delta_time is useful
%	if the results need to be compared with those from Working Model files.
% ----------------------------------------------------------------------------
%alpha(2,i)=alpha(2,i-1); 												%Constant alpha
%omega(2,i)=omega(2,i-1)+alpha(2,i-1); 							%Constant alpha
%theta(2,i)=theta(2,1)+.5*alpha(2,1)*(delta_time*i)^2			%Constant alpha
%To toggle between these two options, constant velocity or constant acceleration, 
% comment out the constant omega motion and un-comment constant angular alpha motion 
% ----------------------------------------------------------------------------
%Checks if the linkage is beyond its limits with the new theta_2.
% ----------------------------------------------------------------------------
D=cos(theta(2,i))-K1+K4*cos(theta(2,i))+K5;
E=-2*sin(theta(2,i));
F=K1+(K4-1)*cos(theta(2,i))+K5;
	if (E^2-4.*D*F<0) 				%The linkage reaches its moton limits.
  		 wflag=0;						%Signal the flag to end the while loop.
	end 									%End if
% ----------------------------------------------------------------------------
end 		%End if
end		%End while 
% ----------------------------------------------------------------------------
% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
%The following section is for animation.
% ----------------------------------------------------------------------------
XC=[];YC=[];
I13X=[];I13Y=[];I24X=[];I24Y=[];
%output=menu('Simulation Options','4bar simulation','4bar simulation with coupler curve','4bar simulation with instant centers','4bar simulation with fixed centrode');
for k=1:i-1						%"for loop" to animate linkage motion. 
	%Animation stops before the linkage reaches its moton limits or a complete cycle.   
% ----------------------------------------------------------------------------
%Calculates the coordinates of joints and the coupler point
%	based on vector equation with nomenclature in Figure 4-7.
% ----------------------------------------------------------------------------
xo2=0;									%Coordinates of point O2
yo2=0;
xo4=xo2+d*cos(theta(1,1));			%Coordinates of point O4
yo4=yo2+d*sin(theta(1,1));	
	%theta(1,k) is 0 in all HW problems.
xa=xo2+a*cos(theta(2,k));			%Coordinates of point A
ya=yo2+a*sin(theta(2,k));
xb=xa+b*cos(theta(3,k));			%Coordinates of point B
yb=ya+b*sin(theta(3,k));	
	%theta(3,k) is calculated in the position analysis section.
%Alternative codes
%xb=xo4+c*cos(theta(4,k));			%Coordinates of point B
%yb=yo4+c*sin(theta(4,k));	
xc=xa+p*cos(theta(3,k)+delta_3);	%Coordinates of coupler point 
yc=ya+p*sin(theta(3,k)+delta_3);	   
% ----------------------------------------------------------------------------
%Creates the lines representing binary links and sides of the coupler link 
% connected to the coupler point.
% ----------------------------------------------------------------------------
x_link2=[xo2 xa];			%Line of link 2
y_link2=[yo2 ya];
x_link3=[xa xb];			%Line of link 3
y_link3=[ya yb];
x_link4=[xb xo4];			%Line of link 4
y_link4=[yb yo4];
x_link1=[xo4 xo2];		%Line of link 1
y_link1=[yo4 yo2];
x_c1=[xa xc];				%Line of coupler_link side 1
y_c1=[ya yc];
x_c2=[xb xc];				%Line of coupler_link side 2
y_c2=[yb yc];
XC=[XC,xc];
YC=[YC,yc];
% ----------------------------------------------------------------------------
% Calculate the coordinate of instant centers
% ----------------------------------------------------------------------------
I13x=[xb*(yb-yo4)*(xa-xo2)-xa*(ya-yo2)*(xb-xo4)+(ya-yb)*(xb-xo4)*(xa-xo2)]/[(yb-yo4)*(xa-xo2)-(ya-yo2)*(xb-xo4)];
I13y=[yb*(xb-xo4)*(ya-yo2)-ya*(xa-xo2)*(yb-yo4)+(xa-xb)*(yb-yo4)*(ya-yo2)]/[(xb-xo4)*(ya-yo2)-(xa-xo2)*(yb-yo4)];
I24x=[xb*(yb-ya)*(xo4-xo2)-xo4*(yo4-yo2)*(xb-xa)+(yo4-yb)*(xb-xa)*(xo4-xo2)]/[(yb-ya)*(xo4-xo2)-(yo4-yo2)*(xb-xa)];
I24y=[yb*(xb-xa)*(yo4-yo2)-yo4*(xo4-xo2)*(yb-ya)+(xo4-xb)*(yb-ya)*(yo4-yo2)]/[(xb-xa)*(yo4-yo2)-(xo4-xo2)*(yb-ya)];
I13X=[I13X,I13x];
I13Y=[I13Y,I13y];
I24X=[I24X,I24x];
I24Y=[I24Y,I24y];

% val = get(h,'Value');
% switch val
% case 2 
    % --------------------------------------------------------------------
a1= str2double(get(handles.edit_a, 'String'));
b1= str2double(get(handles.edit_b, 'String'));
c1= str2double(get(handles.edit_c, 'String'));
d1= str2double(get(handles.edit_d, 'String'));
%theta1= str2double(get(handles.theta_1_button, 'String'));
theta2= str2double(get(handles.edit_theta2, 'String'));
delta= str2double(get(handles.edit_delta3, 'String'));
p1= str2double(get(handles.edit_p, 'String'));

plot(xo2,yo2,'-.ko',x_link2,y_link2,xa,ya,'-.ko',x_link3,y_link3,xb,yb,'-.ko',x_link4,y_link4,xo4,yo4,'-.ko',x_link1,y_link1,x_c1,y_c1,x_c2,y_c2, xc,yc,'o', XC,YC)
hold on;
xmin=(xo2-a);
xmax=(xo4+c);
ymin=max(yo2-a, yo4-c)-p1*cos(delta*pi/180);
ymax=max(yo2+a, yo4+c)+p1*cos(delta*pi/180);
% axis([xmin  xmax ymin ymax]*1.5)	
axis equal      
plot([xmin  xmax ]*1.4,[0 0], '-.k', [0 0],[ymin ymax]*1.2,'-.k')
hold off;
% case 3 % instant centers
%     
%  a1= str2double(get(handles.edit_a, 'String'));
% b1= str2double(get(handles.edit_b, 'String'));
% c1= str2double(get(handles.edit_c, 'String'));
% d1= str2double(get(handles.edit_d, 'String'));
% %theta1= str2double(get(handles.theta_1_button, 'String'));
% theta2= str2double(get(handles.edit_theta2, 'String'));
% delta= str2double(get(handles.edit_delta3, 'String'));
% p1= str2double(get(handles.edit_p, 'String'));
% 
% plot(xo2,yo2,'-.ko',x_link2,y_link2,xa,ya,'-.ko',x_link3,y_link3,xb,yb,'-.ko',x_link4,y_link4,xo4,yo4,'-.ko',x_link1,y_link1, I13x,I13y,'o', I24x,I24y,'o')
%       axis([xo2-a-2 xo4+c+2 yo2-a-2 yo2-a-2+(xo4+c-xo2+a+4)]*2)	
% 
% 
% 
% case 4 % coupler curve
% a1= str2double(get(handles.edit_a, 'String'));
% b1= str2double(get(handles.edit_b, 'String'));
% c1= str2double(get(handles.edit_c, 'String'));
% d1= str2double(get(handles.edit_d, 'String'));
% %theta1= str2double(get(handles.theta_1_button, 'String'));
% theta2= str2double(get(handles.edit_theta2, 'String'));
% delta= str2double(get(handles.edit_delta3, 'String'));
% p1= str2double(get(handles.edit_p, 'String'));
% 
% 
% case 5 % fixed centrode
% a1= str2double(get(handles.edit_a, 'String'));
% b1= str2double(get(handles.edit_b, 'String'));
% c1= str2double(get(handles.edit_c, 'String'));
% d1= str2double(get(handles.edit_d, 'String'));
% %theta1= str2double(get(handles.theta_1_button, 'String'));
% theta2= str2double(get(handles.edit_theta2, 'String'));
% delta= str2double(get(handles.edit_delta3, 'String'));
% p1= str2double(get(handles.edit_p, 'String'));
% 
% plot(xo2,yo2,'-.ko',x_link2,y_link2,xa,ya,'-.ko',x_link3,y_link3,xb,yb,'-.ko',x_link4,y_link4,xo4,yo4,'-.ko',x_link1,y_link1, I13x,I13y,'o', I13X,I13Y)
%       axis([xo2-a-2 xo4+c+2 yo2-a-2 yo2-a-2+(xo4+c-xo2+a+4)]*2)	
% 
% 

% end

% guidata(h,handles)

% axis([xo2-a-2 xo4+c+2 yo2-a-2 yo2-a-2+(xo4+c-xo2+a+4)]*2)	
   %axis([xmin xmax ymin ymax])
	% Automatically adjusts the range of axes to show the whole linkage in the screen 
	%   when a new linkage is created.
   % This is accomplised by making the width (xmax-xmin) equal to the height (ymax-ymin)  
   %  for proper aspect ratio.
% axis off 					%Turns off all axis lines, tick marks, and labels.
drawnow; 					%Completes pending drawing events and updates the Figure window
end 							%end "for loop"
% ----------------------------------------------------------------------------
theta=theta.*180/pi;			%Converts radians to degrees for output.



% --- Executes on button press in pushbutton_centrode.
function pushbutton_centrode_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_centrode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a1= str2double(get(handles.edit_a, 'String'));
b1= str2double(get(handles.edit_b, 'String'));
c1= str2double(get(handles.edit_c, 'String'));
d1= str2double(get(handles.edit_d, 'String'));
% theta1= str2double(get(handles.theta_1_button, 'String'));
theta1= 0;
theta2= str2double(get(handles.edit_theta2, 'String'));
delta= str2double(get(handles.edit_delta3, 'String'));
p1= str2double(get(handles.edit_p, 'String'));

%fourbar_export.m
% ----------------------------------------------------------------------------
%This program performs the position, velocity, and acceleration analyses of 
% a four-bar linkage.
% ----------------------------------------------------------------------------
%This program can be used to check HW 4.6, 4.7, 6.4, 6.6, 7.3, and 7.4 of 
% Robert Norton's Design of Machinery. All parameters are defined in figures 
% P4-1, P6-1, and P7-1 respectively. 
%Each row of tables P4-1, P6-1, and P7-1 represents a different problem.
%To work on a different problem (row), edit this file to modify the link parameters 
% (a, b, c, d, etc.) and kinematic parameters (theta_2, omega_2, alpha_2, etc.)
% ----------------------------------------------------------------------------
%In addition to calculate kinematic parameters at a single position, as in  
% HW problems, this program also caculates these parameters as the linkage goes 
% through one cycle of motion.
%One cycle of motion is either that the input link is back to the original position, 
%	or that the linkage is stopped at a motion limit. 
%Linkage motion is accomplished by increasing the crank angle (theta_2) in the 
% beginning of each loop. 
%The program also simulates linkage motion graphically.
% ----------------------------------------------------------------------------
% This program also calculates transmission angle.
% It also calculates the location of instant centers at every position and shows it in animation.
% ----------------------------------------------------------------------------
%clear
a=a1;b=b1;c=c1;d=d1;									% Length of link 2,3,4 and 1 respectively.
	%Modify these parameters to get a new linkage.   
% ----------------------------------------------------------------------------
delta_theta_2=2;									%Increment of crank angle in degrees. 
delta_theta_2=delta_theta_2*pi/180;			%Increment of crank angle converted to radians.
n=2*pi/delta_theta_2;							%Total number of animation intervals in a 
														% complete revolution.
	%Decreases delta_theta to get a smoother animation. 
   %Increases delta_theta to 360 degrees (so that n=1) for a quick calculation at 
   %	one position with no animation. This will be useful for checking HW results.    
% ----------------------------------------------------------------------------
theta=zeros(4,n+1);					%Initializes matrices.  
omega=zeros(4,n+1);					 
alpha=zeros(4,n+1);					
transmission_angle=zeros(1,n+1);
theta(1,1)=theta1;
% ----------------------------------------------------------------------------
%The first index of the matrix, from 1 to 4, denotes the link number, and the 
%	corresponding elements are theta_1, omega_2, etc.
%The second index of the matrix, from 1 to n+1, denotes the iteration number in a 
%	motion simulation. 
%For example, theta(2,1) denotes the initial joint angle of theta_2.
%The maximum number of iteration is n+1 so that the link returns to the original 
%	position. 
% ----------------------------------------------------------------------------
delta_3=delta;								%Coupler point angle in degrees. 
delta_3=delta_3*pi/180;				%Coupler point angle onverted to radians.
p=p1;										%Distance from point A to the coupler point. 
% ----------------------------------------------------------------------------
theta(2,1)=45; 						%Initial joint angle theta_2 in degrees
	%Modify this angle to get a new inital linkage position
theta(2,1)=theta(2,1)*pi/180; 	%Initial joint angle theta_2 converted to radians
omega(2,1)=-15;		       		%Initial angular velocity in rad/s
%Note that data given in HW is already in rad/s. No need for conversion.
alpha(2,1)=-10;                  %Initial angular acceleration in rad/s^2
% ----------------------------------------------------------------------------
wflag=1; 					%Initializes the flag of linkage existance. 
i=1;							%Initializes the counter of while loop for motion simulation.
% ----------------------------------------------------------------------------
%Checks if the linkage is beyond its limits or lengths are not permissible for a 4bar 
% ----------------------------------------------------------------------------
K1=d/a;									%Eq. (4.8a)
K4=d/b;
K5=(c^2-d^2-a^2-b^2)/(2*a*b); 	%Eq. (4.11a)
											%Make sure to have parentheses in the denominator.
D=cos(theta(2,i))-K1+K4*cos(theta(2,i))+K5;	%Preceding Eq. (4.13)
E=-2*sin(theta(2,i));
F=K1+(K4-1)*cos(theta(2,i))+K5;
if (E^2-4.*D*F<0) 									% No solution for theta_3 in Eq. (4.13).
   wflag=0;
   	% If wflag=0, The linkage is beyond its limits, or the lengths 
      %		are not permissible for a 4bar. 
      % For example, if a^2+d^2+2a*d*cos(theta_2) > (b+c)^2,
      %		the fourbar_export linkage can not be constructed.
      % At the motion limit, the fourbar_export becomes a triagle, as shown in 
      %		Figure 4.16.  If the crank is over the limit, the law of cosine will not 
      %		be valid, and the fourbar_export can not be connected.
end 
% ----------------------------------------------------------------------------
%Perform position, velocity, and acceleration analyses during motion (while loop). 
%If wflag=0, there is no need to set the linkage in motion in the following while loop.
% ----------------------------------------------------------------------------
while wflag==1     
   	%Note that "==" is a relational operator to return logical true or false.  
 		%If linkage is permissible (wflag==1), the while loop proceeds.       
% ----------------------------------------------------------------------------
%Position Analysis
% ----------------------------------------------------------------------------
theta(3,i)=2*atan((-E-sqrt(E^2-4.*D*F))/(2*D)); 				%Eq. (4.13)
	% Open configuration 
	% For crossed configuration, change the sign before sqrt.
K2=d/c;
K3=(a^2-b^2+c^2+d^2)/(2*a*c);
A=cos(theta(2,i))-K1-K2*cos(theta(2,i))+K3;
B=-2*sin(theta(2,i));
C=K1-(K2+1)*cos(theta(2,i))+K3;
theta(4,i)=2*atan((-B-sqrt(B^2-4.*A*C))/(2*A));					%Eq. (4.10)  
% ----------------------------------------------------------------------------
transmission_angle(i)=abs(theta(3,i)-theta(4,i));

if (transmission_angle(i)>pi)
transmission_angle(i)=2*pi-transmission_angle(i);
end
if (transmission_angle(i)>pi/2)
transmission_angle(i)=pi-transmission_angle(i);
end
transmission_angle(i)=transmission_angle(i)*180/pi;
%
if (i == 1)
    transmission_max = transmission_angle(1);
    transmission_min = transmission_angle(1);  
end
transmission_max = max(transmission_max, transmission_angle(i));
transmission_min = min(transmission_min, transmission_angle(i));

% set(handles.max_button,'String',transmission_max)
% set(handles.min_button,'String',transmission_min)

% ----------------------------------------------------------------------------
%Velocity Analysis
% ----------------------------------------------------------------------------
omega(3,i)=a*omega(2,i)*(sin(theta(4,i)-theta(2,i)))/(b*(sin(theta(3,i)...
  -theta(4,i))));														%Eq. (6.18a)
omega(4,i)=a*omega(2,i)*(sin(theta(2,i)-theta(3,i)))/(c*(sin(theta(4,i)...
  -theta(3,i))));														%Eq. (6.18b)
																% "..." means continuation
VA =a*omega(2,i)*(-sin(theta(2,i))+j*cos(theta(2,i)));		%Eq. (6.19a)
VB =c*omega(4,i)*(-sin(theta(4,i))+j*cos(theta(4,i)));		%Eq. (6.19c)
	%	Note that VA and VB are complex numbers.
% ----------------------------------------------------------------------------
%Acceleration Analysis
% ----------------------------------------------------------------------------
A=c*sin(theta(4,i));														%Eq. (7.12c)
B=b*sin(theta(3,i));												
C=a*alpha(2,i)*sin(theta(2,i))+a*(omega(2,i)^2)*cos(theta(2,i))...
	+b*omega(3,i)^2*cos(theta(3,i))-c*omega(4,i)^2*cos(theta(4,i));
D=c*cos(theta(4,i));
E=b*cos(theta(3,i));
F=a*alpha(2,i)*cos(theta(2,i))-a*omega(2,i)^2*sin(theta(2,i))...
	-b*omega(3,i)^2*sin(theta(3,i))+c*omega(4,i)^2*sin(theta(4,i));
alpha(3,i)= (C*D-A*F)/(A*E-B*D);										%Eq. (7.12a)
alpha(4,i)= (C*E-B*F)/(A*E-B*D);										%Eq. (7.12b)
AA=a*alpha(2,1)*(-sin(theta(2,i))+j*cos(theta(2,i)))...
	-a*omega(2,i)^2*(cos(theta(2,i))+j*sin(theta(2,i)));		%Eq. (7.13a)
AB=c*alpha(4,i)*(-sin(theta(4,i))+j*cos(theta(4,i)))...
	-c*omega(4,i)^2*(cos(theta(4,i))+j*sin(theta(4,i)));		%Eq. (7.13c)
% ----------------------------------------------------------------------------
i=i+1;		%Increses the counter to continue the while loop.
%Checks if the linkage completes a cycle. 
% ----------------------------------------------------------------------------
if (i>n+1)				%The linkage completes a cycle. 
     wflag=0;			%Signals the flag to end the while loop.
else
% ----------------------------------------------------------------------------
% Calculate theta_2, omega_2, and alpha_2 for the next position. 
% ----------------------------------------------------------------------------
omega(2,i)=omega(2,i-1); 												%Constant omega
theta(2,i)=theta(2,i-1)+delta_theta_2;								%Increases theta_2
%Alternative codes
%theta(2,i)=theta(2,1)+omega(2,1)*(delta_time*i)				%Constant omega	
%delta_theta_2=omega(2,i-1)*delta_time								%Constant omega
% Note that delta_time is not used in this program. However, delta_time is useful
%	if the results need to be compared with those from Working Model files.
% ----------------------------------------------------------------------------
%alpha(2,i)=alpha(2,i-1); 												%Constant alpha
%omega(2,i)=omega(2,i-1)+alpha(2,i-1); 							%Constant alpha
%theta(2,i)=theta(2,1)+.5*alpha(2,1)*(delta_time*i)^2			%Constant alpha
%To toggle between these two options, constant velocity or constant acceleration, 
% comment out the constant omega motion and un-comment constant angular alpha motion 
% ----------------------------------------------------------------------------
%Checks if the linkage is beyond its limits with the new theta_2.
% ----------------------------------------------------------------------------
D=cos(theta(2,i))-K1+K4*cos(theta(2,i))+K5;
E=-2*sin(theta(2,i));
F=K1+(K4-1)*cos(theta(2,i))+K5;
	if (E^2-4.*D*F<0) 				%The linkage reaches its moton limits.
  		 wflag=0;						%Signal the flag to end the while loop.
	end 									%End if
% ----------------------------------------------------------------------------
end 		%End if
end		%End while 
% ----------------------------------------------------------------------------
% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
%The following section is for animation.
% ----------------------------------------------------------------------------
XC=[];YC=[];
I13X=[];I13Y=[];I24X=[];I24Y=[];
%output=menu('Simulation Options','4bar simulation','4bar simulation with coupler curve','4bar simulation with instant centers','4bar simulation with fixed centrode');
for k=1:i-1						%"for loop" to animate linkage motion. 
	%Animation stops before the linkage reaches its moton limits or a complete cycle.   
% ----------------------------------------------------------------------------
%Calculates the coordinates of joints and the coupler point
%	based on vector equation with nomenclature in Figure 4-7.
% ----------------------------------------------------------------------------
xo2=0;									%Coordinates of point O2
yo2=0;
xo4=xo2+d*cos(theta(1,1));			%Coordinates of point O4
yo4=yo2+d*sin(theta(1,1));	
	%theta(1,k) is 0 in all HW problems.
xa=xo2+a*cos(theta(2,k));			%Coordinates of point A
ya=yo2+a*sin(theta(2,k));
xb=xa+b*cos(theta(3,k));			%Coordinates of point B
yb=ya+b*sin(theta(3,k));	
	%theta(3,k) is calculated in the position analysis section.
%Alternative codes
%xb=xo4+c*cos(theta(4,k));			%Coordinates of point B
%yb=yo4+c*sin(theta(4,k));	
xc=xa+p*cos(theta(3,k)+delta_3);	%Coordinates of coupler point 
yc=ya+p*sin(theta(3,k)+delta_3);	   
% ----------------------------------------------------------------------------
%Creates the lines representing binary links and sides of the coupler link 
% connected to the coupler point.
% ----------------------------------------------------------------------------
x_link2=[xo2 xa];			%Line of link 2
y_link2=[yo2 ya];
x_link3=[xa xb];			%Line of link 3
y_link3=[ya yb];
x_link4=[xb xo4];			%Line of link 4
y_link4=[yb yo4];
x_link1=[xo4 xo2];		%Line of link 1
y_link1=[yo4 yo2];
x_c1=[xa xc];				%Line of coupler_link side 1
y_c1=[ya yc];
x_c2=[xb xc];				%Line of coupler_link side 2
y_c2=[yb yc];
XC=[XC,xc];
YC=[YC,yc];
% ----------------------------------------------------------------------------
% Calculate the coordinate of instant centers
% ----------------------------------------------------------------------------
I13x=[xb*(yb-yo4)*(xa-xo2)-xa*(ya-yo2)*(xb-xo4)+(ya-yb)*(xb-xo4)*(xa-xo2)]/[(yb-yo4)*(xa-xo2)-(ya-yo2)*(xb-xo4)];
I13y=[yb*(xb-xo4)*(ya-yo2)-ya*(xa-xo2)*(yb-yo4)+(xa-xb)*(yb-yo4)*(ya-yo2)]/[(xb-xo4)*(ya-yo2)-(xa-xo2)*(yb-yo4)];
I24x=[xb*(yb-ya)*(xo4-xo2)-xo4*(yo4-yo2)*(xb-xa)+(yo4-yb)*(xb-xa)*(xo4-xo2)]/[(yb-ya)*(xo4-xo2)-(yo4-yo2)*(xb-xa)];
I24y=[yb*(xb-xa)*(yo4-yo2)-yo4*(xo4-xo2)*(yb-ya)+(xo4-xb)*(yb-ya)*(yo4-yo2)]/[(xb-xa)*(yo4-yo2)-(xo4-xo2)*(yb-ya)];
I13X=[I13X,I13x];
I13Y=[I13Y,I13y];
I24X=[I24X,I24x];
I24Y=[I24Y,I24y];

% val = get(h,'Value');
% switch val
% case 2 
    % --------------------------------------------------------------------
a1= str2double(get(handles.edit_a, 'String'));
b1= str2double(get(handles.edit_b, 'String'));
c1= str2double(get(handles.edit_c, 'String'));
d1= str2double(get(handles.edit_d, 'String'));
%theta1= str2double(get(handles.theta_1_button, 'String'));
theta2= str2double(get(handles.edit_theta2, 'String'));
delta= str2double(get(handles.edit_delta3, 'String'));
p1= str2double(get(handles.edit_p, 'String'));

% plot(xo2,yo2,'-.ko',x_link2,y_link2,xa,ya,'-.ko',x_link3,y_link3,xb,yb,'-.ko',x_link4,y_link4,xo4,yo4,'-.ko',x_link1,y_link1,x_c1,y_c1,x_c2,y_c2)
plot(xo2,yo2,'-.ko',x_link2,y_link2,xa,ya,'-.ko',x_link3,y_link3,xb,yb,'-.ko',x_link4,y_link4,xo4,yo4,'-.ko',x_link1,y_link1, I13x,I13y,'o', I13X,I13Y)
hold on;
xmin=(xo2-a);
xmax=(xo4+c);
ymin=max(yo2-a, yo4-c)-p1*cos(delta*pi/180);
ymax=max(yo2+a, yo4+c)+p1*cos(delta*pi/180);
% axis([xmin  xmax ymin ymax]*1.5)	
axis equal      
plot([xmin  xmax ]*1.4,[0 0], '-.k', [0 0],[ymin ymax]*1.2,'-.k')
hold off;
% case 3 % instant centers
%     
%  a1= str2double(get(handles.edit_a, 'String'));
% b1= str2double(get(handles.edit_b, 'String'));
% c1= str2double(get(handles.edit_c, 'String'));
% d1= str2double(get(handles.edit_d, 'String'));
% %theta1= str2double(get(handles.theta_1_button, 'String'));
% theta2= str2double(get(handles.edit_theta2, 'String'));
% delta= str2double(get(handles.edit_delta3, 'String'));
% p1= str2double(get(handles.edit_p, 'String'));
% 
%       axis([xo2-a-2 xo4+c+2 yo2-a-2 yo2-a-2+(xo4+c-xo2+a+4)]*2)	
% 
% 
% 
% case 4 % coupler curve
% a1= str2double(get(handles.edit_a, 'String'));
% b1= str2double(get(handles.edit_b, 'String'));
% c1= str2double(get(handles.edit_c, 'String'));
% d1= str2double(get(handles.edit_d, 'String'));
% %theta1= str2double(get(handles.theta_1_button, 'String'));
% theta2= str2double(get(handles.edit_theta2, 'String'));
% delta= str2double(get(handles.edit_delta3, 'String'));
% p1= str2double(get(handles.edit_p, 'String'));
% 
% plot(xo2,yo2,'-.ko',x_link2,y_link2,xa,ya,'-.ko',x_link3,y_link3,xb,yb,'-.ko',x_link4,y_link4,xo4,yo4,'-.ko',x_link1,y_link1,x_c1,y_c1,x_c2,y_c2, xc,yc,'o', XC,YC)
%       axis([xo2-a-2 xo4+c+2 yo2-a-2 yo2-a-2+(xo4+c-xo2+a+4)]*2)	
% 
% case 5 % fixed centrode
% a1= str2double(get(handles.edit_a, 'String'));
% b1= str2double(get(handles.edit_b, 'String'));
% c1= str2double(get(handles.edit_c, 'String'));
% d1= str2double(get(handles.edit_d, 'String'));
% %theta1= str2double(get(handles.theta_1_button, 'String'));
% theta2= str2double(get(handles.edit_theta2, 'String'));
% delta= str2double(get(handles.edit_delta3, 'String'));
% p1= str2double(get(handles.edit_p, 'String'));
% 
%       axis([xo2-a-2 xo4+c+2 yo2-a-2 yo2-a-2+(xo4+c-xo2+a+4)]*2)	
% 
% 

% end

% guidata(h,handles)

% axis([xo2-a-2 xo4+c+2 yo2-a-2 yo2-a-2+(xo4+c-xo2+a+4)]*2)	
   %axis([xmin xmax ymin ymax])
	% Automatically adjusts the range of axes to show the whole linkage in the screen 
	%   when a new linkage is created.
   % This is accomplised by making the width (xmax-xmin) equal to the height (ymax-ymin)  
   %  for proper aspect ratio.
% axis off 					%Turns off all axis lines, tick marks, and labels.
drawnow; 					%Completes pending drawing events and updates the Figure window
end 							%end "for loop"
% ----------------------------------------------------------------------------
theta=theta.*180/pi;			%Converts radians to degrees for output.



% --- Executes on button press in pushbutton_quit.
function pushbutton_quit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_quit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close(gcf);



% --- Executes during object creation, after setting all properties.
function edit_a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_a_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a as text
%        str2double(get(hObject,'String')) returns contents of edit_a as a double


% --- Executes during object creation, after setting all properties.



% --- Executes during object creation, after setting all properties.
function edit_b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_b_Callback(hObject, eventdata, handles)
% hObject    handle to edit_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_b as text
%        str2double(get(hObject,'String')) returns contents of edit_b as a double


% --- Executes during object creation, after setting all properties.
function edit_c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_c_Callback(hObject, eventdata, handles)
% hObject    handle to edit_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_c as text
%        str2double(get(hObject,'String')) returns contents of edit_c as a double


% --- Executes during object creation, after setting all properties.
function edit_d_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_d_Callback(hObject, eventdata, handles)
% hObject    handle to edit_d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_d as text
%        str2double(get(hObject,'String')) returns contents of edit_d as a double


% --- Executes during object creation, after setting all properties.
function edit_p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_p_Callback(hObject, eventdata, handles)
% hObject    handle to edit_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_p as text
%        str2double(get(hObject,'String')) returns contents of edit_p as a double


% --- Executes during object creation, after setting all properties.
function edit_delta3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_delta3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_delta3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_delta3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_delta3 as text
%        str2double(get(hObject,'String')) returns contents of edit_delta3 as a double


% --- Executes during object creation, after setting all properties.
function edit_theta2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_theta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_theta2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_theta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_theta2 as text
%        str2double(get(hObject,'String')) returns contents of edit_theta2 as a double


% --- Executes during object creation, after setting all properties.
function edit_omega2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_omega2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_omega2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_omega2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_omega2 as text
%        str2double(get(hObject,'String')) returns contents of edit_omega2 as a double


% --- Executes during object creation, after setting all properties.
function edit_alpha2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_alpha2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_alpha2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_alpha2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_alpha2 as text
%        str2double(get(hObject,'String')) returns contents of edit_alpha2 as a double




% --- Creates and returns a handle to the GUI figure. 
function h1 = fourbar_export_LayoutFcn(policy)
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
'Name','fourbar',...
'NumberTitle','off',...
'PaperPosition',get(0,'defaultfigurePaperPosition'),...
'Position',[80 10 112 32.3076923076923],...
'Renderer',get(0,'defaultfigureRenderer'),...
'RendererMode','manual',...
'Resize','off',...
'HandleVisibility','callback',...
'Tag','figure1',...
'UserData',zeros(1,0));

setappdata(h1, 'GUIDEOptions', struct(...
'active_h', 2.130020e+002, ...
'taginfo', struct(...
'figure', 2, ...
'text', 21, ...
'axes', 2, ...
'edit', 16, ...
'pushbutton', 6, ...
'frame', 5), ...
'override', 0, ...
'release', 13, ...
'resize', 'none', ...
'accessibility', 'callback', ...
'mfile', 1, ...
'callbacks', 1, ...
'singleton', 1, ...
'syscolorfig', 1, ...
'lastSavedFile', 'C:\summer_02\erin\matlab_r13\kinmeatics\norton\fourbar.m'));


h2 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'ListboxTop',0,...
'Position',[1.4 20.0769230769231 24.4 11.3076923076923],...
'String',{ '' },...
'Style','frame',...
'Tag','frame3');


h3 = axes(...
'Parent',h1,...
'Units','characters',...
'CameraPosition',[0.5 0.5 9.16025403784439],...
'CameraPositionMode',get(0,'defaultaxesCameraPositionMode'),...
'Color',get(0,'defaultaxesColor'),...
'ColorOrder',get(0,'defaultaxesColorOrder'),...
'Position',[26.6 3.38461538461539 80.8 23.1538461538462],...
'XColor',get(0,'defaultaxesXColor'),...
'YColor',get(0,'defaultaxesYColor'),...
'ZColor',get(0,'defaultaxesZColor'),...
'Tag','axes1');


h4 = get(h3,'title');

set(h4,...
'Parent',h3,...
'Color',[0 0 0],...
'HorizontalAlignment','center',...
'Position',[0.498762376237624 1.02159468438538 1.00005459937205],...
'VerticalAlignment','bottom',...
'HandleVisibility','off');

h5 = get(h3,'xlabel');

set(h5,...
'Parent',h3,...
'Color',[0 0 0],...
'HorizontalAlignment','center',...
'Position',[0.498762376237624 -0.0780730897009967 1.00005459937205],...
'VerticalAlignment','cap',...
'HandleVisibility','off');

h6 = get(h3,'ylabel');

set(h6,...
'Parent',h3,...
'Color',[0 0 0],...
'HorizontalAlignment','center',...
'Position',[-0.0705445544554456 0.496677740863787 1.00005459937205],...
'Rotation',90,...
'VerticalAlignment','bottom',...
'HandleVisibility','off');

h7 = get(h3,'zlabel');

set(h7,...
'Parent',h3,...
'Color',[0 0 0],...
'HorizontalAlignment','right',...
'Position',[-0.330445544554455 1.24418604651163 1.00005459937205],...
'HandleVisibility','off',...
'Visible','off');

h8 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'ListboxTop',0,...
'Position',[57.6 27 15.4 4.92307692307692],...
'String',{ '' },...
'Style','frame',...
'Tag','frame2');


h9 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'ListboxTop',0,...
'Position',[27.6 27.0769230769231 28 4.46153846153846],...
'String',{ '' },...
'Style','frame',...
'Tag','frame1');


h10 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'FontWeight','bold',...
'ListboxTop',0,...
'Position',[9.8 0.0769230769230769 90.2 1.38461538461538],...
'String','Software copyright  2004 by The McGraw-Hill Companies, Inc.',...
'Style','text',...
'Tag','text1');


h11 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback','fourbar_export(''edit_a_Callback'',gcbo,[],guidata(gcbo))',...
'FontSize',7,...
'ListboxTop',0,...
'Position',[28.6 27.5384615384615 5.6 1.61538461538462],...
'String','10',...
'Style','edit',...
'CreateFcn','fourbar_export(''edit_a_CreateFcn'',gcbo,[],guidata(gcbo))',...
'Tag','edit_a');


h12 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'ListboxTop',0,...
'Position',[30 29.1538461538462 4 1.15384615384615],...
'String','a',...
'Style','text',...
'Tag','text2');


h13 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','fourbar_export(''pushbutton_plot_4bar_Callback'',gcbo,[],guidata(gcbo))',...
'ListboxTop',0,...
'Position',[2.8 27.2307692307692 22 1.84615384615385],...
'String','Fourbar Simulation',...
'Tag','pushbutton_plot_4bar');


h14 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','fourbar_export(''pushbutton_quit_Callback'',gcbo,[],guidata(gcbo))',...
'ListboxTop',0,...
'Position',[100.8 28.3076923076923 10.2 2.38461538461538],...
'String','Quit',...
'Tag','pushbutton_quit');


h15 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','fourbar_export(''pushbutton_instant_centers_Callback'',gcbo,[],guidata(gcbo))',...
'ListboxTop',0,...
'Position',[2.6 25.0769230769231 22.2 1.76923076923077],...
'String','w/ Instant Centers',...
'Tag','pushbutton_instant_centers');


h16 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','fourbar_export(''pushbutton_plot_coupler_curve_Callback'',gcbo,[],guidata(gcbo))',...
'ListboxTop',0,...
'Position',[2.2 22.9230769230769 22.4 1.76923076923077],...
'String','w/ Coupler Curve',...
'Tag','pushbutton_plot_coupler_curve');


h17 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','fourbar_export(''pushbutton_centrode_Callback'',gcbo,[],guidata(gcbo))',...
'ListboxTop',0,...
'Position',[2.4 20.7692307692308 22.4 1.76923076923077],...
'String','w/ Fixed Centrode',...
'Tag','pushbutton_centrode');


h18 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback','fourbar_export(''edit_b_Callback'',gcbo,[],guidata(gcbo))',...
'CData',zeros(1,0),...
'FontSize',7,...
'ListboxTop',0,...
'Position',[35.2 27.7692307692308 5.6 1.38461538461538],...
'String','6',...
'Style','edit',...
'CreateFcn','fourbar_export(''edit_b_CreateFcn'',gcbo,[],guidata(gcbo))',...
'Tag','edit_b',...
'UserData',zeros(1,0));


h19 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'CData',zeros(1,0),...
'ListboxTop',0,...
'Position',[36.6 29.1538461538462 4 1.15384615384615],...
'String','b',...
'Style','text',...
'Tag','text5',...
'UserData',zeros(1,0));


h20 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback','fourbar_export(''edit_c_Callback'',gcbo,[],guidata(gcbo))',...
'FontSize',7,...
'ListboxTop',0,...
'Position',[41.6 27.5384615384615 5.8 1.61538461538462],...
'String','8',...
'Style','edit',...
'CreateFcn','fourbar_export(''edit_c_CreateFcn'',gcbo,[],guidata(gcbo))',...
'Tag','edit_c');


h21 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'ListboxTop',0,...
'Position',[43.2 29.1538461538462 4 1.15384615384615],...
'String','c',...
'Style','text',...
'Tag','text8');


h22 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback','fourbar_export(''edit_d_Callback'',gcbo,[],guidata(gcbo))',...
'CData',zeros(1,0),...
'FontSize',7,...
'ListboxTop',0,...
'Position',[48.2 27.5384615384615 5.8 1.61538461538462],...
'String','3',...
'Style','edit',...
'CreateFcn','fourbar_export(''edit_d_CreateFcn'',gcbo,[],guidata(gcbo))',...
'Tag','edit_d',...
'UserData',zeros(1,0));


h23 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'CData',zeros(1,0),...
'ListboxTop',0,...
'Position',[49.8 29.1538461538462 4 1.15384615384615],...
'String','d',...
'Style','text',...
'Tag','text9',...
'UserData',zeros(1,0));


h24 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'ListboxTop',0,...
'Position',[33.4 30.0769230769231 16.6 1.15384615384615],...
'String','Link Length',...
'Style','text',...
'Tag','text10');


h25 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback','fourbar_export(''edit_p_Callback'',gcbo,[],guidata(gcbo))',...
'FontSize',7,...
'ListboxTop',0,...
'Position',[59 27.5384615384615 5.4 1.53846153846154],...
'String','6',...
'Style','edit',...
'CreateFcn','fourbar_export(''edit_p_CreateFcn'',gcbo,[],guidata(gcbo))',...
'Tag','edit_p');


h26 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'ListboxTop',0,...
'Position',[60.2 29.1538461538462 4 1.15384615384615],...
'String','p',...
'Style','text',...
'Tag','text11');


h27 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback','fourbar_export(''edit_delta3_Callback'',gcbo,[],guidata(gcbo))',...
'CData',zeros(1,0),...
'FontSize',7,...
'ListboxTop',0,...
'Position',[66 27.6153846153846 5.2 1.53846153846154],...
'String','30',...
'Style','edit',...
'CreateFcn','fourbar_export(''edit_delta3_CreateFcn'',gcbo,[],guidata(gcbo))',...
'Tag','edit_delta3',...
'UserData',zeros(1,0));


h28 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'CData',zeros(1,0),...
'ListboxTop',0,...
'Position',[63.4 29.3076923076923 9.2 1.15384615384615],...
'String','delta 3',...
'Style','text',...
'Tag','text12',...
'UserData',zeros(1,0));


h29 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'ListboxTop',0,...
'Position',[58.6 30.3076923076923 13.8 1.46153846153846],...
'String','Coupler Pt.',...
'Style','text',...
'Tag','text15');


h30 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'ListboxTop',0,...
'Position',[3.6 29.3846153846154 20.4 1.76923076923077],...
'String','Simulation Plotting',...
'Style','text',...
'Tag','text16');


h31 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'ListboxTop',0,...
'Position',[73.8 27.0769230769231 26.6 4.76923076923077],...
'String',{ '' },...
'Style','frame',...
'Tag','frame4');


h32 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback','fourbar_export(''edit_theta2_Callback'',gcbo,[],guidata(gcbo))',...
'FontSize',7,...
'ListboxTop',0,...
'Position',[75.4 27.4615384615385 5.6 1.61538461538462],...
'String','45',...
'Style','edit',...
'CreateFcn','fourbar_export(''edit_theta2_CreateFcn'',gcbo,[],guidata(gcbo))',...
'Tag','edit_theta2');


h33 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'ListboxTop',0,...
'Position',[75.4 29 7.2 1.23076923076923],...
'String','theta',...
'Style','text',...
'Tag','text17');


h34 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback','fourbar_export(''edit_omega2_Callback'',gcbo,[],guidata(gcbo))',...
'CData',zeros(1,0),...
'FontSize',7,...
'ListboxTop',0,...
'Position',[83.2 27.6153846153846 5.8 1.46153846153846],...
'String','0',...
'Style','edit',...
'CreateFcn','fourbar_export(''edit_omega2_CreateFcn'',gcbo,[],guidata(gcbo))',...
'Tag','edit_omega2',...
'UserData',zeros(1,0));


h35 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'CData',zeros(1,0),...
'ListboxTop',0,...
'Position',[82.4 29.2307692307692 9.2 1.15384615384615],...
'String','omega',...
'Style','text',...
'Tag','text18',...
'UserData',zeros(1,0));


h36 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'ListboxTop',0,...
'Position',[74 30.1538461538462 25.6 1.61538461538462],...
'String','Initial Values of Link 2',...
'Style','text',...
'Tag','text19');


h37 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback','fourbar_export(''edit_alpha2_Callback'',gcbo,[],guidata(gcbo))',...
'CData',zeros(1,0),...
'FontSize',7,...
'ListboxTop',0,...
'Position',[91.8 27.6153846153846 5.6 1.46153846153846],...
'String','0',...
'Style','edit',...
'CreateFcn','fourbar_export(''edit_alpha2_CreateFcn'',gcbo,[],guidata(gcbo))',...
'Tag','edit_alpha2',...
'UserData',zeros(1,0));


h38 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'CData',zeros(1,0),...
'ListboxTop',0,...
'Position',[91 29.3076923076923 9.2 1.15384615384615],...
'String','alpha',...
'Style','text',...
'Tag','text20',...
'UserData',zeros(1,0));



hsingleton = h1;


% --- Handles default GUIDE GUI creation and callback dispatch
function varargout = gui_mainfcn(gui_State, varargin)


%   GUI_MAINFCN provides these command line APIs for dealing with GUIs
%
%      FOURBAR_EXPORT, by itself, creates a new FOURBAR_EXPORT or raises the existing
%      singleton*.
%
%      H = FOURBAR_EXPORT returns the handle to a new FOURBAR_EXPORT or the handle to
%      the existing singleton*.
%
%      FOURBAR_EXPORT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FOURBAR_EXPORT.M with the given input arguments.
%
%      FOURBAR_EXPORT('Property','Value',...) creates a new FOURBAR_EXPORT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".

%   Copyright 1984-2002 The MathWorks, Inc.
%   $Revision: 1.4 $ $Date: 2002/05/31 21:44:31 $

gui_StateFields =  {'gui_Name'
                    'gui_Singleton'
                    'gui_OpeningFcn'
                    'gui_OutputFcn'
                    'gui_LayoutFcn'
                    'gui_Callback'};
gui_Mfile = '';
for i=1:length(gui_StateFields)
    if ~isfield(gui_State, gui_StateFields{i})
        error('Could not find field %s in the gui_State struct in GUI M-file %s', gui_StateFields{i}, gui_Mfile);        
    elseif isequal(gui_StateFields{i}, 'gui_Name')
        gui_Mfile = [getfield(gui_State, gui_StateFields{i}), '.m'];
    end
end

numargin = length(varargin);

if numargin == 0
    % FOURBAR_EXPORT
    % create the GUI
    gui_Create = 1;
elseif numargin > 3 & ischar(varargin{1}) & ishandle(varargin{2})
    % FOURBAR_EXPORT('CALLBACK',hObject,eventData,handles,...)
    gui_Create = 0;
else
    % FOURBAR_EXPORT(...)
    % create the GUI and hand varargin to the openingfcn
    gui_Create = 1;
end

if gui_Create == 0
    varargin{1} = gui_State.gui_Callback;
    if nargout
        [varargout{1:nargout}] = feval(varargin{:});
    else
        feval(varargin{:});
    end
else
    if gui_State.gui_Singleton
        gui_SingletonOpt = 'reuse';
    else
        gui_SingletonOpt = 'new';
    end
    
    % Open fig file with stored settings.  Note: This executes all component
    % specific CreateFunctions with an empty HANDLES structure.
    
    % Do feval on layout code in m-file if it exists
    if ~isempty(gui_State.gui_LayoutFcn)
        gui_hFigure = feval(gui_State.gui_LayoutFcn, gui_SingletonOpt);
    else
        gui_hFigure = local_openfig(gui_State.gui_Name, gui_SingletonOpt);            
        % If the figure has InGUIInitialization it was not completely created
        % on the last pass.  Delete this handle and try again.
        if isappdata(gui_hFigure, 'InGUIInitialization')
            delete(gui_hFigure);
            gui_hFigure = local_openfig(gui_State.gui_Name, gui_SingletonOpt);            
        end
    end
    
    % Set flag to indicate starting GUI initialization
    setappdata(gui_hFigure,'InGUIInitialization',1);

    % Fetch GUIDE Application options
    gui_Options = getappdata(gui_hFigure,'GUIDEOptions');
    
    if ~isappdata(gui_hFigure,'GUIOnScreen')
        % Adjust background color
        if gui_Options.syscolorfig 
            set(gui_hFigure,'Color', get(0,'DefaultUicontrolBackgroundColor'));
        end

        % Generate HANDLES structure and store with GUIDATA
        guidata(gui_hFigure, guihandles(gui_hFigure));
    end
    
    % If user specified 'Visible','off' in p/v pairs, don't make the figure
    % visible.
    gui_MakeVisible = 1;
    for ind=1:2:length(varargin)
        if length(varargin) == ind
            break;
        end
        len1 = min(length('visible'),length(varargin{ind}));
        len2 = min(length('off'),length(varargin{ind+1}));
        if ischar(varargin{ind}) & ischar(varargin{ind+1}) & ...
                strncmpi(varargin{ind},'visible',len1) & len2 > 1
            if strncmpi(varargin{ind+1},'off',len2)
                gui_MakeVisible = 0;
            elseif strncmpi(varargin{ind+1},'on',len2)
                gui_MakeVisible = 1;
            end
        end
    end
    
    % Check for figure param value pairs
    for index=1:2:length(varargin)
        if length(varargin) == index
            break;
        end
        try, set(gui_hFigure, varargin{index}, varargin{index+1}), catch, break, end
    end

    % If handle visibility is set to 'callback', turn it on until finished
    % with OpeningFcn
    gui_HandleVisibility = get(gui_hFigure,'HandleVisibility');
    if strcmp(gui_HandleVisibility, 'callback')
        set(gui_hFigure,'HandleVisibility', 'on');
    end
    
    feval(gui_State.gui_OpeningFcn, gui_hFigure, [], guidata(gui_hFigure), varargin{:});
    
    if ishandle(gui_hFigure)
        % Update handle visibility
        set(gui_hFigure,'HandleVisibility', gui_HandleVisibility);
        
        % Make figure visible
        if gui_MakeVisible
            set(gui_hFigure, 'Visible', 'on')
            if gui_Options.singleton 
                setappdata(gui_hFigure,'GUIOnScreen', 1);
            end
        end

        % Done with GUI initialization
        rmappdata(gui_hFigure,'InGUIInitialization');
    end
    
    % If handle visibility is set to 'callback', turn it on until finished with
    % OutputFcn
    if ishandle(gui_hFigure)
        gui_HandleVisibility = get(gui_hFigure,'HandleVisibility');
        if strcmp(gui_HandleVisibility, 'callback')
            set(gui_hFigure,'HandleVisibility', 'on');
        end
        gui_Handles = guidata(gui_hFigure);
    else
        gui_Handles = [];
    end
    
    if nargout
        [varargout{1:nargout}] = feval(gui_State.gui_OutputFcn, gui_hFigure, [], gui_Handles);
    else
        feval(gui_State.gui_OutputFcn, gui_hFigure, [], gui_Handles);
    end
    
    if ishandle(gui_hFigure)
        set(gui_hFigure,'HandleVisibility', gui_HandleVisibility);
    end
end    

function gui_hFigure = local_openfig(name, singleton)
if nargin('openfig') == 3 
    gui_hFigure = openfig(name, singleton, 'auto');
else
    % OPENFIG did not accept 3rd input argument until R13,
    % toggle default figure visible to prevent the figure
    % from showing up too soon.
    gui_OldDefaultVisible = get(0,'defaultFigureVisible');
    set(0,'defaultFigureVisible','off');
    gui_hFigure = openfig(name, singleton);
    set(0,'defaultFigureVisible',gui_OldDefaultVisible);
end

