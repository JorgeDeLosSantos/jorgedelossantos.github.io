function varargout = cam(varargin)
% CAM M-file for cam.fig
%      CAM, by itself, creates a new CAM or raises the existing
%      singleton*.
%
%      H = CAM returns the handle to a new CAM or the handle to
%      the existing singleton*.
%
%      CAM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CAM.M with the given input arguments.
%
%      CAM('Property','Value',...) creates a new CAM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cam_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cam_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cam

% Last Modified by GUIDE v2.5 24-Sep-2002 06:55:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cam_OpeningFcn, ...
                   'gui_OutputFcn',  @cam_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
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


% --- Executes just before cam is made visible.
function cam_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cam (see VARARGIN)

% Choose default command line output for cam
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes cam wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = cam_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in pushbutton_plot_cam_profile.
function pushbutton_plot_cam_profile_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot_cam_profile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


betapi1= str2double(get(handles.edit_rise, 'String'));
beta(1)= betapi1*(pi/180);
betapi2= str2double(get(handles.edit_dwell, 'String'));
beta(2)= betapi1*(pi/180);
betapi3= str2double(get(handles.edit_fall, 'String'));
beta(3)= betapi3*(pi/180);
format long;
r=str2double(get(handles.edit_base_radius,'String'));
r_r=str2double(get(handles.edit_roller_radius,'String'));
h=str2double(get(handles.edit_lift,'String'));
global funoption


   switch funoption
   case 1
		[s,v,a,j,theta]=fun_harmonic(beta(1),h);
		s1=s;v1=v;a1=a;j1=j;Theta1=theta;
      
      [s,v,a,j,theta]=fun_harmonic(beta(3),h);
		s3=h-s;v3=-v;a3=-a;j3=-j;Theta3=theta+beta(1)+beta(2);
	case 2
		[s,v,a,j,theta]=fun_mod_trap(beta(1),h);
		s1=s;v1=v;a1=a;j1=j;Theta1=theta;
      
      [s,v,a,j,theta]=fun_mod_trap(beta(3),h);
		s3=h-s;v3=-v;a3=-a;j3=-j;Theta3=theta+beta(1)+beta(2);
	case 3
		[s,v,a,j,theta]=fun_mod_sine(beta(1),h);
		s1=s;v1=v;a1=a;j1=j;Theta1=theta;
      
      [s,v,a,j,theta]=fun_mod_sine(beta(3),h);
		s3=h-s;v3=-v;a3=-a;j3=-j;Theta3=theta+beta(1)+beta(2);
	case 4
		[s,v,a,j,theta]=fun_three_four_five(beta(1),h);
		s1=s;v1=v;a1=a;j1=j;Theta1=theta;
      
      [s,v,a,j,theta]=fun_three_four_five(beta(3),h);
		s3=h-s;v3=-v;a3=-a;j3=-j;Theta3=theta+beta(1)+beta(2);
	case 5
		[s,v,a,j,theta]=fun_cycloidal(beta(1),h);
		s1=s;v1=v;a1=a;j1=j;Theta1=theta;
      
      [s,v,a,j,theta]=fun_cycloidal(beta(3),h);
		s3=h-s;v3=-v;a3=-a;j3=-j;Theta3=theta+beta(1)+beta(2);
	case 6
		[s,v,a,j,theta]=fun_four_five_six_seven(beta(1),h);
		s1=s;v1=v;a1=a;j1=j;Theta1=theta;
      
      [s,v,a,j,theta]=fun_four_five_six_seven(beta(3),h);
		s3=h-s;v3=-v;a3=-a;j3=-j;Theta3=theta+beta(1)+beta(2);
   end   
   
   %The first dwell.
	i=1;
	dtheta2=beta(2)/160;
	for theta2=0:dtheta2:beta(2)
   	s2(i)=h;
   	v2(i)=0;
   	a2(i)=0;
   	j2(i)=0;
   	i=i+1;
	end
	Theta2=beta(1):dtheta2:beta(1)+beta(2);
   
   %The second dwell.
	i=1;
	dtheta4=(2*pi-beta(1)-beta(2)-beta(3))/160;
	for theta4=0:dtheta4:2*pi-beta(1)-beta(2)-beta(3)
	   s4(i)=0;
   	v4(i)=0; 
   	a4(i)=0;
   	j4(i)=0;
   	i=i+1;
	end
	Theta4=beta(1)+beta(2)+beta(3):dtheta4:2*pi;

	S=[s1,s2,s3,s4];
	V=[v1,v2,v3,v4];
	A=[a1,a2,a3,a4];
	J=[j1,j2,j3,j4];
   Theta=[Theta1,Theta2,Theta3,Theta4];
   
   rt=r+S;
   r_contour=r_r+rt;
   plot(r*cos(Theta),r*sin(Theta),'--',rt.*cos(Theta),rt.*sin(Theta),'-.',...
       r_contour.*cos(Theta),r_contour.*sin(Theta))
   axis([-12,12,-10,10])

   
   
