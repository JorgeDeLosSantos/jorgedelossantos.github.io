function varargout = Table_of_Contents_export(varargin)
% TABLE_OF_CONTENTS_EXPORT Application M-file for Table_of_Contents_export.fig
%    FIG = TABLE_OF_CONTENTS_EXPORT launch Table_of_Contents_export GUI.
%    TABLE_OF_CONTENTS_EXPORT('callback_name', ...) invoke the named callback.

% Last Modified by GUIDE v2.5 23-Sep-2002 23:20:24

if nargin == 0  % LAUNCH GUI

	fig = openfig(mfilename,'reuse');

	% Use system color scheme for figure:
	set(fig,'Color',get(0,'defaultUicontrolBackgroundColor'));

	% Generate a structure of handles to pass to callbacks, and store it. 
	handles = guihandles(fig);
	guidata(fig, handles);
    path(path,'cam')

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





% --------------------------------------------------------------------
function varargout = fourbar_Callback(h, eventdata, handles, varargin)
fourbar_export



% --------------------------------------------------------------------
function varargout = Rack_Callback(h, eventdata, handles, varargin)

gears_rack_export


% --------------------------------------------------------------------
function varargout = pushbutton15_Callback(h, eventdata, handles, varargin)

path('gear_contour',path)
gear_contour_export

% --------------------------------------------------------------------
function varargout = Gears_Profile_Callback(h, eventdata, handles, varargin)

gears_export


% --------------------------------------------------------------------
function varargout = Internal_Gears_Callback(h, eventdata, handles, varargin)


gears_internal_export

% --------------------------------------------------------------------
function varargout = Inverted_Slider_Crank_Callback(h, eventdata, handles, varargin)


inverted_slider_crank_export

% --------------------------------------------------------------------
function varargout = Slider_Crank_Callback(h, eventdata, handles, varargin)

slider_crank_export


% --------------------------------------------------------------------
function varargout = pushbutton_cams_Callback(h, eventdata, handles, varargin)
cam


% --- Executes on button press in pushbutton_elliptic_trammel.
function pushbutton_elliptic_trammel_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_elliptic_trammel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

elliptic_trammel_export


% --- Executes during object creation, after setting all properties.
function pushbutton_cams_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_cams (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cam

% --- Executes on button press in pushbutton_cycloids.
function pushbutton_cycloids_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_cycloids (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cycloids_export


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
'Name','Table of Contents',...
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
'pushbutton', 21, ...
'text', 11, ...
'listbox', 2), ...
'override', 0, ...
'resize', 'none', ...
'accessibility', 'callback', ...
'mfile', 1, ...
'callbacks', 1, ...
'singleton', 1, ...
'blocking', 0, ...
'syscolorfig', 1, ...
'lastSavedFile', 'C:\summer_02\erin\matlab_r13\kinmeatics\norton\Table_of_Contents.m', ...
'release', 12));


h2 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'ListboxTop',0,...
'Position',[15.2 21.8461538461538 82.2 6.61538461538462],...
'String',{ '' 'by ' '' 'Shih-Liang (Sid) Wang ' '' 'a supplement for ' },...
'Style','text',...
'Tag','text1');


h3 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'FontSize',12,...
'FontWeight','bold',...
'ListboxTop',0,...
'Position',[15.4 29.1538461538462 82.4 1.53846153846154],...
'String','MATLAB for Kinematics',...
'Style','text',...
'Tag','text2');


h4 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'FontSize',10,...
'FontWeight','bold',...
'ListboxTop',0,...
'Position',[6 19.5384615384615 98.4 1.61538461538462],...
'String','Design of Machinery, 3rd ed. by Norton  ',...
'Style','text',...
'Tag','text3');


h5 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'ListboxTop',0,...
'Position',[15 16.3846153846154 10.2 1.07692307692308],...
'String','Linkage',...
'Style','text',...
'Tag','text5');


