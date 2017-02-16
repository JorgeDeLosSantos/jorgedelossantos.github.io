function varargout = slider_crank_export(varargin)
% SLIDER_CRANK_EXPORT M-file for slider_crank_export.fig
%      SLIDER_CRANK_EXPORT, by itself, creates a new SLIDER_CRANK_EXPORT or raises the existing
%      singleton*.
%
%      H = SLIDER_CRANK_EXPORT returns the handle to a new SLIDER_CRANK_EXPORT or the handle to
%      the existing singleton*.
%
%      SLIDER_CRANK_EXPORT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SLIDER_CRANK_EXPORT.M with the given input arguments.
%
%      SLIDER_CRANK_EXPORT('Property','Value',...) creates a new SLIDER_CRANK_EXPORT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before slider_crank_export_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to slider_crank_export_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help slider_crank_export

% Last Modified by GUIDE v2.5 19-Sep-2002 22:24:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @slider_crank_export_OpeningFcn, ...
                   'gui_OutputFcn',  @slider_crank_export_OutputFcn, ...
                   'gui_LayoutFcn',  @slider_crank_export_LayoutFcn, ...
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


% --- Executes just before slider_crank_export is made visible.
function slider_crank_export_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to slider_crank_export (see VARARGIN)

% Choose default command line output for slider_crank_export
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes slider_crank_export wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = slider_crank_export_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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
function edit_pressure_angle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pressure_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_pressure_angle_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pressure_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pressure_angle as text
%        str2double(get(hObject,'String')) returns contents of edit_pressure_angle as a double


% --- Executes during object creation, after setting all properties.
function edit_diametral_pitch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_diametral_pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_diametral_pitch_Callback(hObject, eventdata, handles)
% hObject    handle to edit_diametral_pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_diametral_pitch as text
%        str2double(get(hObject,'String')) returns contents of edit_diametral_pitch as a double


% --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A= str2double(get(handles.edit_a, 'String'));
B= str2double(get(handles.edit_b, 'String'));
C= str2double(get(handles.edit_c, 'String'));
thetah= str2double(get(handles.edit_theta2, 'String'));
%==================================================================
% slider_crank_export.m
% ----------------------------------------------------------------------------
%This program performs the position, velocity, and acceleration analyses of 
% a slider-crank linkage.
% ----------------------------------------------------------------------------
%This program can be used to check HW 4.9, 4.10, 6.8, 6.9, 7.5, and 7.6 of 
% Robert Norton's Design of Machinery. All parameters are defined in 
%  figures P4-2, P6-2, and P7-2 respectively. 
%Each row of tables P4-2, P6-2, and P7-2 represents a different problem.
%To work on a different problem (row), edit this file to modify the link parameters 
% (a, b, c, etc.) and kinematic parameters (theta_2, omega_2, alpha_2, etc.)
% ----------------------------------------------------------------------------
%In addition to calculate kinematic parameters at a single position, as in  
% HW problems, this program also caculates these parameters as the linkage goes 
% through one cycle of motion.
%One cycle is either that the input link is back to the original position, or that 
%	the linkage is stopped at a motion limit. 
%Linkage motion is accomplished by increasing the crank angle (theta_2) in the 
% beginning of each loop. 
%The program also simulates linkage motion graphically.
% ----------------------------------------------------------------------------
a=A;b=B;c=C;				% Length of link 2, 3, and the offset distance respectively.
	%Modify these parameters to get a new linkage.
% ----------------------------------------------------------------------------
delta_theta_2=30;								%Increment of crank angle in degrees 
delta_theta_2=delta_theta_2*pi/180;		%Increment of crank angle converted to radians
n=2*pi/delta_theta_2;						%Total number of animation intervals in a 
													%complete revolution
	%Decrease delta_theta to get a smoother animation. 
   %Increases delta_theta to 360 degrees (so that n=1) for a quick calculation at 
   %	one position with no animation. This will be useful for checking HW results.    
