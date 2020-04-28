function varargout = circuit_GUI(varargin)
% CIRCUIT_GUI MATLAB code for circuit_GUI.fig
%      CIRCUIT_GUI, by itself, creates a new CIRCUIT_GUI or raises the existing
%      singleton*.
%
%      H = CIRCUIT_GUI returns the handle to a new CIRCUIT_GUI or the handle to
%      the existing singleton*.
%
%      CIRCUIT_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CIRCUIT_GUI.M with the given input arguments.
%
%      CIRCUIT_GUI('Property','Value',...) creates a new CIRCUIT_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before circuit_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to circuit_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help circuit_GUI

% Last Modified by GUIDE v2.5 28-Oct-2019 14:00:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @circuit_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @circuit_GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before circuit_GUI is made visible.
function circuit_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to circuit_GUI (see VARARGIN)

% Choose default command line output for circuit_GUI
handles.output = hObject;
axes(handles.node1);
imshow('grey.png');
axes(handles.node2);
imshow('grey.png');
axes(handles.node3);
imshow('grey.png');
axes(handles.node4);
imshow('grey.png');
axes(handles.node5);
imshow('grey.png');
axes(handles.node6);
imshow('grey.png');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes circuit_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = circuit_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
