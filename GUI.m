function varargout = GUI(varargin)
% GUI M-file for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 15-Apr-2004 12:12:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in circle.
function circle_Callback(hObject, eventdata, handles)
% hObject    handle to circle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of circle

set(handles.circle, 'Value', 1);
set(handles.square, 'Value', 0);
set(handles.triangle, 'Value', 0);
set(handles.star, 'Value', 0);

set(handles.shape, 'String', 'circle');

% --- Executes on button press in square.
function square_Callback(hObject, eventdata, handles)
% hObject    handle to square (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of square

set(handles.circle, 'Value', 0);
set(handles.square, 'Value', 1);
set(handles.triangle, 'Value', 0);
set(handles.star, 'Value', 0);

set(handles.shape, 'String', 'square');

% --- Executes on button press in triangle.
function triangle_Callback(hObject, eventdata, handles)
% hObject    handle to triangle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of triangle

set(handles.circle, 'Value', 0);
set(handles.square, 'Value', 0);
set(handles.triangle, 'Value', 1);
set(handles.star, 'Value', 0);

set(handles.shape, 'String', 'triangle');

% --- Executes on button press in star.
function star_Callback(hObject, eventdata, handles)
% hObject    handle to star (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of star

set(handles.circle, 'Value', 0);
set(handles.square, 'Value', 0);
set(handles.triangle, 'Value', 0);
set(handles.star, 'Value', 1);

set(handles.shape, 'String', 'star');

% --- Executes on button press in and.
function and_Callback(hObject, eventdata, handles)
% hObject    handle to and (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of and

set(handles.and, 'Value', 1);
set(handles.or, 'Value', 0);

set(handles.logic, 'String', 'and');


% --- Executes on button press in or.
function or_Callback(hObject, eventdata, handles)
% hObject    handle to or (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of or

set(handles.and, 'Value', 0);
set(handles.or, 'Value', 1);

set(handles.logic, 'String', 'or');


% --- Executes on button press in red.
function red_Callback(hObject, eventdata, handles)
% hObject    handle to red (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of red

set(handles.red, 'Value', 1);
set(handles.green, 'Value', 0);
set(handles.blue, 'Value', 0);

set(handles.color, 'String', 'red');

% --- Executes on button press in green.
function green_Callback(hObject, eventdata, handles)
% hObject    handle to green (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of green

set(handles.red, 'Value', 0);
set(handles.green, 'Value', 1);
set(handles.blue, 'Value', 0);

set(handles.color, 'String', 'green');

% --- Executes on button press in blue.
function blue_Callback(hObject, eventdata, handles)
% hObject    handle to blue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of blue

set(handles.red, 'Value', 0);
set(handles.green, 'Value', 0);
set(handles.blue, 'Value', 1);

set(handles.color, 'String', 'blue');

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%get(handles.shape,'String')
%handles.logic.String
closepreview;
%get(handles.shape)
if( strcmp(get(handles.shape,'String'),'Shape')==1 | strcmp(get(handles.color,'String'),'color')==1 | strcmp(get(handles.logic,'String'),'and/or')==1)
    set(handles.error,'String','One or more input values is missing, please recheck all inputs');
else
    set(handles.error,'String',' ');
    robotic_vision(get(handles.shape,'String'),get(handles.color,'String'),get(handles.logic,'String'));
end


% --- Executes on button press in preview.
function preview_Callback(hObject, eventdata, handles)
% hObject    handle to preview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

preview(videoinput('winvideo',1,'RGB24_640x480'))
