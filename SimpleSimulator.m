function varargout = SimpleSimulator(varargin)
% SIMPLESIMULATOR MATLAB code for SimpleSimulator.fig
%      SIMPLESIMULATOR, by itself, creates a new SIMPLESIMULATOR or raises the existing
%      singleton*.
%
%      H = SIMPLESIMULATOR returns the handle to a new SIMPLESIMULATOR or the handle to
%      the existing singleton*.
%
%      SIMPLESIMULATOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMPLESIMULATOR.M with the given input arguments.
%
%      SIMPLESIMULATOR('Property','Value',...) creates a new SIMPLESIMULATOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SimpleSimulator_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SimpleSimulator_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SimpleSimulator

% Last Modified by GUIDE v2.5 27-Mar-2017 17:03:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SimpleSimulator_OpeningFcn, ...
                   'gui_OutputFcn',  @SimpleSimulator_OutputFcn, ...
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


% --- Executes just before SimpleSimulator is made visible.
function SimpleSimulator_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
set(gcf, 'WindowButtonMotionFcn', {@mouseMove,handles});

initialize;
makeSignal;
handles.timer = timer('ExecutionMode','fixedRate','Period',0.05,'TimerFcn',{@update_display,handles}); 
clc


function varargout = SimpleSimulator_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function axes1_CreateFcn(hObject, eventdata, handles)


function edit1_Callback(hObject, eventdata, handles)


function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function mouseMove(object, eventdata, handles)
C = get(gca, 'CurrentPoint');
handles.edit1.set('String',C(1,2));


function update_display(hObject, eventdata, handles)
i = evalin('base','i');

if i == evalin('base','N')
    pushbutton2_Callback;
else
    handles.edit5.set('String',strcat(num2str(sprintf('%0.2f',(i-1)*0.05)),32,'[s]'));
    ft = evalin('base','ft');
    ft = ft(i);
    handles.edit4.set('String',ft);
    
    % Baseline Dynamics parameters
    Ka = 10.6189;
    T1 = 0.9906;
    T2 = 2.7565;
    T3 = 7.6122;
    
    % Stick Gain
    Ks = 0.29;
    K = Ka * Ks;
    
    mouse = get(handles.axes1, 'CurrentPoint');
    oldu = evalin('base','oldu');
    u = -mouse(1,2);
    udot = (u - oldu)/0.05;
    assignin('base', 'oldu', u)
    
    % Perform the calculation
    y = evalin('base','y');
    ydot = evalin('base','ydot');
    ydotdot = evalin('base','ydotdot');
    ydotdotdot = -T2*ydotdot - T3*ydot + K*udot + K*T1*u;
    ydotdot = ydotdot + ydotdotdot * 0.05;
    assignin('base','ydotdot',ydotdot);
    ydot = ydot + ydotdot * 0.05;
    assignin('base','ydot', ydot);
    y = y + ydot * 0.05;
    handles.edit2.set('String',y);
    assignin('base','y', y);
    
    % Error
    E = evalin('base','E');
    E(i) = ft - y;
    handles.edit3.set('String', ft - y);
    assignin('base','E', E);

    % Control effort
    U = evalin('base','U');
    U(i) = u;
    assignin('base','U',U);
    
    % Store time index
    assignin('base','i',i+1);
    
    plot(handles.axes1,[-0.2 0 0.2 0 -0.2 -0.2 0.2],[y-0.1 y y-0.1 y+0.1 y-0.1 ft ft],'k') % Aircraft symbol
    axis(handles.axes1,[-1 1 -3 3]); % Bounds
end


function figure1_CloseRequestFcn(hObject, eventdata, handles)
delete(hObject);


function figure1_DeleteFcn(hObject, eventdata, handles)
disp('close');
listOfTimers = timerfindall;
stop(listOfTimers);
delete(listOfTimers);
delete(hObject);


function edit2_Callback(hObject, eventdata, handles)


function edit2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit3_Callback(hObject, eventdata, handles)


function edit3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbutton1_Callback(hObject, eventdata, handles)
listOfTimers = timerfindall;
start(listOfTimers(1));


function pushbutton2_Callback(hObject, eventdata, handles)
listOfTimers = timerfindall;
stop(listOfTimers(1));


function edit4_Callback(hObject, eventdata, handles)


function edit4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbutton3_Callback(hObject, eventdata, handles)
initialize
handles.edit5.set('String', '0 [s]');
cla


function pushbutton3_CreateFcn(hObject, eventdata, handles)


function pushbutton4_Callback(hObject, eventdata, handles)
figure(1);
cla;
hold on;
time = evalin('base','time');
E = evalin('base','E');
U = evalin('base','U');
time_portion = 1:length(E);
plot(time(time_portion),E);
plot(time(time_portion),U);
legend('error','control effort');
xlabel('time [s]');
hold off;


function pushbutton4_CreateFcn(hObject, eventdata, handles)


function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
key = eventdata.Key;
listOfTimers = timerfindall;

if strcmp(key,'return')
    if strcmp(listOfTimers(1).Running, 'on')
        pushbutton2_Callback(hObject, eventdata, handles)
    else
        pushbutton1_Callback(hObject, eventdata, handles)
    end
elseif strcmp(key,'delete')
    eval('clear all'); 
    initialize;
end


function edit5_Callback(hObject, eventdata, handles)


function edit5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