% ----------------------------------------------------------------------------
theta=zeros(4,n+1);					%Initializes matrices.  
omega=zeros(4,n+1);					   
alpha=zeros(4,n+1);					   
% ----------------------------------------------------------------------------
%The first index of the matrix, from 1 to 4, denotes the link number, and the 
%	corresponding elements are theta_1, omega_2, etc.
%The second index of the matrix, from 1 to n+1, denotes the iteration number in a 
%	motion simulation. 
%For example, theta(2,1) denotes the initial joint angle of theta_2.
%The maximum number of iteration is n+1 so that the link returns to the original 
%	position after n different position. 
% ----------------------------------------------------------------------------
theta(2,1)=thetah;						%Initial joint angle theta_2 in degrees
	%Modify this angle to get a new inital linkage position
theta(2,1)=theta(2,1)*pi/180; 	%Initial joint angle theta_2 converted to radians
omega(2,1)=24;		       			%Initial angular velocity in rad/s
    %Data given in HW is already in rad/s. No need for conversion.
alpha(2,1)=-4;                  	%Initial angular acceleration in rad/s^2
% ----------------------------------------------------------------------------
d=zeros(1,n+1);              		%Initial d vector 
												% Note that a vector is a matrix with one row.  
d_dot=zeros(1,n+1);           	%Initial d_dot vector
dd_dot=zeros(1,n+1);          	%Initial dd_dot vector
% ----------------------------------------------------------------------------
wflag=1; 					%Initializes the flag of linkage existance. 
i=1;							%Initializes the counter of while loop for motion simulation.
% ----------------------------------------------------------------------------
%Checks if the linkage is beyond its limits or lengths are not permissible for 
%  a slider crank. 
% ----------------------------------------------------------------------------
if (abs(a*sin(theta(2,i))-c)>b)  % No solution for theta_3 in Eq.(4.16a)
   wflag=0;								% The lengths are not permissible for a slider crank.
end 
% If a+b<c (theta(2,i)=90 deg), the linkage can not be physically connected. 
%	The linkage is therefore not permissible.
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
theta(3,i)=asin((a*sin(theta(2,i))-c)/b);    %Eq. (4.16a)
	% Open configuration 
   % For crossed configuration, use Eq.(4.17)	
d(1,i)=a*cos(theta(2,i))-b*cos(theta(3,i));	%Eq. (4.16b)
% ----------------------------------------------------------------------------
%Velocity Analysis
% ---------------------------------------------------------------------------
omega(3,i)=(a*cos(theta(2,i))/(b*cos(theta(3,i))))*omega(2,i);				%Eq.(6.22a)
d_dot(1,i)=-a*omega(2,i)*sin(theta(2,i))+b*omega(3,i)*sin(theta(3,i));	%Eq.(6.22b)
% ----------------------------------------------------------------------------
%Acceleration Analysis
% ----------------------------------------------------------------------------
alpha(3,i)=(a*alpha(2,i)*cos(theta(2,i))-a*(omega(2,i)^2)*sin(theta(2,i))+...
      b*(omega(3,i)^2)*sin(theta(3,i)))/(b*cos(theta(3,i)));			%Eq.(7.16d)
dd_dot(1,i)=-a*alpha(2,i)*sin(theta(2,i))-a*(omega(2,i)^2)*cos(theta(2,i))+...
      b*alpha(3,i)*sin(theta(3,i))+b*(omega(3,i)^2)*cos(theta(3,i));	%Eq.(7.16e)
% ----------------------------------------------------------------------------
i=i+1;		%Increses the counter to continue the while loop.
%Checks if the linkage reaches a complete cycle. 
% ----------------------------------------------------------------------------
if (i>n+1)				%The linkage reaches a complete cycle. 
     wflag=0;			%Signals the flag to end the while loop.