function pushbutton_plot_svaj_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot_svaj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global funoption
	Theta=[];S=[];V=[];J=[];

betapi1= str2double(get(handles.edit_rise, 'String'));
beta(1)= betapi1*(pi/180);
betapi2= str2double(get(handles.edit_dwell, 'String'));
beta(2)= betapi1*(pi/180);
betapi3= str2double(get(handles.edit_fall, 'String'));
beta(3)= betapi3*(pi/180);
format long;
r=str2double(get(handles.edit_base_radius,'String'));
h=str2double(get(handles.edit_lift,'String'));
   
   
   %funoption=get(FeditHndl,'Value');
global funoption
%funoption=1;
   switch funoption
   case 1
		[s,v,a,j,theta]=fun_harmonic(beta(1),h);
		s1=s;v1=v;a1=a;j1=j;Theta1=theta;
      
      [s,v,a,j,theta]=fun_harmonic(beta(3),h);
		s3=h-s;v3=-v;a3=-a;j3=-j;Theta3=theta+beta(1)+beta(2);
	case 2
		[s,v,a,j,theta]=fun_mod_trap(beta(1),h);
		s1=s;v1=v;a1=a;j1=j;Theta1=theta;
      
      [s,v,a,j,theta]=fun_mod_trap(beta(3),h);
		s3=h-s;v3=-v;a3=-a;j3=-j;Theta3=theta+beta(1)+beta(2);
	case 3
		[s,v,a,j,theta]=fun_mod_sine(beta(1),h);
		s1=s;v1=v;a1=a;j1=j;Theta1=theta;
      
      [s,v,a,j,theta]=fun_mod_sine(beta(3),h);
		s3=h-s;v3=-v;a3=-a;j3=-j;Theta3=theta+beta(1)+beta(2);
	case 4
		[s,v,a,j,theta]=fun_three_four_five(beta(1),h);
		s1=s;v1=v;a1=a;j1=j;Theta1=theta;
      
      [s,v,a,j,theta]=fun_three_four_five(beta(3),h);
		s3=h-s;v3=-v;a3=-a;j3=-j;Theta3=theta+beta(1)+beta(2);
	case 5
		[s,v,a,j,theta]=fun_cycloidal(beta(1),h);
		s1=s;v1=v;a1=a;j1=j;Theta1=theta;
      
      [s,v,a,j,theta]=fun_cycloidal(beta(3),h);
		s3=h-s;v3=-v;a3=-a;j3=-j;Theta3=theta+beta(1)+beta(2);
	case 6
		[s,v,a,j,theta]=fun_four_five_six_seven(beta(1),h);
		s1=s;v1=v;a1=a;j1=j;Theta1=theta;
      
      [s,v,a,j,theta]=fun_four_five_six_seven(beta(3),h);
		s3=h-s;v3=-v;a3=-a;j3=-j;Theta3=theta+beta(1)+beta(2);
   end   
   
   %The first dwell.
	i=1;
	dtheta2=beta(2)/160;
	for theta2=0:dtheta2:beta(2)
   	s2(i)=h;
   	v2(i)=0;
   	a2(i)=0;
   	j2(i)=0;
   	i=i+1;
	end
	Theta2=beta(1):dtheta2:beta(1)+beta(2);
   
   %The second dwell.
	i=1;
	dtheta4=(2*pi-beta(1)-beta(2)-beta(3))/160;
	for theta4=0:dtheta4:2*pi-beta(1)-beta(2)-beta(3)
	   s4(i)=0;
   	v4(i)=0; 
   	a4(i)=0;
   	j4(i)=0;
   	i=i+1;
	end
	Theta4=beta(1)+beta(2)+beta(3):dtheta4:2*pi;

	S=[s1,s2,s3,s4];
	V=[v1,v2,v3,v4];
	A=[a1,a2,a3,a4];
	J=[j1,j2,j3,j4];
   Theta=[Theta1,Theta2,Theta3,Theta4];
   figure(2)
	subplot(4,1,1);plot(Theta*180/pi,S)
	xlim([0 360])
	set(gca,'yticklabel','0|s      2|4')
	text(370,0,'\theta','HorizontalAlignment','left','VerticalAlignment','top')
	subplot(4,1,2);plot(Theta*180/pi,V)
	xlim([0 360])
	set(gca,'yticklabel','-10|v      0|10')
	text(370,-5,'\theta','HorizontalAlignment','left','VerticalAlignment','top')
	subplot(4,1,3);plot(Theta*180/pi,A)
	xlim([0 360])
	set(gca,'yticklabel','-50|a      0|50')
	text(370,-7,'\theta','HorizontalAlignment','left','VerticalAlignment','bottom')
	subplot(4,1,4);plot(Theta*180/pi,J)
	xlim([0 360]);
	set(gca,'yticklabel','-2000|j      0|2000')
   text(370,-80,'\theta','HorizontalAlignment','left','VerticalAlignment','bottom')
  % set([ProfiHndl DiagrHndl closeHndl FeditHndl ReditHndl HeditHndl AeditHndl],'Enable','on');