h6 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'ListboxTop',0,...
'Position',[48.8 16.3076923076923 10.2 1.07692307692308],...
'String','Cams',...
'Style','text',...
'Tag','text6');


h7 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'ListboxTop',0,...
'Position',[84.2 16.2307692307692 10.2 1.07692307692308],...
'String','Gears',...
'Style','text',...
'Tag','text8');


h8 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','Table_of_Contents_export(''fourbar_Callback'',gcbo,[],guidata(gcbo))',...
'ListboxTop',0,...
'Position',[12.2 13.6923076923077 22.2 1.69230769230769],...
'String','Fourbar',...
'Tag','fourbar');


h9 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','Table_of_Contents_export(''Slider_Crank_Callback'',gcbo,[],guidata(gcbo))',...
'ListboxTop',0,...
'Position',[12.2 11.0769230769231 22.2 1.69230769230769],...
'String','Slider-Crank',...
'Tag','Slider_Crank');


h10 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','Table_of_Contents_export(''Inverted_Slider_Crank_Callback'',gcbo,[],guidata(gcbo))',...
'ListboxTop',0,...
'Position',[12.2 8.61538461538462 22.2 1.69230769230769],...
'String','Inverted Slider-Crank',...
'Tag','Inverted_Slider_Crank');


h11 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','Table_of_Contents_export(''Rack_Callback'',gcbo,[],guidata(gcbo))',...
'ListboxTop',0,...
'Position',[79.6 6.61538461538462 22.2 1.69230769230769],...
'String','Gear Racks',...
'Tag','Rack');


h12 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','Table_of_Contents_export(''Internal_Gears_Callback'',gcbo,[],guidata(gcbo))',...
'ListboxTop',0,...
'Position',[79.6 8.76923076923077 22.2 1.69230769230769],...
'String','Internal Gears',...
'Tag','Internal_Gears');


h13 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','Table_of_Contents_export(''Gears_Profile_Callback'',gcbo,[],guidata(gcbo))',...
'ListboxTop',0,...
'Position',[79.6 11.1538461538462 22.2 1.69230769230769],...
'String','External Gears',...
'Tag','Gears_Profile');


h14 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','Table_of_Contents_export(''pushbutton15_Callback'',gcbo,[],guidata(gcbo))',...
'ListboxTop',0,...
'Position',[79.6 13.6923076923077 22.2 1.69230769230769],...
'String','Tooth Profile',...
'Tag','pushbutton15');


h15 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'FontWeight','bold',...
'ListboxTop',0,...
'Position',[11.8 0.307692307692308 90.2 1.38461538461538],...
'String','Software copyright  2004 by The McGraw-Hill Companies, Inc.',...
'Style','text',...
'Tag','text9');


h16 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'FontWeight','bold',...
'ListboxTop',0,...
'Position',[13.8 -1.46153846153846 90.2 1.38461538461538],...
'String','Software copyright  2004 by The McGraw-Hill Companies, Inc.',...
'Style','text',...
'Tag','text10');


h17 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','Table_of_Contents_export(''pushbutton_elliptic_trammel_Callback'',gcbo,[],guidata(gcbo))',...
'ListboxTop',0,...
'Position',[12.2 4.46153846153846 22.2 1.69230769230769],...
'String','Elliptic Trammel',...
'Tag','pushbutton_elliptic_trammel');


h18 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','Table_of_Contents_export(''pushbutton19_Callback'',gcbo,[],guidata(gcbo))',...
'ListboxTop',0,...
'Position',[41.2 13.7692307692308 26.4 1.76923076923077],...
'String','Cams w/ Roller Followers',...
'Tag','pushbutton19');


h19 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','Table_of_Contents_export(''pushbutton_cycloids_Callback'',gcbo,[],guidata(gcbo))',...
'ListboxTop',0,...
'Position',[42.2 6.61538461538462 25.8 1.76923076923077],...
'String','Cycloids',...
'Tag','pushbutton_cycloids');



hsingleton = h1;