else
% ----------------------------------------------------------------------------
% Calculates theta_2, omega_2, and alpha_2 for the next position. 
% ----------------------------------------------------------------------------
omega(2,i)=omega(2,i-1); 												%Constant omega
theta(2,i)=theta(2,i-1)+delta_theta_2;								%Increases theta_2
%Alternative codes
%delta_theta_2=omega(2,i-1)*delta_time								%Constant omega
%theta(2,i)=theta(2,1)+omega(2,1)*(delta_time*i)				%Increases theta_2
%Note that delta_time	is not used in this program. However, delta_time is useful
%	if the results need to be compared with those from Working Model files.
% ----------------------------------------------------------------------------
%alpha(2,i)=alpha(2,i-1); 												%Constant alpha
%Alternative codes
%theta(2,i)=theta(2,1)+.5*alpha(2,1)*(delta_time*i)^2			%Constant alpha
%omega(2,i)=omega(2,i-1)+alpha(2,i-1); 							%Constant alpha
%To toggle between these two options, constant velocity or constant acceleration, 
% comment out the constant omega motion and un-comment constant angular alpha motion 
% ----------------------------------------------------------------------------
end 		%End if
end		%End while 
% ----------------------------------------------------------------------------
% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
%The following section is for animation.
% ----------------------------------------------------------------------------
for k=1:i-1						%"for loop" animates linkage motion. 
	%Animation stops at a complete cycle.   
% ----------------------------------------------------------------------------
%Calculates the coordinates of joints and points defining the track
%	based on vector equation with nomenclature in Figure 4-9.
% ----------------------------------------------------------------------------
xo2=0;									%Coordinates of point O2
yo2=0;
xa=xo2+a*cos(theta(2,k));			%Coordinates of point A
ya=yo2+a*sin(theta(2,k));
xb=d(k);									%Coordinates of point B 
yb=c;	
	%d(k) is calculated in the position analysis section of this program.
xt1=d(1)-5;								%Coordinates of the left end of the track
yt1=c;
xt2=xt1+10;             		   %Coordinates of the right end of the track
yt2=c;
% ----------------------------------------------------------------------------
%Creates the lines representing binary links and the track.
% ----------------------------------------------------------------------------
x_link2=[xo2 xa];			%Line of link 2
y_link2=[yo2 ya];
x_link3=[xa xb];			%Line of link 3
y_link3=[ya yb];
x_link1=[xt1 xt2];		%Line of link 1 - slider track.
y_link1=[yt1 yt2];
% ----------------------------------------------------------------------------
plot(x_link2,y_link2,x_link3,y_link3,x_link1,y_link1)
	%plot(X1,Y1,...)	
	% Plots all lines defined by Xn versus Yn pairs. 
axis([xt1 xt1+20 -10 10])
   %axis([xmin xmax ymin ymax])
	% Automatically adjusts the range of axes to show the whole linkage in the screen 
	%   when a new linkage is created.
   % This is accomplised by making the width (xmax-xmin) equal to the height (ymax-ymin)  
   %  for proper aspect ratio.
axis off 					%Turns off all axis lines, tick marks, and labels.
drawnow; 					%Completes pending drawing events and updates the figure window.
end 							%Ends "for loop".
% ----------------------------------------------------------------------------
theta=theta.*180/pi;			%Converts radians to degrees for output.
% ----------------------------------------------------------------------------




% --- Executes on button press in pushbutton_quit.
function pushbutton_quit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_quit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close(gcf);


% --- Executes on button press in pushbutton_instant_centers.
function pushbutton_instant_centers_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_instant_centers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_plot_coupler_curve.
function pushbutton_plot_coupler_curve_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot_coupler_curve (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_cnetrode.
function pushbutton_cnetrode_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_cnetrode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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
function h1 = slider_crank_export_LayoutFcn(policy)
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
'Name','slider_crank',...
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
'active_h', 1.120010e+002, ...
'taginfo', struct(...
'figure', 2, ...
'text', 22, ...
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
'lastSavedFile', 'C:\summer_02\erin\matlab_r13\kinmeatics\norton\slider_crank.m'));


h2 = axes(...
'Parent',h1,...
'Units','characters',...
'CameraPosition',[0.5 0.5 9.16025403784439],...
'CameraPositionMode',get(0,'defaultaxesCameraPositionMode'),...
'Color',get(0,'defaultaxesColor'),...
'ColorOrder',get(0,'defaultaxesColorOrder'),...
'Position',[13 2.30769230769231 87.8 24.2307692307692],...
'XColor',get(0,'defaultaxesXColor'),...
'YColor',get(0,'defaultaxesYColor'),...
'ZColor',get(0,'defaultaxesZColor'),...
'Tag','axes1');


h3 = get(h2,'title');