% --- Executes on button press in pushbutton_quit.
function pushbutton_quit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_quit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close(gcf);


% --- Executes during object creation, after setting all properties.
function edit_lift_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lift (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_lift_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lift (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lift as text
%        str2double(get(hObject,'String')) returns contents of edit_lift as a double


% --- Executes during object creation, after setting all properties.
function edit_base_radius_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_base_radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_base_radius_Callback(hObject, eventdata, handles)
% hObject    handle to edit_base_radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_base_radius as text
%        str2double(get(hObject,'String')) returns contents of edit_base_radius as a double


% --- Executes during object creation, after setting all properties.
function edit_roller_radius_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_roller_radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_roller_radius_Callback(hObject, eventdata, handles)
% hObject    handle to edit_roller_radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_roller_radius as text
%        str2double(get(hObject,'String')) returns contents of edit_roller_radius as a double


% --- Executes during object creation, after setting all properties.
function edit_rise_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_rise_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rise as text
%        str2double(get(hObject,'String')) returns contents of edit_rise as a double


% --- Executes during object creation, after setting all properties.
function edit_dwell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dwell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_dwell_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dwell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dwell as text
%        str2double(get(hObject,'String')) returns contents of edit_dwell as a double


% --- Executes during object creation, after setting all properties.
function edit_fall_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_fall_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fall as text
%        str2double(get(hObject,'String')) returns contents of edit_fall as a double


% --- Executes during object creation, after setting all properties.
function popupmenu_function_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in popupmenu_function.
function popupmenu_function_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_function contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_function
global funoption

    funoption=get(hObject,'Value');


% --------------------------------------------------------------------
function file_menu_Callback(hObject, eventdata, handles)
% hObject    handle to file_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isempty(get(handles.figure1,'Children'))
	set(handles.print_submenu,'Enable','off')
else
	set(handles.print_submenu,'Enable','on')
end

% --------------------------------------------------------------------
function print_submenu_Callback(hObject, eventdata, handles)
% hObject    handle to print_submenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
print -f1 


% --------------------------------------------------------------------
function close_submenu_Callback(hObject, eventdata, handles)
% hObject    handle to close_submenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(handles.figure1)
close(gcf);

