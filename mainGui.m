function varargout = mainGui(varargin)
% MAINGUI MATLAB code for mainGui.fig
%      MAINGUI, by itself, creates a new MAINGUI or raises the existing
%      singleton*.
%
%      H = MAINGUI returns the handle to a new MAINGUI or the handle to
%      the existing singleton*.
%
%      MAINGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINGUI.M with the given input arguments.
%
%      MAINGUI('Property','Value',...) creates a new MAINGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mainGui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mainGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mainGui

% Last Modified by GUIDE v2.5 03-Jul-2020 20:52:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mainGui_OpeningFcn, ...
                   'gui_OutputFcn',  @mainGui_OutputFcn, ...
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


% --- Executes just before mainGui is made visible.
function mainGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mainGui (see VARARGIN)

% Choose default command line output for mainGui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

addpath Project1
addpath Project2
addpath Project3
% UIWAIT makes mainGui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mainGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function img_in = file_path()
       [File_Name, Path_Name] = uigetfile('*.*', 'Select a image File');
       img_in = [Path_Name, File_Name];

% --- Executes on button press in pushbutton2b.
function pushbutton2b_Callback(hObject, eventdata, handles)
clear
Project2_B(file_path())
% hObject    handle to pushbutton2b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2a.
function pushbutton2a_Callback(hObject, eventdata, handles)
clear
Project2_A(file_path())
% hObject    handle to pushbutton2a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton1b.
function pushbutton1b_Callback(hObject, eventdata, handles)
clear
Project1_B()
% hObject    handle to pushbutton1b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton1a.
function pushbutton1a_Callback(hObject, eventdata, handles)
clear
Project1_A()
% hObject    handle to pushbutton1a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton1c.
function pushbutton1c_Callback(hObject, eventdata, handles)
clear
Project1_C()
% hObject    handle to pushbutton1c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton1d.
function pushbutton1d_Callback(hObject, eventdata, handles)
clear
Project1_D()
% hObject    handle to pushbutton1d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton1e.
function pushbutton1e_Callback(hObject, eventdata, handles)
clear
Project1_E()
% hObject    handle to pushbutton1e (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3a.
function pushbutton3a_Callback(hObject, eventdata, handles)

Project3_A(file_path())
% hObject    handle to pushbutton3a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3b.
function pushbutton3b_Callback(hObject, eventdata, handles)
clear
Project3_B(file_path())
% hObject    handle to pushbutton3b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