set(h3,...
'Parent',h2,...
'Color',[0 0 0],...
'HorizontalAlignment','center',...
'Position',[0.5 1.02063492063492 1.00005459937205],...
'VerticalAlignment','bottom',...
'HandleVisibility','off');

h4 = get(h2,'xlabel');

set(h4,...
'Parent',h2,...
'Color',[0 0 0],...
'HorizontalAlignment','center',...
'Position',[0.497722095671982 -0.0746031746031746 1.00005459937205],...
'VerticalAlignment','cap',...
'HandleVisibility','off');

h5 = get(h2,'ylabel');

set(h5,...
'Parent',h2,...
'Color',[0 0 0],...
'HorizontalAlignment','center',...
'Position',[-0.0649202733485194 0.496825396825397 1.00005459937205],...
'Rotation',90,...
'VerticalAlignment','bottom',...
'HandleVisibility','off');

h6 = get(h2,'zlabel');

set(h6,...
'Parent',h2,...
'Color',[0 0 0],...
'HorizontalAlignment','right',...
'Position',[-0.149202733485194 1.23333333333333 1.00005459937205],...
'HandleVisibility','off',...
'Visible','off');

h7 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'ListboxTop',0,...
'Position',[20.8 27.2307692307692 28 4.46153846153846],...
'String',{ '' },...
'Style','frame',...
'Tag','frame1');


h8 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'FontWeight','bold',...
'ListboxTop',0,...
'Position',[9.8 0.0769230769230769 90.2 1.38461538461538],...
'String','Software copyright  2004 by The McGraw-Hill Companies, Inc.',...
'Style','text',...
'Tag','text1');


h9 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback','slider_crank_export(''edit_a_Callback'',gcbo,[],guidata(gcbo))',...
'FontSize',7,...
'ListboxTop',0,...
'Position',[23 27.6923076923077 4.4 1.61538461538462],...
'String','3.5',...
'Style','edit',...
'CreateFcn','slider_crank_export(''edit_a_CreateFcn'',gcbo,[],guidata(gcbo))',...
'Tag','edit_a');


h10 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'ListboxTop',0,...
'Position',[23.2 29.3076923076923 4 1.15384615384615],...
'String','a',...
'Style','text',...
'Tag','text2');


h11 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','slider_crank_export(''pushbutton_plot_Callback'',gcbo,[],guidata(gcbo))',...
'ListboxTop',0,...
'Position',[2.8 28.3076923076923 10.8 2.53846153846154],...
'String','Plot',...
'Tag','pushbutton_plot');


h12 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','slider_crank_export(''pushbutton_quit_Callback'',gcbo,[],guidata(gcbo))',...
'ListboxTop',0,...
'Position',[100.8 28.3076923076923 10.2 2.38461538461538],...
'String','Quit',...
'Tag','pushbutton_quit');


h13 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback','slider_crank_export(''edit_b_Callback'',gcbo,[],guidata(gcbo))',...
'CData',zeros(1,0),...
'FontSize',7,...
'ListboxTop',0,...
'Position',[29.6 27.6923076923077 4.4 1.61538461538462],...
'String','10',...
'Style','edit',...
'CreateFcn','slider_crank_export(''edit_b_CreateFcn'',gcbo,[],guidata(gcbo))',...
'Tag','edit_b',...
'UserData',zeros(1,0));


h14 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'CData',zeros(1,0),...
'ListboxTop',0,...
'Position',[29.8 29.3076923076923 4 1.15384615384615],...
'String','b',...
'Style','text',...
'Tag','text5',...
'UserData',zeros(1,0));


h15 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback','slider_crank_export(''edit_c_Callback'',gcbo,[],guidata(gcbo))',...
'FontSize',7,...
'ListboxTop',0,...
'Position',[39.6 27.7692307692308 4.4 1.61538461538462],...
'String','1',...
'Style','edit',...
'CreateFcn','slider_crank_export(''edit_c_CreateFcn'',gcbo,[],guidata(gcbo))',...
'Tag','edit_c');


h16 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'ListboxTop',0,...
'Position',[38.4 30.0769230769231 7.4 1.30769230769231],...
'String','Offset ',...
'Style','text',...
'Tag','text8');


