function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
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
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose 'GUI allows only one
%      instance to run (singleton)'.
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 09-May-2020 00:31:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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



% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% define the starting, minimum, and maximum slider values for each popupmenu option

% option1 is beats per train
handles.option1.cValue = 7; 
handles.option1.minValue = 6; 
handles.option1.maxValue = 16; 

% option2 is cycle length
handles.option2.cValue = 25;
handles.option2.minValue = 10;
handles.option2.maxValue = 35;

% option3 is number of detection beats for VT
handles.option3.cValue = 10;
handles.option3.minValue = 8;
handles.option3.maxValue = 14;

% option4 is number of detection beats for FVT
handles.option4.cValue = 10;
handles.option4.minValue = 10;
handles.option4.maxValue = 16;

% option5 is VT cycle length threshold
handles.option5.cValue = 60;
handles.option5.minValue = 55;
handles.option5.maxValue = 63;

% option6 is FVT cycle length threshold
handles.option6.cValue = 32;
handles.option6.minValue = 30;
handles.option6.maxValue = 35;

% option7 is maximum number of extrastimuli
handles.option7.cValue = 1;
handles.option7.minValue = 0;
handles.option7.maxValue = 3;

% option8 is extrastimulus cycle length
handles.option8.cValue = 6;
handles.option8.minValue = 4;
handles.option8.maxValue = 7;

% option9 is CL increase upon loss of capture
handles.option9.cValue = 7;
handles.option9.minValue = 4;
handles.option9.maxValue = 9;

% set the opening popupmenu option, slider values, and textbox message
handles.popupmenu1.Value = 1;
handles.slider1.Min = handles.option1.minValue;
handles.slider1.Max = handles.option1.maxValue;
handles.slider1.Value = handles.option1.cValue;

handles.popupmenu2.Value = 1;

set(handles.text3, 'String', num2str(handles.option1.minValue), 'FontSize', 14);
set(handles.text4, 'String', num2str(handles.option1.maxValue), 'FontSize', 14);

mainText = {['Beats per train is: ',floor(num2str(handles.option1.cValue))]; 
    ['Cycle length is: ',floor(num2str(handles.option2.cValue))]; 
    ['Number of detection beats for VT is: ',floor(num2str(handles.option3.cValue))]; 
    ['Number of detection beats for FVT is: ',floor(num2str(handles.option4.cValue))]; 
    ['VT cycle length threshold is: ',floor(num2str(handles.option5.cValue))]; 
    ['FVT cycle length threshold is: ',floor(num2str(handles.option6.cValue))]; 
    ['Maximum number of extrastimuli is: ',floor(num2str(handles.option7.cValue))]; 
    ['Extrastimulus cycle length is: ',floor(num2str(handles.option8.cValue))];
    ['Cycle length increase upon loss of capture is: ',floor(num2str(handles.option9.cValue))]}; 

set(handles.text2, 'String', mainText, 'FontSize', 14);

% set opening slider steps as well
handles.slider1.SliderStep = [1/(handles.slider1.Max - handles.slider1.Min), 1/(handles.slider1.Max - handles.slider1.Min)];

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.mypushbutton);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

% WHEN THE USER CHANGES THE POPUP, ADJUST THE SLIDER TO REFLECT
% THE SLIDER MIN, MAX, AND VALUE ASSOCIATED WITH THAT ITEM
item = handles.popupmenu1.Value;

if item == 1
    handles.slider1.Value = handles.option1.cValue;
    handles.slider1.Min = handles.option1.minValue;
    handles.slider1.Max = handles.option1.maxValue;
    
elseif item == 2
    handles.slider1.Value = handles.option2.cValue;
    handles.slider1.Min = handles.option2.minValue;
    handles.slider1.Max = handles.option2.maxValue;
    
elseif item == 3
    handles.slider1.Value = handles.option3.cValue;
    handles.slider1.Min = handles.option3.minValue;
    handles.slider1.Max = handles.option3.maxValue;
    
elseif item == 4
    handles.slider1.Value = handles.option4.cValue;
    handles.slider1.Min = handles.option4.minValue;
    handles.slider1.Max = handles.option4.maxValue;
    
elseif item == 5
    handles.slider1.Value = handles.option5.cValue;
    handles.slider1.Min = handles.option5.minValue;
    handles.slider1.Max = handles.option5.maxValue;
    
elseif item == 6
    handles.slider1.Value = handles.option6.cValue;
    handles.slider1.Min = handles.option6.minValue;
    handles.slider1.Max = handles.option6.maxValue;
    
elseif item == 7
    handles.slider1.Value = handles.option7.cValue;
    handles.slider1.Min = handles.option7.minValue;
    handles.slider1.Max = handles.option7.maxValue;
    
elseif item == 8
    handles.slider1.Value = handles.option8.cValue;
    handles.slider1.Min = handles.option8.minValue;
    handles.slider1.Max = handles.option8.maxValue;

elseif item == 9
    handles.slider1.Value = handles.option9.cValue;
    handles.slider1.Min = handles.option9.minValue;
    handles.slider1.Max = handles.option9.maxValue;
    
end

handles.slider1.SliderStep = [1/(handles.slider1.Max - handles.slider1.Min), 1/(handles.slider1.Max - handles.slider1.Min)];

set(handles.text3, 'String', num2str(handles.slider1.Min), 'FontSize', 14);
set(handles.text4, 'String', num2str(handles.slider1.Max), 'FontSize', 14);

guidata(hObject,handles)


    


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% WHEN THE USER CHANGES THE POPUP, ADJUST THE SLIDER TO REFLECT
% THE SLIDER MIN, MAX, AND VALUE ASSOCIATED WITH THAT ITEM
% GET THE STRING FROM THE POPUP
stringName = handles.popupmenu1.String;
val = handles.popupmenu1.Value;
myThing = stringName{val};

% UPDATE THE VALUE ASSOCIATED WITH THE POPUP ITEM THAT IS
% CURRENTLY SELECTED.
switch myThing
    case 'Beats per Train'
        handles.option1.cValue = handles.slider1.Value;
        
    case 'Cycle Length'
        handles.option2.cValue = handles.slider1.Value;
        
    case 'Number of Detection Beats for VT'
        handles.option3.cValue = handles.slider1.Value;
    
    case 'Number of Detection Beats for FVT' 
        handles.option4.cValue = handles.slider1.Value;
        
    case 'VT Cycle Length Threshold' 
        handles.option5.cValue = handles.slider1.Value;
        
    case 'FVT Cycle Length Threshold' 
        handles.option6.cValue = handles.slider1.Value;
        
    case 'Maximum Number of Extrastimuli'
        handles.option7.cValue = handles.slider1.Value;
        
    case 'Extrastimulus Cycle Length'
        handles.option8.cValue = handles.slider1.Value;
        
    case 'CL Increase Upon Loss of Capture'
        handles.option9.cValue = handles.slider1.Value;
        
end

% REPORT THE VALUES ASSOCIATED WITH THE SLIDER POSITION FOR EACH
% VALUE - JUST TO CHECK THAT VALUES ARE BEING TRACKED NICELY.

bigBox = {['Beats per train is: ',floor(num2str(handles.option1.cValue))]; 
    ['Cycle length is: ',floor(num2str(handles.option2.cValue))]; 
    ['Number of detection beats for VT is: ',floor(num2str(handles.option3.cValue))]; 
    ['Number of detection beats for FVT is: ',floor(num2str(handles.option4.cValue))]; 
    ['VT cycle length threshold is: ',floor(num2str(handles.option5.cValue))]; 
    ['FVT cycle length threshold is: ',floor(num2str(handles.option6.cValue))]; 
    ['Maximum number of extrastimuli is: ',floor(num2str(handles.option7.cValue))]; 
    ['Extrastimulus cycle length is: ',floor(num2str(handles.option8.cValue))];
    ['Cycle length increase upon loss of capture is: ',floor(num2str(handles.option9.cValue))]}; 

set(handles.text2, 'String', bigBox, 'FontSize', 14);

% DONT FORGET TO SAVE THE HANDLES STRUCTURE AS WE HAVE UPDATES THE
% cValue VARIABLES WE WANT TO TRACK!
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[node_table, path_table, ATP_table]  = create_scenarios(floor(handles.option1.cValue), ...
    floor(handles.option2.cValue), floor(handles.option3.cValue), floor(handles.option4.cValue), ...
    floor(handles.option5.cValue), floor(handles.option6.cValue), floor(handles.option8.cValue), ...
    floor(handles.option9.cValue), floor(handles.option7.cValue)); % option7 is last on purpose!!

main(node_table, path_table, ATP_table, 1, handles.edit2.String)

closereq();


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[node_table, path_table, ATP_table]  = create_scenarios(floor(handles.option1.cValue), ...
    floor(handles.option2.cValue), floor(handles.option3.cValue), floor(handles.option4.cValue), ...
    floor(handles.option5.cValue), floor(handles.option6.cValue), floor(handles.option8.cValue), ...
    floor(handles.option9.cValue), floor(handles.option7.cValue)); % option7 is last on purpose!!

main(node_table, path_table, ATP_table, 0, 0)

closereq();