h17 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'ListboxTop',0,...
'Position',[21.2 30.3076923076923 15.8 1.15384615384615],...
'String','Link Length',...
'Style','text',...
'Tag','text10');


h18 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'ListboxTop',0,...
'Position',[71.4 27.0769230769231 29 4.76923076923077],...
'String',{ '' },...
'Style','frame',...
'Tag','frame4');


h19 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback','slider_crank_export(''edit_theta2_Callback'',gcbo,[],guidata(gcbo))',...
'FontSize',7,...
'ListboxTop',0,...
'Position',[75.2 27.4615384615385 5.8 1.69230769230769],...
'String','120',...
'Style','edit',...
'CreateFcn','slider_crank_export(''edit_theta2_CreateFcn'',gcbo,[],guidata(gcbo))',...
'Tag','edit_theta2');


h20 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'ListboxTop',0,...
'Position',[75.4 29 7.2 1.23076923076923],...
'String','theta',...
'Style','text',...
'Tag','text17');


h21 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback','slider_crank_export(''edit_omega2_Callback'',gcbo,[],guidata(gcbo))',...
'CData',zeros(1,0),...
'FontSize',7,...
'ListboxTop',0,...
'Position',[83 27.5384615384615 5.6 1.46153846153846],...
'String','0',...
'Style','edit',...
'CreateFcn','slider_crank_export(''edit_omega2_CreateFcn'',gcbo,[],guidata(gcbo))',...
'Tag','edit_omega2',...
'UserData',zeros(1,0));


h22 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'CData',zeros(1,0),...
'ListboxTop',0,...
'Position',[82.4 29.2307692307692 9.2 1.15384615384615],...
'String','omega',...
'Style','text',...
'Tag','text18',...
'UserData',zeros(1,0));


h23 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'ListboxTop',0,...
'Position',[74 30.1538461538462 25.6 1.61538461538462],...
'String','Initial Values of Link 2',...
'Style','text',...
'Tag','text19');


h24 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback','slider_crank_export(''edit_alpha2_Callback'',gcbo,[],guidata(gcbo))',...
'CData',zeros(1,0),...
'FontSize',7,...
'ListboxTop',0,...
'Position',[91.6 27.6153846153846 5.6 1.61538461538462],...
'String','0',...
'Style','edit',...
'CreateFcn','slider_crank_export(''edit_alpha2_CreateFcn'',gcbo,[],guidata(gcbo))',...
'Tag','edit_alpha2',...
'UserData',zeros(1,0));


h25 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'CData',zeros(1,0),...
'ListboxTop',0,...
'Position',[91 29.3076923076923 9.2 1.15384615384615],...
'String','alpha',...
'Style','text',...
'Tag','text20',...
'UserData',zeros(1,0));


h26 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'CData',zeros(1,0),...
'ListboxTop',0,...
'Position',[40 29.2307692307692 4 1.15384615384615],...
'String','c',...
'Style','text',...
'Tag','text21',...
'UserData',zeros(1,0));



hsingleton = h1;


% --- Handles default GUIDE GUI creation and callback dispatch
function varargout = gui_mainfcn(gui_State, varargin)


%   GUI_MAINFCN provides these command line APIs for dealing with GUIs
%
%      SLIDER_CRANK_EXPORT, by itself, creates a new SLIDER_CRANK_EXPORT or raises the existing
%      singleton*.
%
%      H = SLIDER_CRANK_EXPORT returns the handle to a new SLIDER_CRANK_EXPORT or the handle to
%      the existing singleton*.
%
%      SLIDER_CRANK_EXPORT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SLIDER_CRANK_EXPORT.M with the given input arguments.
%
%      SLIDER_CRANK_EXPORT('Property','Value',...) creates a new SLIDER_CRANK_EXPORT or raises the
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
    % SLIDER_CRANK_EXPORT
    % create the GUI
    gui_Create = 1;
elseif numargin > 3 & ischar(varargin{1}) & ishandle(varargin{2})
    % SLIDER_CRANK_EXPORT('CALLBACK',hObject,eventData,handles,...)
    gui_Create = 0;
else
    % SLIDER_CRANK_EXPORT(...)
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

