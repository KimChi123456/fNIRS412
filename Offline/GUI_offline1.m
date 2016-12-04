function varargout = GUI_offline1(varargin)
% GUI_OFFLINE1 MATLAB code for GUI_offline1.fig
%      GUI_OFFLINE1, by itself, creates a new GUI_OFFLINE1 or raises the existing
%      singleton*.
%
%      H = GUI_OFFLINE1 returns the handle to a new GUI_OFFLINE1 or the handle to
%      the existing singleton*.
%
%      GUI_OFFLINE1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_OFFLINE1.M with the given input arguments.
%
%      GUI_OFFLINE1('Property','Value',...) creates a new GUI_OFFLINE1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_offline1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_offline1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_offline1

% Last Modified by GUIDE v2.5 25-Jan-2015 23:11:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_offline1_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_offline1_OutputFcn, ...
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


% --- Executes just before GUI_offline1 is made visible.
function GUI_offline1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_offline1 (see VARARGIN)
global filename
clc
cla(handles.axes1);cla(handles.axes2);cla(handles.axes3);cla(handles.axes4);
set(handles.text4,'String','');
filename='Load a file';
set(handles.edit1,'String',filename);
set(handles.text14,'String','');
%%%hide buttons and axes
set(handles.savename_pushbutton,'Visible', 'off')
set(handles.browse_pushbutton,'Visible', 'off')
set(handles.signal_uipanel,'Visible', 'off')
set(handles.axes1,'Visible', 'off')
set(handles.axes2,'Visible', 'off')
set(handles.axes3,'Visible', 'off')
set(handles.axes4,'Visible', 'off')
set(handles.filter_uipanel,'Visible', 'off')
set(handles.text21,'Visible', 'off')
% set(handles.text22,'Visible', 'off')
set(handles.scale1_popupmenu,'Visible', 'off')
% set(handles.scale2_popupmenu,'Visible', 'off')
set(handles.TaskRest_togglebutton,'Visible', 'off')
set(handles.TaskRest_togglebutton,'Value',0)

%%%Hide channel select pannel
set(handles.left_pushbutton,'Visible', 'off')
set(handles.ch_edit,'Visible', 'off')
set(handles.ch_text,'Visible', 'off')
set(handles.right_pushbutton,'Visible', 'off')
set(handles.text10,'Visible', 'off')
set(handles.total_ch_edit,'Visible', 'off')
set(handles.text11,'Visible', 'off')

set(handles.ch_edit,'String',1)
set(handles.ch_text,'string','st');

%%%Hide loadmat pannels
set(handles.process_uipanel,'Visible', 'off')
set(handles.filtered_uipanel,'Visible', 'off')


% Choose default command line output for GUI_offline1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_offline1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_offline1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in browse_pushbutton.
function browse_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to browse_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sav_data1, global sav_data2,global sav_data3,global sav_data4,global sav_data5, global sav_data6,global task
global raw,global filename, global ch, global T
global save_check, global oxy, global deoxy, global tasks
sav_data=[];
if save_check==0;
    Filtered_data=[sav_data1 sav_data2 sav_data3 sav_data4 sav_data5 sav_data6]; Filter_check=size(Filtered_data,1);
    if Filter_check==0
        sav_data=table(tasks,oxy,deoxy);
    else
        sav_data=table(tasks,oxy,deoxy,Filtered_data);
    end
%     size(sav_data1),size(sav_data2),size(sav_data3),size(sav_data4),size(sav_data5)
    note=[ch T];
    get_name=get(handles.edit1,'String');
    check_blank=size(get_name,2);
    if check_blank>0 
        save_name=[get_name '.mat'];
        currentfolder=pwd;
        save_folder = uigetdir(currentfolder);
        cd(save_folder);
        save (save_name,'sav_data');%'-ascii'
        %%Create channel.mat
        channels_name=[get_name '_channels&Ts.mat'];
        save (channels_name,'note');
        %%%
        
        
        
        cd(currentfolder);
        set(handles.edit1,'String','SAVED');
        
        
    elseif check_blank==0
        set(handles.edit1,'String','give a name')
    end
    save_check=1;
    
else
    set(handles.edit1,'String','ALREADY SAVED')
end
pause(0.75)
set(handles.edit1,'String',filename)

% --- Executes on button press in savename_pushbutton.
function savename_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to savename_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global save_check

save_check=0;
set(handles.edit1,'String','give a name'); pause(0.25);
set(handles.edit1,'String','');
set(handles. browse_pushbutton,'Visible','on')
% --- Executes on button press in band_togglebutton.
function band_togglebutton_Callback(hObject, eventdata, handles)
% hObject    handle to band_togglebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global cut1,global cut2,global Fcutoff,global passband,global stopband
global ch,global ox1, global deox1, global ox2, global deox2
global signal,global step
global h,global ax, global c, global ax1, global ax2, global ax3, global length
global oxy,global deoxy,global oxy1,global deoxy1,global oxy_filt1,global deoxy_filt1
global string3, global a, global b
string3='not filtered yet';
set(handles.process_uipanel,'Visible', 'off')
set(handles.text15,'String', '');
% Hint: get(hObject,'Value') returns toggle state of band_togglebutton

%%%reset
    set(handles.type_popupmenu,'Value', 1);
    set(handles.method_popupmenu,'Value', 1);
    set(handles.sav1_checkbox,'Value',0);
    set(handles.order_edit,'String','');
    set(handles.cutoff1_edit,'String','');
    set(handles.cutoff2_edit,'String','');
    set(handles.passband_edit,'String','');
    set(handles.passband_edit,'String','');

on1=get(hObject,'Value');
if on1==0
    %%% hide Bandpass buttons
    set(handles.type_popupmenu,'Visible', 'off');
    set(handles.order_text,'Visible', 'off');
    set(handles.order_edit,'Visible', 'off');
    set(handles.cutoff1_edit,'Visible', 'off');
    set(handles.cut1_text,'Visible', 'off');
    set(handles.cutoff2_edit,'Visible', 'off');
    set(handles.cut2_text,'Visible', 'off');
    set(handles.method_popupmenu,'Visible', 'off');
    set(handles.passband_edit,'Visible', 'off');
    set(handles.passband_text,'Visible', 'off');
    set(handles.stopband_edit,'Visible', 'off');
    set(handles.stopband_text,'Visible', 'off');
    set(handles.filter1_pushbutton,'Visible', 'off');
    set(handles.save1_pushbutton,'Visible', 'off');
    set(handles.sav1_checkbox,'Visible', 'off');
    
     %%show other options
     set(handles.adapt_uipanel,'Visible', 'on');%%show adaptive option
     set(handles.adapt_togglebutton,'Visible', 'on');
     set(handles.smooth_uipanel,'Visible', 'on');%%show smooths option
     set(handles.smooth_togglebutton,'Visible', 'on');
     set(handles.resting_uipanel,'Visible', 'on');%%show Resting-state reference option
     set(handles.resting_togglebutton,'Visible', 'on'); 
     set(handles.Kalman_uipanel,'Visible', 'on');%%show Kalman option
     set(handles.kalman_togglebutton,'Visible', 'on');
     set(handles.SASS_uipanel,'Visible', 'on');%%show SASS option
     set(handles.sass_togglebutton,'Visible', 'on');
     
    %%%plot
    check=get(handles.oxy_checkbox,'Value');
    check2=get(handles.deoxy_checkbox,'Value');


    cla(h(2));
    axes(h(2));
    oxy1=oxy; deoxy1=deoxy;
    ox2=plot(oxy(:,step),'r');set(ox2,'tag','ox2');
    hold on
    deox2=plot(deoxy(:,step),'b');set(deox2,'tag','deox2');

    xlim([0 length]);
    set(h(2),'xtick',[])
    title(h(2),string3);
    
    global task_line1, global rest_line1, global task_line2, global rest_line2, global task, global rest
    TaskRest=get(handles.TaskRest_togglebutton,'Value');
    if TaskRest==1
        for i=1:size(task,2)
            task_line2(i)=plot([task(i) task(i)],[-1,1],'Color',[0 0.75 0], 'Linestyle','--');%line([5,5],ylim)    
            rest_line2(i)=plot([rest(i) rest(i)],[-1,1],'Color',[0.25 0.25 0.25]);
        end
    end

    if check==1
        if check2==0
            delete(findobj('tag','deox1'))
            delete(findobj('tag','deox2'))
        end
    
    elseif check== 0
        delete(findobj('tag','ox1'))
        delete(findobj('tag','ox2'))
        if check2==0
            delete(findobj('tag','deox1'))
            delete(findobj('tag','deox2'))
        end

    end
    
else
     set(handles.type_popupmenu,'Visible', 'on');
     set(handles.sav1_checkbox,'Visible', 'on');
     
    %%Hide other options
    set(handles.adapt_uipanel,'Visible', 'off');%%hide adaptive option
    set(handles.adapt_togglebutton,'Visible', 'off');
    set(handles.smooth_uipanel,'Visible', 'off');%%hide smooths option
    set(handles.smooth_togglebutton,'Visible', 'off');
    set(handles.resting_uipanel,'Visible', 'off');%%hide Resting-state reference option
    set(handles.resting_togglebutton,'Visible', 'off'); 
    set(handles.Kalman_uipanel,'Visible', 'off');%%hide Kalman option
    set(handles.kalman_togglebutton,'Visible', 'off');
    set(handles.SASS_uipanel,'Visible', 'off');%%show SASS option
    set(handles.sass_togglebutton,'Visible', 'off');
     
    %%%reset
    
    c=0;
    Fcutoff=[];
    cut1=[];
    cut2=[];
    passband=[];
    stopband=[];
    oxy1=oxy;
    deoxy1=deoxy;
    
end


% --- Executes on button press in adapt_togglebutton.
function adapt_togglebutton_Callback(hObject, eventdata, handles)
% hObject    handle to adapt_togglebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global adapt_step
global loc,global glob, global count
global oxyref, global deoxyref
global ch,global ox1, global deox1, global ox2, global deox2
global signal,global step
global h,global ax, global c,global c2, global ax1, global ax2, global ax3, global length
global oxy,global deoxy,global oxy1,global deoxy1,global oxy_filt1,global deoxy_filt1
global string3, global a, global b
string3='not filtered yet';
set(handles.process_uipanel,'Visible', 'off')
% Hint: get(hObject,'Value') returns toggle state of adapt_togglebutton
on1=get(hObject,'Value');
count=0;
if on1==0
    c2=0;
    %%% hide Adapt buttons
    set(handles.low_pushbutton,'Visible', 'off');
    set(handles.adapt_popupmenu,'Visible', 'off');
    set(handles.ref_text,'Visible', 'off');
    set(handles.adapt_left_pushbutton,'Visible', 'off');
    set(handles.ref_edit,'Visible', 'off');
    set(handles.adapt_right_pushbutton,'Visible', 'off');
    set(handles.adapt_select_pushbutton,'Visible', 'off');
    set(handles.text4,'Visible', 'off');
    set(handles.filter2_pushbutton,'Visible', 'off');
    set(handles.save2_pushbutton,'Visible', 'off');
    set(handles.sav2_checkbox,'Visible', 'off');
    cla(h(3))
    set(h(3),'Visible', 'off');
    
    %%% hide Bandpass buttons
    set(handles.type_popupmenu,'Visible', 'off');
    set(handles.order_text,'Visible', 'off');
    set(handles.order_edit,'Visible', 'off');
    set(handles.cutoff1_edit,'Visible', 'off');
    set(handles.cut1_text,'Visible', 'off');
    set(handles.cutoff2_edit,'Visible', 'off');
    set(handles.cut2_text,'Visible', 'off');
    set(handles.method_popupmenu,'Visible', 'off');
    set(handles.passband_edit,'Visible', 'off');
    set(handles.passband_text,'Visible', 'off');
    set(handles.stopband_edit,'Visible', 'off');
    set(handles.stopband_text,'Visible', 'off');
    set(handles.filter1_pushbutton,'Visible', 'off');
    
    %%show other options
    set(handles.band_uipanel,'Visible', 'on');%%show Bandpass option
    set(handles.band_togglebutton,'Visible', 'on');
    set(handles.smooth_uipanel,'Visible', 'on');%%show Smooths option
    set(handles.smooth_togglebutton,'Visible', 'on');
    set(handles.resting_uipanel,'Visible', 'on');%%show Resting-state reference option
    set(handles.resting_togglebutton,'Visible', 'on'); 
    set(handles.Kalman_uipanel,'Visible', 'on');%%show Kalman option
    set(handles.kalman_togglebutton,'Visible', 'on');
    set(handles.SASS_uipanel,'Visible', 'on');%%show SASS option
    set(handles.sass_togglebutton,'Visible', 'on');
   
   %%%reset
   set(handles.adapt_popupmenu,'Value', 1);
   set(handles.ref_edit,'String','0');
   set(handles.sav2_checkbox,'Value',0);
   c=0;
   oxy1=oxy;
   deoxy1=deoxy;
   adapt_step=0;
   
   %%%plot
    check=get(handles.oxy_checkbox,'Value');
    check2=get(handles.deoxy_checkbox,'Value');

    cla(h(2));
    axes(h(2))
    ox2=plot(oxy1(:,step),'r');set(ox2,'tag','ox2');
    hold on
    deox2=plot(deoxy1(:,step),'b');set(deox2,'tag','deox2');

    xlim([0 length]);
    set(h(2),'xtick',[])
    title(h(2),string3);
    
    global task_line1, global rest_line1, global task_line2, global rest_line2, global task, global rest
    TaskRest=get(handles.TaskRest_togglebutton,'Value');
    if TaskRest==1
        for i=1:size(task,2)
            task_line2(i)=plot([task(i) task(i)],[-1,1],'Color',[0 0.75 0], 'Linestyle','--');%line([5,5],ylim)    
            rest_line2(i)=plot([rest(i) rest(i)],[-1,1],'Color',[0.25 0.25 0.25]);
        end
    end

    if check==1
        if check2==0
            delete(findobj('tag','deox1'))
            delete(findobj('tag','deox2'))
        end
    
    elseif check== 0
        delete(findobj('tag','ox1'))
        delete(findobj('tag','ox2'))
        if check2==0
            delete(findobj('tag','deox1'))
            delete(findobj('tag','deox2'))
        end

    end
     
else
    set(handles.low_pushbutton,'Visible', 'on');
    set(handles.sav2_checkbox,'Visible', 'on');
    set(handles.sav2_checkbox,'Value', 0);
    
    %%Hide other options
    set(handles.band_uipanel,'Visible', 'off');%%hide Band option
    set(handles.band_togglebutton,'Visible', 'off');
    set(handles.smooth_uipanel,'Visible', 'off');%%hide smooths option
    set(handles.smooth_togglebutton,'Visible', 'off');
    set(handles.resting_uipanel,'Visible', 'off');%%hide Resting-state reference option
    set(handles.resting_togglebutton,'Visible', 'off'); 
    set(handles.Kalman_uipanel,'Visible', 'off');%%hide Kalman option
    set(handles.kalman_togglebutton,'Visible', 'off');
    set(handles.SASS_uipanel,'Visible', 'off');%%hide SASS option
    set(handles.sass_togglebutton,'Visible', 'off');
end


% --- Executes on button press in smooth_togglebutton.
function smooth_togglebutton_Callback(hObject, eventdata, handles)
% hObject    handle to smooth_togglebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
on3=get(hObject,'Value');
global gaus, global ema
global ch,global ox1, global deox1, global ox2, global deox2
global signal,global step
global h,global ax, global c, global ax1, global ax2, global ax3, global length
global oxy,global deoxy,global oxy1,global deoxy1,global oxy_filt1,global deoxy_filt1
global string3, global a, global b
string3='not filtered yet';
set(handles.process_uipanel,'Visible', 'off')
set(handles.text16,'String', '');
% Hint: get(hObject,'Value') returns toggle state of smooth_togglebutton
if on3==0
    cla(h(3))
    set(h(3),'Visible', 'off');
    %%% hide SMOOTHS buttons
    set(handles.combine3_togglebutton,'Visible', 'off');
    set(handles.gaussian_togglebutton,'Visible', 'off');
    set(handles.ema_togglebutton,'Visible', 'off');
    set(handles.win_edit,'Visible', 'off');
    set(handles.wsize_text,'Visible', 'off');
    set(handles.alpha_edit,'Visible', 'off');
    set(handles.alpha_text,'Visible', 'off');
    set(handles.filter3_pushbutton,'Visible', 'off');    
    set(handles.save3_pushbutton,'Visible', 'off');
    set(handles.sav3_checkbox,'Visible', 'off');
    
    %%show other options
    set(handles.adapt_uipanel,'Visible', 'on');%%show adaptive option
    set(handles.adapt_togglebutton,'Visible', 'on');
    set(handles.band_uipanel,'Visible', 'on');%%show bandpass option
    set(handles.band_togglebutton,'Visible', 'on');
    set(handles.resting_uipanel,'Visible', 'on');%%show Resting-state reference option
    set(handles.resting_togglebutton,'Visible', 'on'); 
    set(handles.Kalman_uipanel,'Visible', 'on');%%show Kalman option
    set(handles.kalman_togglebutton,'Visible', 'on'); 
    set(handles.SASS_uipanel,'Visible', 'on');%%show SASS option
    set(handles.sass_togglebutton,'Visible', 'on');
    
    %%%reset
    set(handles.combine3_togglebutton,'value',0);
    set(handles.win_edit,'String','');
    set(handles.alpha_edit,'String','');
    set(handles.text14,'String','');
    set(handles.gaussian_togglebutton,'Value',0);
    set(handles.ema_togglebutton,'Value',0);
    set(handles.sav3_checkbox,'Value',0);
    c=0;
   oxy1=oxy;
   deoxy1=deoxy;
   
   %%Plot
    check=get(handles.oxy_checkbox,'Value');
    check2=get(handles.deoxy_checkbox,'Value');


    cla(h(2));
    axes(h(2))
    ox2=plot(oxy1(:,step),'r');set(ox2,'tag','ox2');
    hold on
    deox2=plot(deoxy1(:,step),'b');set(deox2,'tag','deox2');

    xlim([0 length]);
    set(h(2),'xtick',[])
    title(h(2),string3);
    
    global task_line1, global rest_line1, global task_line2, global rest_line2, global task, global rest
    TaskRest=get(handles.TaskRest_togglebutton,'Value');
    if TaskRest==1
        for i=1:size(task,2)
            task_line2(i)=plot([task(i) task(i)],[-1,1],'Color',[0 0.75 0], 'Linestyle','--');%line([5,5],ylim)    
            rest_line2(i)=plot([rest(i) rest(i)],[-1,1],'Color',[0.25 0.25 0.25]);
        end
    end

    if check==1
        if check2==0
            delete(findobj('tag','deox1'))
            delete(findobj('tag','deox2'))
        end
    
    elseif check== 0
        delete(findobj('tag','ox1'))
        delete(findobj('tag','ox2'))
        if check2==0
            delete(findobj('tag','deox1'))
            delete(findobj('tag','deox2'))
        end

    end
   
else
    set(handles.combine3_togglebutton,'Visible', 'on');
    set(handles.gaussian_togglebutton,'Visible', 'on');
    set(handles.ema_togglebutton,'Visible', 'on');
    set(handles.sav3_checkbox,'Visible', 'on');
    
    %%hide other options
    set(handles.adapt_uipanel,'Visible', 'off');%%hide adaptive option
    set(handles.adapt_togglebutton,'Visible', 'off');
    set(handles.band_uipanel,'Visible', 'off');%%hide bandpass option
    set(handles.band_togglebutton,'Visible', 'off');
    set(handles.resting_uipanel,'Visible', 'off');%%hide Resting-state reference option
    set(handles.resting_togglebutton,'Visible', 'off'); 
    set(handles.Kalman_uipanel,'Visible', 'off');%%hide Kalman option
    set(handles.kalman_togglebutton,'Visible', 'off');
    set(handles.SASS_uipanel,'Visible', 'off');%%hide SASS option
     set(handles.sass_togglebutton,'Visible', 'off');
end


% --- Executes on button press in deoxy_checkbox.
function deoxy_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to deoxy_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global h,global ax, global c,global c2, 
global ax1, global ax2, global ax3, global length
global step, global adapt_step
global rest_oxy, global rest_deoxy, global task_oxy, global task_deoxy
global oxy,global deoxy,global oxy1,global deoxy1
global yscale1, global yscale2
global string3
global task_line1, global task_line2,global rest_line1, global rest_line2,global task, global rest, global task_mark
global process
global oxy_pca, global deoxy_pca

if process==1
   set(handles.process_uipanel,'Visible', 'off') 
end

check=get(hObject,'Value');
check2=get(handles.oxy_checkbox,'Value');
  

%%%%%%%%%%%%%%%%AXES 1 and 2
cla(h(1));axes(h(1))
ox1=plot(oxy(:,step),'r');set(ox1,'tag','ox1');
hold on
deox1=plot(deoxy(:,step),'b');set(deox1,'tag','deox1');
xlim([0 length]);
set(h(1),'xtick',[])
m=title(h(1),['raw data: Channel ' num2str(step)]);

TaskRest=get(handles.TaskRest_togglebutton,'Value')
if TaskRest==1
    for i=1:size(task,2)
        task_line1(i)=plot([task(i) task(i)],[-1,1],'Color',[0 0.75 0], 'Linestyle','--');%line([5,5],ylim)    
        rest_line1(i)=plot([rest(i) rest(i)],[-1,1],'Color',[0.25 0.25 0.25]);
    end
end

if process==1
    cla(h(2));axes(h(2));
    ox2=plot(oxy1(:,step),'r');set(ox2,'tag','ox2');
    hold on
    deox2=plot(deoxy1(:,step),'b');set(deox2,'tag','deox2');

    xlim([0 length]);
    set(h(2),'xtick',[])
    m1=title(h(2),string3);
end
if TaskRest==1
    for i=1:size(task,2)
        task_line2(i)=plot([task(i) task(i)],[-1,1],'Color',[0 0.75 0], 'Linestyle','--');%line([5,5],ylim)    
        rest_line2(i)=plot([rest(i) rest(i)],[-1,1],'Color',[0.25 0.25 0.25]);
    end
end
%%%%
if check==1
   if check2==0
      delete(findobj('tag','ox1'))
      delete(findobj('tag','ox2')) 
   end
   
elseif check==0
    delete(findobj('tag','deox1'))
    delete(findobj('tag','deox2'))
    if check2==0
      delete(findobj('tag','ox1'))
      delete(findobj('tag','ox2')) 
   end
end

%%%%Adaptive filter
if c2==1
    adapt_step=str2num(get(handles.ref_edit,'String'));
    cla(h(3));axes(h(3))
    ox3=plot(oxy(:,adapt_step),'r');set(ox3,'tag','ox3');
    hold on
    deox3=plot(deoxy(:,adapt_step),'b');set(deox3,'tag','deox3') 
    xlim([0 length]);
    set(h(3),'xtick',[])
    m=xlabel(['Reference: Channel ' num2str(adapt_step)]);
    set(m, 'FontSize', 7);
    
    if check==1
        if check2==0
            delete(findobj('tag','ox3'))
        end
    elseif check==0
        delete(findobj('tag','deox3'))
        if check2==0
            delete(findobj('tag','ox3'))
        end
    end
        
end

%%%%RESTING-STATE REFERENCE
if c==4
    %%REST
    cla(h(3));axes(h(3))
    ox3=plot(rest_oxy(:,step),'r');set(ox3,'tag','ox3');
    hold on
    deox3=plot(rest_deoxy(:,step),'b');set(deox3,'tag','deox3') 
%     axis tight
    xlim([0 task_mark]);ylim(yscale1);
    set(h(3),'xtick',[])
    m=xlabel(['Original Rest: Channel ' num2str(step)]);
    set(m, 'FontSize', 7);
    
    %%processed REST 
    cla(h(4));axes(h(4))
    ox4=plot(oxy1(1:task_mark,step),'r');set(ox4,'tag','ox4');
    hold on
    deox4=plot(deoxy1(1:task_mark,step),'b');set(deox4,'tag','deox4') 
%     axis tight
    xlim([0 task_mark]);ylim(yscale1);
    set(h(4),'xtick',[])
    m=xlabel(['Filtered Rest: Channel ' num2str(step)]);
    set(m, 'FontSize', 7);
    
    %%TASK classification
    axes(h(1)); pca_line(1)=plot([task(1) task(1)],[-1,1],'Color',[0 0.75 0],'Linestyle','--','linewidth',2);
    axes(h(2)); pca_line(2)=plot([task(1) task(1)],[-1,1],'Color',[0 0.75 0],'Linestyle','--','linewidth',2);
    
    %%%
    
    if check==1
        if check2==0
            delete(findobj('tag','ox3'))
            delete(findobj('tag','ox4'))
        end
    elseif check==0
        delete(findobj('tag','deox3'))
        delete(findobj('tag','deox4'))
        if check2==0
            delete(findobj('tag','ox3'))
            delete(findobj('tag','ox4'))
        end
        
    end
end



% --- Executes on button press in oxy_checkbox.
function oxy_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to oxy_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global h,global ax, global c,global c2,
global ax1, global ax2, global ax3, global length
global step, global adapt_step
global rest_oxy, global rest_deoxy, global task_oxy, global task_deoxy
global oxy,global deoxy,global oxy1,global deoxy1
global string3
global yscale1, global yscale2
global task_line1, global task_line2,global rest_line1, global rest_line2, global task, global rest , global task_mark
global process
global oxy_pca, global deoxy_pca

if process==1
   set(handles.process_uipanel,'Visible', 'off') 
end
check=get(hObject,'Value');
check2=get(handles.deoxy_checkbox,'Value');

%%%%%%%%%%%%%%%%AXES 1 and 2
cla(h(1));axes(h(1))
ox1=plot(oxy(:,step),'r');set(ox1,'tag','ox1');
hold on
deox1=plot(deoxy(:,step),'b');set(deox1,'tag','deox1');
xlim([0 length]);
set(h(1),'xtick',[])
m=title(h(1),['raw data: Channel ' num2str(step)]);

TaskRest=get(handles.TaskRest_togglebutton,'Value')
if TaskRest==1
    for i=1:size(task,2)
        task_line1(i)=plot([task(i) task(i)],[-1,1],'Color',[0 0.75 0], 'Linestyle','--');%line([5,5],ylim)    
        rest_line1(i)=plot([rest(i) rest(i)],[-1,1],'Color',[0.25 0.25 0.25]);
    end
end

if c==-1||process==1
    cla(h(2));axes(h(2)); 
    ox2=plot(oxy1(:,step),'r');set(ox2,'tag','ox2');
    hold on
    deox2=plot(deoxy1(:,step),'b');set(deox2,'tag','deox2');

    xlim([0 length]);
    set(h(2),'xtick',[])
    m1=title(h(2),string3);
end

if TaskRest==1
    for i=1:size(task,2)
        task_line2(i)=plot([task(i) task(i)],[-1,1],'Color',[0 0.75 0], 'Linestyle','--');%line([5,5],ylim)    
        rest_line2(i)=plot([rest(i) rest(i)],[-1,1],'Color',[0.25 0.25 0.25]);
    end
end
%%%%
if check==1
   if check2==0
      delete(findobj('tag','deox1'))
      delete(findobj('tag','deox2')) 
   end
   
elseif check==0
    delete(findobj('tag','ox1'))
    delete(findobj('tag','ox2'))
    if check2==0
      delete(findobj('tag','deox1'))
      delete(findobj('tag','deox2')) 
   end
end

%%%%Adaptive filter
if c2==1
    adapt_step=str2num(get(handles.ref_edit,'String'));
    cla(h(3));axes(h(3))
    ox3=plot(oxy(:,adapt_step),'r');set(ox3,'tag','ox3');
    hold on
    deox3=plot(deoxy(:,adapt_step),'b');set(deox3,'tag','deox3') 
    xlim([0 length]);
    set(h(3),'xtick',[])
    m=xlabel(['Reference: Channel ' num2str(adapt_step)]);
    set(m, 'FontSize', 7);
    
    if check==1
        if check2==0
            delete(findobj('tag','deox3'))
        end
    elseif check==0
        delete(findobj('tag','ox3'))
        if check2==0
            delete(findobj('tag','deox3'))
        end
    end
        
end

%%%
%%%%RESTING-STATE REFERENCE
if c==4
    %%REST
    cla(h(3));axes(h(3))
    ox3=plot(rest_oxy(:,step),'r');set(ox3,'tag','ox3');
    hold on
    deox3=plot(rest_deoxy(:,step),'b');set(deox3,'tag','deox3') 
    xlim([0 task_mark]);ylim(yscale1);
    set(h(3),'xtick',[])
    m=xlabel(['Original Rest: Channel ' num2str(step)]);
    set(m, 'FontSize', 7);
    
    %%REST
    cla(h(4));axes(h(4))
    ox4=plot(oxy1(1:task_mark,step),'r');set(ox4,'tag','ox4');
    hold on
    deox4=plot(deoxy1(1:task_mark,step),'b');set(deox4,'tag','deox4') 
    xlim([0 task_mark]);ylim(yscale1);
    set(h(4),'xtick',[])
    m=xlabel(['Filtered Rest: Channel ' num2str(step)]);
    set(m, 'FontSize', 7);
    
%%TASK classification
    axes(h(1)); pca_line(1)=plot([task(1) task(1)],[-1,1],'Color',[0 0.75 0],'Linestyle','--','linewidth',2);
    axes(h(2)); pca_line(2)=plot([task(1) task(1)],[-1,1],'Color',[0 0.75 0],'Linestyle','--','linewidth',2);
%     %%%
    
    if check==1
        if check2==0
            delete(findobj('tag','deox3'))
            delete(findobj('tag','deox4'))
        end
    elseif check==0
        delete(findobj('tag','ox3'))
        delete(findobj('tag','ox4'))
        if check2==0
            delete(findobj('tag','deox3'))
            delete(findobj('tag','deox4'))
        end
        
    end
end

% --- Executes on button press in loadtxt_pushbutton.
function loadtxt_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to loadtxt_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Vision
set(handles.savename_pushbutton,'Visible', 'on')
set(handles.signal_uipanel,'Visible', 'on')
set(handles.text21,'Visible', 'on')
set(handles.scale1_popupmenu,'Visible', 'on')
set(handles.TaskRest_togglebutton,'Visible', 'on')

%%%Set oxy& deoxy
set(handles.oxy_checkbox,'Value',1);
set(handles.deoxy_checkbox,'Value',1);

%%%Set scales
set(handles.scale1_popupmenu,'Value',2);
set(handles.TaskRest_togglebutton,'Value',0);


%%%Show process pannel
set(handles.process_uipanel,'Visible', 'off')%%Hide

%LOAD
global step
global ch,global task, global rest
global oxy,global deoxy,global oxy1,global deoxy1, global oxyref,global deoxyref
global T, global filename,global tasks
global length
global h,global ax,global ax1, global ax2, global ax3
global ox1, global deox1, global ox2, global deox2
global string3
global signal
global c,
global short_step, global raw,global sav_data1,global sav_data2,global sav_data3,global sav_data4,global sav_data5, global sav_data6
global check_plot, global process
global yscale1, global yscale2

process=1;
%%CLEAR data
sav_data1=[];sav_data2=[];sav_data3=[];sav_data4=[];sav_data5=[];sav_data6=[];
oxy=[]; deoxy=[];oxyref=[];deoxyref=[];
tasks=[]; task=[]; rest=[];
c=0; 
short_step=0;
string3='not filtered yet';
%%%%
currentfolder=pwd;
% cd('C:\Users\NHUT TUAN\Dropbox\GUI\data testNIRS');
[filename pathname]=uigetfile({'*.txt'},'File Selector');
fullpathname=strcat(pathname,filename);
data=load(fullpathname);
filename=strsplit(filename,'.TXT');
filename=filename(1,1);
set(handles.edit1,'String',filename);
cd(currentfolder)
%%%show filter buttons
set(handles.filter_uipanel,'Visible', 'on')
set(handles.band_uipanel,'Visible', 'on')%%Bandpass
set(handles.band_togglebutton,'Visible', 'on')
set(handles.band_togglebutton,'Value', 0)
set(handles.adapt_uipanel,'Visible', 'on')%%Adaptive
set(handles.adapt_togglebutton,'Visible', 'on')
set(handles.adapt_togglebutton,'Value', 0)
set(handles.smooth_uipanel,'Visible', 'on')%%Smooth
set(handles.smooth_togglebutton,'Visible', 'on')
set(handles.smooth_togglebutton,'Value', 0)
set(handles.resting_uipanel,'Visible', 'on')%%Resting-stae reference
set(handles.resting_togglebutton,'Visible', 'on')
set(handles.resting_togglebutton,'Value', 0)
set(handles.kalman_togglebutton,'Value', 0)
set(handles.Kalman_uipanel,'Visible', 'on')
    
set(handles. browse_pushbutton,'Visible','off');%hide browse button

%%% hide Bandpass buttons
set(handles.type_popupmenu,'Visible', 'off');
set(handles.order_text,'Visible', 'off');
set(handles.order_edit,'Visible', 'off');
set(handles.cutoff1_edit,'Visible', 'off');
set(handles.cut1_text,'Visible', 'off');
set(handles.cutoff2_edit,'Visible', 'off');
set(handles.cut2_text,'Visible', 'off');
set(handles.method_popupmenu,'Visible', 'off');
set(handles.passband_edit,'Visible', 'off');
set(handles.passband_text,'Visible', 'off');
set(handles.stopband_edit,'Visible', 'off');
set(handles.stopband_text,'Visible', 'off');
set(handles.filter1_pushbutton,'Visible', 'off');
set(handles.save1_pushbutton,'Visible', 'off');
set(handles.sav1_checkbox,'Visible', 'off');
set(handles.text15,'String', '');

%%%hide Adaptive buttons
set(handles.low_pushbutton,'Visible', 'off');
set(handles.adapt_popupmenu,'Visible', 'off');
set(handles.ref_text,'Visible', 'off');
set(handles.adapt_left_pushbutton,'Visible', 'off');
set(handles.ref_edit,'Visible', 'off');
set(handles.adapt_right_pushbutton,'Visible', 'off');
set(handles.adapt_select_pushbutton,'Visible', 'off');
set(handles.text4,'Visible', 'off');
set(handles.filter2_pushbutton,'Visible', 'off');
set(handles.save2_pushbutton,'Visible', 'off');
set(handles.sav2_checkbox,'Visible', 'off');

%%%hide Smooth buttons
set(handles.combine3_togglebutton,'Visible', 'off');
set(handles.gaussian_togglebutton,'Visible', 'off');
set(handles.ema_togglebutton,'Visible', 'off');
set(handles.win_edit,'Visible', 'off');
set(handles.wsize_text,'Visible', 'off');
set(handles.alpha_edit,'Visible', 'off');
set(handles.alpha_text,'Visible', 'off');
set(handles.filter3_pushbutton,'Visible', 'off');
set(handles.save3_pushbutton,'Visible', 'off');
set(handles.sav3_checkbox,'Visible', 'off');
set(handles.text16,'String', '');

%%%Hide resting-state reference
set(handles.combine4_togglebutton,'Visible', 'off');
set(handles.resting_togglebutton,'Visible', 'on')
set(handles.resting_togglebutton,'Value', 0)
set(handles.pca_togglebutton,'Visible', 'off');
set(handles.k_text,'String', '');
set(handles.knum_text,'String', '');
set(handles.k_edit,'String', '');set(handles.k_edit,'Visible', 'off');
% set(handles.text20,'String', '');
set(handles.filter4_pushbutton,'Visible', 'off');
set(handles.save4_pushbutton,'Visible', 'off');
set(handles.sav4_checkbox,'Visible', 'off');

%%%hide Kalman buttons
set(handles.combine5_togglebutton,'Visible', 'off');
set(handles.noiseQ_text,'Visible', 'off');
set(handles.Q_edit,'Visible', 'off');
set(handles.Q_edit,'String', '');
set(handles.Q_text,'Visible', 'off');
set(handles.noiseR_text,'Visible', 'off');
set(handles.R_edit,'Visible', 'off');
set(handles.R_edit,'String', '');
set(handles.R_text,'Visible', 'off');
set(handles.filter5_pushbutton,'Visible', 'off');
set(handles.save5_pushbutton,'Visible', 'off');
set(handles.text27,'String', '');
set(handles.sav5_checkbox,'Visible', 'off');
set(handles.sav5_checkbox,'Value',0);

%%%hide SASS buttons
set(handles.combine6_togglebutton,'Visible', 'off');
set(handles.SASS_pushbutton,'Visible', 'off');
set(handles.filter6_pushbutton,'Visible', 'off');
set(handles.save6_pushbutton,'Visible', 'off');
set(handles.sav6_checkbox,'Visible', 'off');
set(handles.sav6_checkbox,'Value',0);

%%%Set channel
set(handles.ch_edit,'String',1)
step=str2num(get(handles.ch_edit,'String'));
set(handles.ch_text,'string','st');
set(handles.left_pushbutton,'Visible', 'on')
set(handles.ch_edit,'Visible', 'on')
set(handles.ch_text,'Visible', 'on')
set(handles.right_pushbutton,'Visible', 'on')
set(handles.text10,'Visible', 'on')
set(handles.total_ch_edit,'Visible', 'on')
set(handles.text11,'Visible', 'on')

%%%data management
time=data(:,1);
T=time(2,1);
tasks=data(:,2);
oxy_1=data(:,5:3:end);
deoxy_1=data(:,6:3:end);
total1=data(:,7:3:end);
ch=size(oxy_1,2);
length=size(oxy_1,1);
set(handles.total_ch_edit,'String',num2str(ch))

%%%set zero baseline
for i=1:ch
   oxy(:,i)= oxy_1(:,i)-oxy_1(1,i);
   deoxy(:,i)= deoxy_1(:,i)-deoxy_1(1,i);
   total(:,i)= total1(:,i)-total1(1,i);
end
oxy1=oxy;
deoxy1=deoxy;
raw=[tasks oxy deoxy];
%%%
for i=2: size(tasks,1)
    if tasks(i,1)==1 && tasks(i-1,1)==0
        task=[task i];
    elseif tasks(i,1)~=1 && tasks(i-1,1)==1
        rest=[rest i];
    end
end

%%%%%Plot
h(1)=handles.axes1;
h(2)=handles.axes2;
h(3)=handles.axes3;
h(4)=handles.axes4;

for i=1:4
    cla(h(i));
end
%%Raw signal
yscale1=[-0.5 0.5];yscale2=[-0.5 0.5];
axes(h(1));
plot(oxy(:,step),'r');
hold on
plot(deoxy(:,step),'b');
xlim([0 length]);ylim(yscale1);
% yL = get(h(1),'YLim');
% for i=1:size(rest_class,2)
%     line([rest_class(i) rest_class(i)],ylim);%line([5,5],ylim)
% end
% set(h(1),'Xcolor',[0 0 0],'Xtick',rest_class,'gridlinestyle','--','xgrid','on')

set(h(1),'xtick',[])
title(h(1),['raw data: Channel ' num2str(step)]);

%%%Filtered data

axes(h(2));
plot(oxy(:,step),'r');
hold on
plot(deoxy(:,step),'b');
xlim([0 length]);ylim(yscale2);
set(h(2),'xtick',[])
title(h(2),string3);
%%%



% --- Executes on button press in loadmat_pushbutton.
function loadmat_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to loadmat_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Vision
set(handles.savename_pushbutton,'Visible', 'off')
set(handles.browse_pushbutton,'Visible', 'off')
set(handles.signal_uipanel,'Visible', 'on')
set(handles.text21,'Visible', 'on')
% set(handles.text22,'Visible', 'on')
set(handles.scale1_popupmenu,'Visible', 'on')
% set(handles.scale2_popupmenu,'Visible', 'on')
set(handles.TaskRest_togglebutton,'Visible', 'on')

%%%Set oxy& deoxy
set(handles.oxy_checkbox,'Value',1);
set(handles.deoxy_checkbox,'Value',1);
set(handles.TaskRest_togglebutton,'Value',0)

%%%Set scales
set(handles.scale1_popupmenu,'Value',2);
% set(handles.scale2_popupmenu,'Value',2);
%%% hide Bandpass buttons
set(handles.type_popupmenu,'Visible', 'off');
set(handles.order_text,'Visible', 'off');
set(handles.order_edit,'Visible', 'off');
set(handles.cutoff1_edit,'Visible', 'off');
set(handles.cut1_text,'Visible', 'off');
set(handles.cutoff2_edit,'Visible', 'off');
set(handles.cut2_text,'Visible', 'off');
set(handles.method_popupmenu,'Visible', 'off');
set(handles.passband_edit,'Visible', 'off');
set(handles.passband_text,'Visible', 'off');
set(handles.stopband_edit,'Visible', 'off');
set(handles.stopband_text,'Visible', 'off');
set(handles.filter1_pushbutton,'Visible', 'off');
set(handles.save1_pushbutton,'Visible', 'off');
set(handles.sav1_checkbox,'Visible', 'off');
set(handles.text15,'String', '');

%%%hide Adaptive buttons
set(handles.low_pushbutton,'Visible', 'off');
set(handles.adapt_popupmenu,'Visible', 'off');
set(handles.ref_text,'Visible', 'off');
set(handles.adapt_left_pushbutton,'Visible', 'off');
set(handles.ref_edit,'Visible', 'off');
set(handles.adapt_right_pushbutton,'Visible', 'off');
set(handles.adapt_select_pushbutton,'Visible', 'off');
set(handles.text4,'Visible', 'off');
set(handles.filter2_pushbutton,'Visible', 'off');
set(handles.save2_pushbutton,'Visible', 'off');
set(handles.sav2_checkbox,'Visible', 'off');

%%%hide Smooth buttons
set(handles.gaussian_togglebutton,'Visible', 'off');
set(handles.ema_togglebutton,'Visible', 'off');
set(handles.win_edit,'Visible', 'off');
set(handles.combine3_togglebutton,'Visible', 'off');
set(handles.wsize_text,'Visible', 'off');
set(handles.alpha_edit,'Visible', 'off');
set(handles.alpha_text,'Visible', 'off');
set(handles.filter3_pushbutton,'Visible', 'off');
set(handles.save3_pushbutton,'Visible', 'off');
set(handles.sav3_checkbox,'Visible', 'off');
set(handles.text16,'String', '');

%%%hide RESTING-STATE buttons
set(handles.pca_togglebutton,'Visible', 'off');
set(handles.combine4_togglebutton,'Visible', 'off');
set(handles.k_text,'String', '');
set(handles.k_edit,'String', '');
set(handles.k_edit,'Visible', 'off');
set(handles.knum_text,'String', '');
% set(handles.text20,'String', '');
set(handles.filter4_pushbutton,'Visible', 'off');
set(handles.save4_pushbutton,'Visible', 'off');
set(handles.sav4_checkbox,'Visible', 'off');

%%%hide Kalman buttons
set(handles.combine5_togglebutton,'Visible', 'off');
set(handles.noiseQ_text,'Visible', 'off');
set(handles.Q_edit,'Visible', 'off');
set(handles.Q_edit,'String', '');
set(handles.Q_text,'Visible', 'off');
set(handles.noiseR_text,'Visible', 'off');
set(handles.R_edit,'Visible', 'off');
set(handles.R_edit,'String', '');
set(handles.R_text,'Visible', 'off');
set(handles.filter5_pushbutton,'Visible', 'off');
set(handles.save5_pushbutton,'Visible', 'off');
set(handles.text27,'String', '');
set(handles.sav5_checkbox,'Visible', 'off');
set(handles.sav5_checkbox,'Value',0);

%%%hide SASS buttons
set(handles.combine6_togglebutton,'Visible', 'off');
set(handles.SASS_pushbutton,'Visible', 'off');
set(handles.filter6_pushbutton,'Visible', 'off');
set(handles.save6_pushbutton,'Visible', 'off');
set(handles.sav6_checkbox,'Visible', 'off');
set(handles.sav6_checkbox,'Value',0);

%%%Reset channel
set(handles.ch_edit,'String','1')
set(handles.text4,'string','st');
global step
step=str2num(get(handles.ch_edit,'String'));
set(handles.ch_edit,'String',1)
set(handles.text4,'string','st');

%LOAD

global ch,global task, global rest
global oxy,global deoxy,global oxy1,global deoxy1, global oxyref,global deoxyref
global T, global filename, global tasks
global length
global h,global ax,global ax1, global ax2, global ax3
global ox1, global deox1, global ox2, global deox2
global string3
global signal
global c, 
global short_step, global raw,global sav_data1,global sav_data2,global sav_data3,global sav_data4,global sav_data5,global sav_data6
global check_plot, global process
global filter
global yscale1, global yscale2

 
%%CLEAR data and plot
sav_data1=[];sav_data2=[];sav_data3=[];sav_data4=[];sav_data5=[]; sav_data6=[];
oxy=[]; deoxy=[];oxyref=[];deoxyref=[];
tasks=[];task=[]; rest=[];
c=0; 
short_step=0;
string3='not filtered yet';
%Clear plot
%%%%%Plot
h(1)=handles.axes1;
h(2)=handles.axes2;
h(3)=handles.axes3;
h(4)=handles.axes4;

for i=1:4
    cla(h(i))
end

%%%Show process pannel

set(handles.filtered_uipanel,'Visible', 'off')%%Hide

%%%Hide 
set(handles.filter_uipanel,'Visible', 'off')
set(handles.axes2,'Visible', 'off')
set(handles.axes3,'Visible', 'off')
set(handles.axes4,'Visible', 'off')

%%%Set channel
set(handles.ch_edit,'String',1)
step=str2num(get(handles.ch_edit,'String'));
set(handles.ch_text,'string','st');
set(handles.left_pushbutton,'Visible', 'on')
set(handles.ch_edit,'Visible', 'on')
set(handles.ch_text,'Visible', 'on')
set(handles.right_pushbutton,'Visible', 'on')
set(handles.text10,'Visible', 'on')
set(handles.total_ch_edit,'Visible', 'on')
set(handles.text11,'Visible', 'on')

%%%%
filename1=filename;
currentfolder=pwd;
cd('D:\fNIRS\GUI\data testNIRS\processing_Thesis')
[filename pathname]=uigetfile({'*.mat'},'File Selector');
fullpathname=strcat(pathname,filename);
cd(currentfolder);
%%%
not_data=findstr(filename,'_channels');
check_notdata=size(not_data,2);

if check_notdata>0
    set(handles.edit1,'String','NOT DATA')
    pause(0.5)
    set(handles.edit1,'String',filename1)
elseif check_notdata==0
    currentfolder=pwd;
    data=load(fullpathname);
    data= data.sav_data;
%     data= cell2mat(data);
    size(data)
    filename=strsplit(filename,'.mat');
    filename=filename(1,1);
    set(handles.edit1,'String',filename)
    
    %%%%%Note channels and Ts
    cd(pathname);
    channels_name=char(strcat(filename,'_channels&Ts.mat'));
    
    note= importdata(channels_name);
    ch=note(1);
    T=note(2);
    set(handles.total_ch_edit,'String',num2str(ch));
    cd(currentfolder);
    
    %%%Show buttons in filter panel
    set(handles.band_uipanel,'Visible', 'on')%%Bandpass
    set(handles.band_togglebutton,'Visible', 'on')
    set(handles.band_togglebutton,'Value', 0)
    set(handles.adapt_uipanel,'Visible', 'on')%%Adaptive
    set(handles.adapt_togglebutton,'Visible', 'on')
    set(handles.adapt_togglebutton,'Value', 0)
    set(handles.smooth_uipanel,'Visible', 'on')%%Smooth
    set(handles.smooth_togglebutton,'Visible', 'on')
    set(handles.smooth_togglebutton,'Value', 0)
    set(handles.resting_togglebutton,'Visible', 'on')%%RESTING-STATE
    set(handles.resting_togglebutton,'Value', 0)
    set(handles.resting_uipanel,'Visible', 'on')
    set(handles.kalman_togglebutton,'Value', 0)%%KALMAN
    set(handles.kalman_togglebutton,'Visible', 'on')
    set(handles.Kalman_uipanel,'Visible', 'on')
    set(handles.SASS_uipanel,'Visible', 'on')%%SASS
    set(handles.sass_togglebutton,'Visible', 'on')
    set(handles.sass_togglebutton,'Value', 0)
    set(handles. browse_pushbutton,'Visible','off');%hide browse button
    set(handles.filter_uipanel,'Visible', 'off')
    %%%%seperate data
    assignin('base', 'data', data)
    length=size(data,1)
    width_data=size(data,2) -1; width_data, ch
    tasks=data.tasks;
    
    for i=2: size(tasks,1)
        if tasks(i,1)==1 && tasks(i-1,1)==0
            task=[task i];
        elseif tasks(i,1)~=1 && tasks(i-1,1)==1
            rest=[rest i];
        end
    end
    Filter_check=size(data,2);
    
    %%%Plot raw data
    oxy=data.oxy; deoxy=data.deoxy;
    oxy1=oxy;deoxy1=deoxy;
    
    raw=[tasks oxy deoxy];
    
    yscale1=[-0.5 0.5];yscale2=[-0.5 0.5];
    set(h(1),'Visible', 'on')
    axes(h(1))  
    plot(oxy(:,step),'r');
    hold on
    plot(deoxy(:,step),'b');

    xlim([0 length]);ylim(yscale1)
    set(h(1),'xtick',[])
    title(h(1),['raw data: channel ' num2str(step)]);
    
    if Filter_check==3
        process=1;
        set(handles.process_uipanel,'Visible', 'off')
        set(handles.filter_uipanel,'Visible', 'on')
        set(handles.savename_pushbutton,'Visible', 'on')
        %%Plot 
        set(h(2),'Visible', 'on')
        axes(h(2)); cla(h(2));
        plot(oxy(:,step),'r');
        hold on
        plot(deoxy(:,step),'b'); 
        ylim(yscale1);

        xlim([0 length]);
        set(h(2),'xtick',[])
        title(h(2),string3);
    elseif Filter_check==4
        process=0;
        set(handles.process_uipanel,'Visible', 'on')
        filter=data.Filtered_data; 
    end
    
    
    
end

% --- Executes on button press in filter3_pushbutton.
function filter3_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to filter3_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gaus, global ema
global oxyref, global deoxyref
global ch,global ox1, global deox1, global ox2, global deox2
global signal,global step
global h,global ax, global c, global ax1, global ax2, global ax3, global length
global oxy,global deoxy,global oxy1,global deoxy1,global oxy_filt1,global deoxy_filt1,global oxy_filt3, global deoxy_filt3, global filter3
global string3, global a, global b
global wsize, global alpha
global task_line1, global rest_line1, global task_line2, global rest_line2, global task, global rest

c=3;
wsize=str2num(get(handles.win_edit,'String'));
CHECK=size(wsize,2);
if CHECK==0
    set(handles.text16,'String', 'not enough information');
else
    
    combine3=get(handles.combine3_togglebutton,'value');
    if combine3==1
        y1=oxy_filt1;
        y2=deoxy_filt1;
    elseif combine3==0
        y1=oxy;
        y2=deoxy;
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%GAUSSIAN smooth
    if gaus==1
        alpha=str2num(get(handles.alpha_edit,'String'));
        check1=size(alpha,2);
        if check1==0 %%% BLANK or not
            set(handles.alpha_edit,'String','2.5');
        end
    
        string3='GAUSSIAN SMOOTH';
        windowWidth = int16(wsize);
        halfWidth = windowWidth / 2;
        gaussFilter = gausswin(wsize,alpha);
        gaussFilter = gaussFilter / sum(gaussFilter);
        oxy_gau=[]; deoxy_gau=[];    
        for i=1:ch
            oxy_filt=conv(y1(:,i), gaussFilter);
            deoxy_filt=conv(y2(:,i), gaussFilter);
            oxy_gau=[oxy_gau oxy_filt];
            deoxy_gau=[deoxy_gau deoxy_filt];
        end
        oxy_filt3=oxy_gau(wsize:end,:);
        deoxy_filt3=deoxy_gau(wsize:end,:);
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%EMA smooth
    if ema==1
        string3='EMA SMOOTH';
        oxy_filt3 = tsmovavg(y1,'e',wsize,1);
        deoxy_filt3 = tsmovavg(y2,'e',wsize,1);
    end

    %%%
    set(handles.text16,'String', '');
    oxy1=oxy_filt3;
    deoxy1=deoxy_filt3;

    filter3=[oxy1 deoxy1];

    %%%%%%%%%%%%%%%%%%%%%%%%%Plot
    check=get(handles.oxy_checkbox,'Value');
    check2=get(handles.deoxy_checkbox,'Value');

    cla(h(2))
    axes(h(2))
    ox2=plot(oxy1(:,step),'r');set(ox2,'tag','ox2');
    hold on
    deox2=plot(deoxy1(:,step),'b');set(deox2,'tag','deox2');

    xlim([0 length]);
    set(h(2),'xtick',[])
    title(h(2),[string3 ': Channel ' num2str(step)]);
    
    TaskRest=get(handles.TaskRest_togglebutton,'Value');
    if TaskRest==1
        for i=1:size(task,2)
            task_line2(i)=plot([task(i) task(i)],[-1,1],'Color',[0 0.75 0], 'Linestyle','--');%line([5,5],ylim)    
            rest_line2(i)=plot([rest(i) rest(i)],[-1,1],'Color',[0.25 0.25 0.25]);
        end
    end
    
    if check==1
        if check2==0
            delete(findobj('tag','deox1'))
            delete(findobj('tag','deox2'))
        end
    
    elseif check==0
        delete(findobj('tag','ox1'))
        delete(findobj('tag','ox2'))
        if check2==0
            delete(findobj('tag','deox1'))
            delete(findobj('tag','deox2'))
        end

    end

    set(handles.save3_pushbutton,'Visible', 'on')
    set(handles.sav3_checkbox,'Value',0)
end
% Sig_Noise=snr(oxy, oxy1);
% set(handles.snr_edit,'String',num2str(Sig_Noise))

% --- Executes on button press in save3_pushbutton.
function reset3_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to save3_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in save3_pushbutton.
function save3_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to save3_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filter3, global sav_data3,
a=get(handles.sav3_checkbox,'Value')
if a==0
    sav_data3=[sav_data3 filter3];
    filter3=[];
    set(handles.sav3_checkbox,'Value',1);
end

% --- Executes on button press in sav3_checkbox.
function sav3_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to sav3_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');
% Hint: get(hObject,'Value') returns toggle state of sav1_checkbox
if a==1
    set(hObject,'Value',0)
else
    set(hObject,'Value',1)
end

% --- Executes on button press in gaussian_togglebutton.
function gaussian_togglebutton_Callback(hObject, eventdata, handles)
% hObject    handle to gaussian_togglebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gau=get(hObject,'Value');
set(handles.ema_togglebutton,'Value', 0)
% Hint: get(hObject,'Value') returns toggle state of gaussian_togglebutton
global gaus, global ema
ema=0;
set(handles.sav3_checkbox,'Visible', 'on')
if gau==1
    gaus=1;
    set(handles.win_edit,'Visible', 'on')
    set(handles.wsize_text,'Visible', 'on')
    set(handles.alpha_edit,'Visible', 'on')
    set(handles.alpha_text,'Visible', 'on')
    set(handles.filter3_pushbutton,'Visible', 'on')
    set(handles.save3_pushbutton,'Visible', 'on')
    set(handles.text14,'String','GAUSSIAN SMOOTH');
    set(handles.win_edit,'String','');
    set(handles.alpha_edit,'String','');
else
    gaus=0;
    set(handles.win_edit,'Visible', 'off')
    set(handles.wsize_text,'Visible', 'off')
    set(handles.alpha_edit,'Visible', 'off')
    set(handles.alpha_text,'Visible', 'off')
    set(handles.filter3_pushbutton,'Visible', 'off')
    set(handles.save3_pushbutton,'Visible', 'off')
end

% --- Executes on button press in ema_togglebutton.
function ema_togglebutton_Callback(hObject, eventdata, handles)
% hObject    handle to ema_togglebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
EMA=get(hObject,'Value');
set(handles.gaussian_togglebutton,'Value', 0);
global gaus, global ema
gaus=0;
% Hint: get(hObject,'Value') returns toggle state of ema_togglebutton
if EMA==1
    ema=1;
    set(handles.win_edit,'Visible', 'on')
    set(handles.wsize_text,'Visible', 'on')
    set(handles.alpha_edit,'Visible', 'off')
    set(handles.alpha_text,'Visible', 'off')
    set(handles.filter3_pushbutton,'Visible', 'on')
    set(handles.text14,'String','EMA SMOOTH');
    set(handles.win_edit,'String','');
    set(handles.alpha_edit,'String','');
else
    ema=0;
    set(handles.win_edit,'Visible', 'off')
    set(handles.wsize_text,'Visible', 'off')
    set(handles.alpha_edit,'Visible', 'off')
    set(handles.alpha_text,'Visible', 'off')
    set(handles.filter3_pushbutton,'Visible', 'off')
    set(handles.save3_pushbutton,'Visible', 'off')
end


function alpha_edit_Callback(hObject, eventdata, handles)
% hObject    handle to alpha_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alpha_edit as text
%        str2double(get(hObject,'String')) returns contents of alpha_edit as a double


% --- Executes during object creation, after setting all properties.
function alpha_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function win_edit_Callback(hObject, eventdata, handles)
% hObject    handle to win_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of win_edit as text
%        str2double(get(hObject,'String')) returns contents of win_edit as a double


% --- Executes during object creation, after setting all properties.
function win_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to win_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in adapt_popupmenu.
function adapt_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to adapt_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global loc,global glob
global oxyref, global deoxyref

set(handles.filter1_pushbutton,'Visible', 'off');
val= get(hObject,'value');
set(handles.adapt_select_pushbutton,'Visible', 'off')
set(handles.text4,'Visible', 'off')
switch val
    case 1
        loc=0;
        glob=0;
    case 2
        loc=1;
        glob=0;
        set(handles.ref_edit,'Visible', 'on');
        set(handles.ref_edit,'String', '0');
        set(handles.adapt_left_pushbutton,'Visible', 'on')
        set(handles.adapt_right_pushbutton,'Visible', 'on')
        set(handles.ref_text,'Visible', 'on')
        oxyref=[];deoxyref=[];
    case 3
        loc=0;
        glob=1;
        set(handles.ref_edit,'Visible', 'on')
        set(handles.ref_edit,'String', '0');
        set(handles.adapt_left_pushbutton,'Visible', 'on')
        set(handles.adapt_right_pushbutton,'Visible', 'on')
        set(handles.ref_text,'Visible', 'on')
        oxyref=[];deoxyref=[];
  
end

% --- Executes during object creation, after setting all properties.
function adapt_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to adapt_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in filter2_pushbutton.
function filter2_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to filter2_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ch,global ox1, global deox1, global ox2, global deox2
global signal,global step,global T
global h,global ax, global c, global ax1, global ax2, global ax3, global length
global oxy,global deoxy,global oxy1,global deoxy1
global oxyref, global deoxyref,global oxyref1,global deoxyref1, global oxy_filt2,global deoxy_filt2,global oxy_filt1,global deoxy_filt1
global string3, global a, global b, global short_step
global k, global w_ox, global e_ox, global w_deox, global e_deox,global mu
global loc,global glob, global filter2
global task_line1, global rest_line1, global task_line2, global rest_line2, global task, global rest

c=2;string3='ADAPTIVE filter'; 
oxy_filt2=[]; deoxy_filt2=[];

%%%rename data to manage
if glob==1
    oxyref=oxyref1;
    deoxyref=deoxyref1;
end

y1=oxy_filt1; x1=oxyref;% x1=x1/std(x1)*std(y1);x1=repmat(x1,[1 11])
y2=deoxy_filt1; x2=deoxyref; %x2=x2/std(x2)*std(y2);

%%%Adaptive algorithm
k=20;
w_ox=zeros(1,k);w_ox(1)=1;e_ox=zeros(length,1);
w_deox=zeros(1,k);w_deox(1)=1;e_deox=zeros(length,1);
mu=0.01;

assignin ('base','x1',x1)
assignin ('base','y1',y1)
assignin ('base','w_ox',w_ox)

for i=1:ch
    for  t=k+1:length 
        e_ox(t)=y1(t,i)-w_ox*x1(t-k+1:t,1);
        w_ox=w_ox+2*mu*e_ox(t-1)*x1(t-k+1:t,1)'; 
   
        
        e_deox(t)=y2(t,i)-w_ox*x2(t-k+1:t,1);
        w_deox=w_deox+2*mu*e_deox(t-1)*x2(t-k+1:t,1)'; 
        
    end
     e_ox=e_ox/std(e_ox)*std(x1);
     e_deox=e_deox/std(e_deox)*std(x2);
    oxy_filt2=[oxy_filt2 e_ox];
    deoxy_filt2=[deoxy_filt2 e_deox];
end
size(oxy_filt2),size(deoxy_filt2)
oxy1=oxy_filt2;
deoxy1=deoxy_filt2;
filter2=[oxy1 deoxy1];


%%%Plot
check=get(handles.oxy_checkbox,'Value');
check2=get(handles.deoxy_checkbox,'Value');

cla(h(2))
axes(h(2))
ox2=plot(oxy1(:,step),'r');set(ox2,'tag','ox2');
hold on
deox2=plot(deoxy1(:,step),'b');set(deox2,'tag','deox2');

xlim([0 length]);
set(h(2),'xtick',[])
title(h(2),[string3 ': Channel ' num2str(step)]);

TaskRest=get(handles.TaskRest_togglebutton,'Value');
if TaskRest==1
    for i=1:size(task,2)
        task_line2(i)=plot([task(i) task(i)],[-1,1],'Color',[0 0.75 0], 'Linestyle','--');%line([5,5],ylim)    
        rest_line2(i)=plot([rest(i) rest(i)],[-1,1],'Color',[0.25 0.25 0.25]);
    end
end

if check==1
    if check2==0
        delete(findobj('tag','deox1'))
        delete(findobj('tag','deox2'))
    end
    
elseif check== 0
    delete(findobj('tag','ox1'))
    delete(findobj('tag','ox2'))
    if check2==0
        delete(findobj('tag','deox1'))
        delete(findobj('tag','deox2'))
    end

end

set(handles.save2_pushbutton,'Visible', 'on')
set(handles.sav2_checkbox,'Value',0)


% --- Executes on button press in save2_pushbutton.
function reset2_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to save2_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function ref_edit_Callback(hObject, eventdata, handles)
% hObject    handle to ref_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ref_edit as text
%        str2double(get(hObject,'String')) returns contents of ref_edit as a double


% --- Executes during object creation, after setting all properties.
function ref_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ref_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in adapt_right_pushbutton.
function adapt_right_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to adapt_right_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ch
global adapt_step
global ox1, global deox1, global ox2, global deox2,global ox3, global deox3
global signal
global h,global ax, global c,global c2, global ax1, global ax2, global ax3, global length
global step
global oxy,global deoxy
set(handles.adapt_select_pushbutton,'Visible', 'on')
set(h(3),'Visible', 'on');
adapt_step=str2num(get(handles.ref_edit,'String'));

adapt_step=adapt_step+1;
if adapt_step>ch
    adapt_step=1;
end
c2=1;
set(handles.ref_edit,'string',num2str(adapt_step));

check=get(handles.oxy_checkbox,'Value');
check2=get(handles.deoxy_checkbox,'Value');

cla(h(3));
axes(h(3))
ox3=plot(oxy(:,adapt_step),'r');set(ox3,'tag','ox3');
hold on
deox3=plot(deoxy(:,adapt_step),'b');set(deox3,'tag','deox3');
xlim([0 length]);
set(h(3),'xtick',[])
m=xlabel(['Reference: Channel ' num2str(adapt_step)]);
set(m, 'FontSize', 7);

if check==1
    if check2==0
        delete(findobj('tag','deox3'))
    end
    
elseif check== 0
    delete(findobj('tag','ox3'))
    if check2==0
        delete(findobj('tag','deox3'))
    end

end

% --- Executes on button press in adapt_left_pushbutton.
function adapt_left_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to adapt_left_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ch
global adapt_step
global ox1, global deox1, global ox2, global deox2,global ox3, global deox3
global signal
global h,global ax, global c,global c2, global ax1, global ax2, global ax3, global length
global step
global oxy,global deoxy
set(handles.adapt_select_pushbutton,'Visible', 'on')
set(h(3),'Visible', 'on');
adapt_step=str2num(get(handles.ref_edit,'String'));

adapt_step=adapt_step-1;
if adapt_step<1
    adapt_step=ch;
end
c2=1;
set(handles.ref_edit,'string',num2str(adapt_step));

check=get(handles.oxy_checkbox,'Value');
check2=get(handles.deoxy_checkbox,'Value');

cla(h(3));
axes(h(3))
ox3=plot(oxy(:,adapt_step),'r');set(ox3,'tag','ox3');
hold on
deox3=plot(deoxy(:,adapt_step),'b');set(deox3,'tag','deox3');
xlim([0 length]);
set(h(3),'xtick',[])
m=xlabel(['Reference: Channel ' num2str(adapt_step)]);
set(m, 'FontSize', 7);

if check==1
    if check2==0
        delete(findobj('tag','deox3'))
    end
    
elseif check== 0
    delete(findobj('tag','ox3'))
    if check2==0
        delete(findobj('tag','deox3'))
    end

end

% --- Executes on button press in adapt_select_pushbutton.
function adapt_select_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to adapt_select_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global loc,global glob, global count
global oxy, global deoxy, global oxyref, global deoxyref,global oxy_filt1,global deoxy_filt1
global adapt_step,global oxyref1, global deoxyref1
set(handles.text4,'Visible', 'on');

if loc==1
    oxyref=oxy_filt1(:,adapt_step);
    deoxyref=deoxy_filt1(:,adapt_step);
    set(handles.text4,'String', '')
end

if glob==1
    count=count+1;
    oxyref=[oxyref oxy_filt1(:,adapt_step)];
    deoxyref=[deoxyref deoxy_filt1(:,adapt_step)];        
    if count>1
        oxyref1=mean(oxyref,2);
        deoxyref1=mean(deoxyref,2);
    else
        oxyref1=oxyref;
        deoxyref1=deoxyref;
    end

    if count==1
        ref=['(' num2str(count) ' reference)'];
    else
        ref=['(' num2str(count) ' references)'];
    end
    set(handles.text4,'String', ref)
end
set(handles.filter2_pushbutton,'Visible', 'on')

% --- Executes on button press in low_pushbutton.
function low_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to low_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.band_uipanel,'Visible', 'on');
set(handles.type_popupmenu,'Visible', 'on');

%%%reset lowpass
    set(handles.type_popupmenu,'Value', 1);
    set(handles.method_popupmenu,'Value', 1);
    set(handles.order_edit,'String','');
    set(handles.cutoff1_edit,'String','');
    set(handles.cutoff2_edit,'String','');
    set(handles.passband_edit,'String','');
    set(handles.passband_edit,'String','');

% --- Executes on button press in save2_pushbutton.
function save2_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to save2_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filter2, global sav_data2,
a=get(handles.sav2_checkbox,'Value')
if a==0
    sav_data2=[sav_data2 filter2];size(sav_data2),
    filter2=[];
    set(handles.sav2_checkbox,'Value',1);
end
% --- Executes on button press in sav2_checkbox.
function sav2_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to sav2_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');
% Hint: get(hObject,'Value') returns toggle state of sav1_checkbox
if a==1
    set(hObject,'Value',0)
else
    set(hObject,'Value',1)
end

function order_edit_Callback(hObject, ~, handles)
% hObject    handle to order_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of order_edit as text
%        str2double(get(hObject,'String')) returns contents of order_edit as a double


% --- Executes during object creation, after setting all properties.
function order_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to order_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stopband_edit_Callback(hObject, eventdata, handles)
% hObject    handle to stopband_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stopband_edit as text
%        str2double(get(hObject,'String')) returns contents of stopband_edit as a double


% --- Executes during object creation, after setting all properties.
function stopband_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stopband_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function passband_edit_Callback(hObject, eventdata, handles)
% hObject    handle to passband_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of passband_edit as text
%        str2double(get(hObject,'String')) returns contents of passband_edit as a double


% --- Executes during object creation, after setting all properties.
function passband_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to passband_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in filter1_pushbutton.
function filter1_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to filter1_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ftype,global Wn,global N
global passband,global stopband
global cut1,global cut2,global Fcutoff
global string,global string3
global T
global ch, global filter1
global ox1, global deox1, global ox2, global deox2
global signal
global h,global ax, global c, global ax1, global ax2, global ax3, global length
global step
global oxy,global deoxy,global oxy1,global deoxy1,global oxy_filt1,global deoxy_filt1
global a, global b
global task_line1, global rest_line1, global task_line2, global rest_line2, global task, global rest

cla(h(3));
val=get(handles.method_popupmenu,'value');
val1=get(handles.type_popupmenu,'value');

N=str2num(get(handles.order_edit,'String'));check_1=size(N,2);
cut1=str2num(get(handles.cutoff1_edit,'String'));check_2=size(cut1,2);
cut2=str2num(get(handles.cutoff2_edit,'String'));check_3=size(cut2,2);
passband=str2num(get(handles.passband_edit,'String'));check_4=size(passband,2);
stopband=str2num(get(handles.stopband_edit,'String'));check_5=size(stopband,2);
% T=0.055
T=0.085

%%%Check blank or not
if check_1==0
    check1=0;
else
    check1=1;
end
%%%%%%%%%%%%%%%%%%%%%%%
if check_2==0
    check2=0;
else
    check2=1;
end
%%%%%%%%%%%%%%%%%%%%%%%
if check_3==0
    check3=0;
else
    check3=1;
end
%%%%


%%%Choose type(low-band-high)
if val1==1
    check=0;
elseif val1==2
    Fcutoff=cut1;
    Wn=Fcutoff*2*T;
    check3=1;
elseif val1==3
    Fcutoff=[cut1 cut2];
    Fcutoff;
    Wn=Fcutoff*2*T;
elseif val1==4
    Fcutoff=cut1;
%     Fcutoff;
    Wn=Fcutoff*2*T;
    check3=1;
end
Check=check1*check2*check3;

check1, check2, check3

%%%Choose technique(Butter-Chebyshev-Elliptic)
if Check==0
   set(handles.text15,'String', 'not enough info'); 
else
    if val==1
        Check=0;
    elseif val==2
        [b,a]=butter(N,Wn,ftype);
        check4=1;check5=1;
    elseif val==3
        if check_4==0
            r=10;
            set(handles.passband_edit,'String', num2str(r));
        else
            r=passband;
        end
        [b,a] = cheby1(N,r,Wn,ftype);
        
    elseif val==4
        if check_4==0
            r=40;
            set(handles.passband_edit,'String', num2str(r));
        else
            r=passband;
            [b,a] = cheby2(N,r,Wn,ftype);
        end
    elseif val==5
        if check_4==0
            rp=5;
            set(handles.passband_edit,'String', num2str(rp));
        else
            rp=passband;
        end
        
        if check_5==0
            rs=50;
            set(handles.stopband_edit,'String', num2str(rs));
        else
            rs=stopband;
         end
%         
        test=rp*rs*(rs-rp);
        if test>0
            [b,a]=ellip(N,rp,rs,Wn,ftype);
            
        elseif test==0
            Check=2;
            error='must greater than 0';
        else
            Check=2;
            error='passband<stopband';
        end
    end
end


Check

if Check==0
    set(handles.text15,'String', 'not enough information'); 
elseif Check==2
    set(handles.text15,'String', error);
elseif Check==1
    set(handles.text15,'String', '');
    string3=string;
    oxy_filt1=filter(b,a,oxy);
    deoxy_filt1=filter(b,a,deoxy);
    c=1;
% end

    check=get(handles.oxy_checkbox,'Value');
    check2=get(handles.deoxy_checkbox,'Value');

    %%%%%%%Plot
    oxy1=oxy_filt1;
    deoxy1=deoxy_filt1;

    filter1=[oxy1 deoxy1];

    cla(h(2));axes(h(2));
    ox2=plot(oxy1(:,step),'r');set(ox2,'tag','ox2');
    hold on
    deox2=plot(deoxy1(:,step),'b');set(deox2,'tag','deox2');

    xlim([0 length]);
    set(h(2),'xtick',[])
    title(h(2),[string3 ': Channel ' num2str(step)]);

    TaskRest=get(handles.TaskRest_togglebutton,'Value');
    if TaskRest==1
        for i=1:size(task,2)
            task_line2(i)=plot([task(i) task(i)],[-1,1],'Color',[0 0.75 0], 'Linestyle','--');%line([5,5],ylim)    
            rest_line2(i)=plot([rest(i) rest(i)],[-1,1],'Color',[0.25 0.25 0.25]);
        end
    end
    
    if check==1
        if check2==0
            delete(findobj('tag','deox1'))
            delete(findobj('tag','deox2'))
        end
    
    elseif check==0
        delete(findobj('tag','ox1'))
        delete(findobj('tag','ox2'))
        if check2==0
            delete(findobj('tag','deox1'))
            delete(findobj('tag','deox2'))
        end

    end
    
    combine4=get(handles.combine4_togglebutton,'value');
    if combine4==1
       global task_mark
       axes(h(3))
       ox3=plot(oxy(1:task_mark,step),'r');set(ox3,'tag','ox3');
       hold on
       deox3=plot(deoxy(1:task_mark,step),'b');set(deox3,'tag','deox3') 
       set(h(3),'xtick',[])
       m=xlabel(['Original Rest: Channel ' num2str(step)]);
       set(m, 'FontSize', 7);
       if check==1
           if check2==0
                delete(findobj('tag','deox3'))
                delete(findobj('tag','deox3'))
            end
    
        elseif check==0
            delete(findobj('tag','ox3'))
            delete(findobj('tag','ox3'))
            if check2==0
                delete(findobj('tag','deox3'))
                delete(findobj('tag','deox3'))
            end

       end
        %%%%%%
       cla(h(4));axes(h(4))
       ox4=plot(oxy_filt1(1:task_mark,step),'r');set(ox4,'tag','ox4');
       hold on
       deox3=plot(deoxy_filt1(1:task_mark,step),'b');set(deox3,'tag','deox4') 
       set(h(4),'xtick',[])
       m=xlabel(['Filtered Rest: Channel ' num2str(step)]);
       set(m, 'FontSize', 7);
       if check==1
           if check2==0
                delete(findobj('tag','deox4'))
                delete(findobj('tag','deox4'))
            end
    
        elseif check==0
            delete(findobj('tag','ox4'))
            delete(findobj('tag','ox4'))
            if check2==0
                delete(findobj('tag','deox4'))
                delete(findobj('tag','deox4'))
            end

        end
       
    end

    adapt=get(handles.adapt_togglebutton,'Value');
    
    
    combine3=get(handles.combine3_togglebutton,'value');
    combine4=get(handles.combine4_togglebutton,'value');
    combine5=get(handles.combine5_togglebutton,'value');
    combine6=get(handles.combine6_togglebutton,'value');
    
    Check_combine=combine3+combine4+combine5+combine6;
    
    if Check_combine==1
        set(handles.save1_pushbutton,'Visible', 'off')
        set(handles.sav1_checkbox,'Value',0);
    end
    
        if adapt==1
            set(handles.adapt_popupmenu,'Visible', 'on');
        else
            set(handles.save1_pushbutton,'Visible', 'on')
            set(handles.sav1_checkbox,'Value',0);
        end

    
end



% --- Executes on button press in save1_pushbutton.
function reset1_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to save1_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in method_popupmenu.
function method_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to method_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global string
% Hints: contents = cellstr(get(hObject,'String')) returns method_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from method_popupmenu
val2= get(hObject,'value');
switch val2
    case 1
        set(handles.filter1_pushbutton,'Visible', 'off')
        set(handles.save1_pushbutton,'Visible', 'on')
    case 2
        set(handles.filter1_pushbutton,'Visible', 'on')
        set(handles.passband_edit,'Visible', 'off')
        set(handles.passband_text,'Visible', 'off')
        set(handles.stopband_edit,'Visible', 'off')
        set(handles.stopband_text,'Visible', 'off')
        string='BUTTERWORTH filter';
    case 3
        set(handles.passband_edit,'String','')
        set(handles.stopband_edit,'String','')
        set(handles.filter1_pushbutton,'Visible', 'on')
        set(handles.passband_edit,'Visible', 'on')
        set(handles.passband_text,'Visible', 'on')
        set(handles.passband_text, 'String', 'passripple')
        string='CHEBYSHEV 1 filter';
    case 4
        set(handles.passband_edit,'String','')
        set(handles.stopband_edit,'String','')
        set(handles.filter1_pushbutton,'Visible', 'on')
        set(handles.passband_edit,'Visible', 'on')
        set(handles.passband_text,'Visible', 'on')
        set(handles.passband_text, 'String', 'stopripple')
        string='CHEBYSHEV 2 filter';
    case 5
        set(handles.passband_edit,'String','')
        set(handles.stopband_edit,'String','')
        set(handles.filter1_pushbutton,'Visible', 'on')
        set(handles.passband_edit,'Visible', 'on')
        set(handles.passband_text,'Visible', 'on')
        set(handles.passband_text, 'String', 'passband')
        set(handles.stopband_edit,'Visible', 'on')
        set(handles.stopband_text,'Visible', 'on')
        set(handles.stopband_text, 'String', 'stopband')
        string='ELLIPTIC filter';
end


% --- Executes during object creation, after setting all properties.
function method_popupmenu_CreateFcn(hObject, eventdata, ~)
% hObject    handle to method_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cutoff2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to cutoff2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cutoff2_edit as text
%        str2double(get(hObject,'String')) returns contents of cutoff2_edit as a double


% --- Executes during object creation, after setting all properties.
function cutoff2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cutoff2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cutoff1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to cutoff1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cutoff1_edit as text
%        str2double(get(hObject,'String')) returns contents of cutoff1_edit as a double


% --- Executes during object creation, after setting all properties.
function cutoff1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cutoff1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in type_popupmenu.
function type_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to type_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ftype
% Hints: contents = cellstr(get(hObject,'String')) returns type_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from type_popupmenu
val1= get(hObject,'value');
switch val1
    case 1
        set(handles.cutoff1_edit,'Visible', 'off')
        set(handles.cut1_text,'Visible', 'off')
        set(handles.cutoff2_edit,'Visible', 'off')
        set(handles.cut2_text,'Visible', 'off')
        set(handles.order_edit,'Visible', 'off')
        set(handles.order_text,'Visible', 'off')
    case 2
        ftype='low';
        set(handles.cutoff1_edit,'Visible', 'on')
        set(handles.cutoff1_edit,'String','')
        set(handles.cutoff2_edit,'String','')
        set(handles.cut1_text,'Visible', 'on')
        set(handles.cut1_text,'String', 'cutoff')
        set(handles.cutoff2_edit,'Visible', 'off')
        set(handles.cut2_text,'Visible', 'off')
        set(handles.order_edit,'Visible', 'on')
        set(handles.order_text,'Visible', 'on')
        set(handles.method_popupmenu,'Visible', 'on')
    case 3   %band
        ftype='bandpass';
        set(handles.cutoff1_edit,'Visible', 'on')
        set(handles.cutoff1_edit,'String','')
        set(handles.cutoff2_edit,'String','')
        set(handles.cut1_text,'Visible', 'on')
        set(handles.cut1_text,'String', '<cut1')
        set(handles.cutoff2_edit,'Visible', 'on')
        set(handles.cut2_text,'Visible', 'on')
        set(handles.order_edit,'Visible', 'on')
        set(handles.order_text,'Visible', 'on')
        set(handles.method_popupmenu,'Visible', 'on')
    case 4
         ftype='high';
        set(handles.cutoff1_edit,'Visible', 'on')
        set(handles.cutoff1_edit,'String','')
        set(handles.cutoff2_edit,'String','')
        set(handles.cut1_text,'Visible', 'on')
        set(handles.cut1_text,'String', 'cutoff')
        set(handles.cutoff2_edit,'Visible', 'off')
        set(handles.cut2_text,'Visible', 'off')
        set(handles.order_edit,'Visible', 'on')
        set(handles.order_text,'Visible', 'on')   
        set(handles.method_popupmenu,'Visible', 'on')
end

% --- Executes during object creation, after setting all properties.
function type_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to type_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save1_pushbutton.
function save1_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to save1_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filter1, global sav_data1,
a=get(handles.sav1_checkbox,'Value')
if a==0
    sav_data1=[sav_data1 filter1];
    filter1=[];
    set(handles.sav1_checkbox,'Value',1);
end

% --- Executes on button press in sav1_checkbox.
function sav1_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to sav1_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');
% Hint: get(hObject,'Value') returns toggle state of sav1_checkbox
if a==1
    set(hObject,'Value',0)
else
    set(hObject,'Value',1)
end


% --- Executes on button press in left_pushbutton.
function left_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to left_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ch, 
global ox1, global deox1, global ox2, global deox2
global signal
global h,global ax, global c, global yscale1
global rest_oxy, global rest_deoxy, global task_oxy, global task_deoxy
global ax1, global ax2, global ax3, global length
global step, global step2
global oxy,global deoxy,global oxy1,global deoxy1,global oxy_filt1,global deoxy_filt1
global string3, global a, global b, global process, global filt_num
global task_line1, global rest_line1, global task_line2, global rest_line2, global task, global rest, global task_mark


if process==1
   set(handles.process_uipanel,'Visible', 'off') 
end
step=str2num(get(handles.ch_edit,'String'));
step=step-1;
if step<1
    step=ch;
end
letter=rem(step,10);
if (step~=11)&(step~=12)&(step~=13)
    if letter==1
        set(handles.ch_text,'string','st');
    elseif letter==2
        set(handles.ch_text,'string','nd');
    elseif letter==3
        set(handles.ch_text,'string','rd');
    else
        set(handles.ch_text,'string','th');
    end
end

set(handles.ch_edit,'string',num2str(step));

check=get(handles.oxy_checkbox,'Value');
check2=get(handles.deoxy_checkbox,'Value');
for i=1:2
    cla(h(i))
end
axes(h(1)); 
ox1=plot(oxy(:,step),'r');set(ox1,'tag','ox1');
hold on
deox1=plot(deoxy(:,step),'b');set(deox1,'tag','deox1');
xlim([0 length]);
set(h(1),'xtick',[])
m=title(h(1),['raw data: Channel ' num2str(step)]);

TaskRest=get(handles.TaskRest_togglebutton,'Value')
if TaskRest==1
    for i=1:size(task,2)
        task_line1(i)=plot([task(i) task(i)],[-1,1],'Color',[0 0.75 0], 'Linestyle','--');%line([5,5],ylim)    
        rest_line1(i)=plot([rest(i) rest(i)],[-1,1],'Color',[0.25 0.25 0.25]);
    end
end

if process==1
    if c==0
        oxy1=oxy;
        deoxy1=deoxy;
    elseif c==1
        oxy1=oxy_filt1;
        deoxy1=deoxy_filt1;
    elseif c==-1
        string3=['filter ' num2str(step2) ': channel ' num2str(step)];
    end
    
    axes(h(2));
    ox2=plot(oxy1(:,step),'r');set(ox2,'tag','ox2');
    hold on
    deox2=plot(deoxy1(:,step),'b');set(deox2,'tag','deox2');

    xlim([0 length]);
    set(h(2),'xtick',[])
    title(h(2),[string3 ': Channel ' num2str(step)]);
    if TaskRest==1
        for i=1:size(task,2)
            task_line2(i)=plot([task(i) task(i)],[-1,1],'Color',[0 0.75 0], 'Linestyle','--');%line([5,5],ylim)    
            rest_line2(i)=plot([rest(i) rest(i)],[-1,1],'Color',[0.25 0.25 0.25]);
        end
    end
end

%%%%RESTING-STATE REFERENCE

if c==4
    %%REST
    cla(h(3));axes(h(3))
    ox3=plot(rest_oxy(:,step),'r');set(ox3,'tag','ox3');
    hold on
    deox3=plot(rest_deoxy(:,step),'b');set(deox3,'tag','deox3') 
    xlim([0 task_mark]);ylim(yscale1);
    set(h(3),'xtick',[])
    m=xlabel(['Original Rest: Channel ' num2str(step)]);
    set(m, 'FontSize', 7);
    
    %%Filtered rest
    cla(h(4));axes(h(4))
    ox4=plot(oxy1(1:task_mark,step),'r');set(ox4,'tag','ox4');
    hold on
    deox4=plot(deoxy(1:task_mark,step),'b');set(deox4,'tag','deox4') 
    xlim([0 task_mark]);ylim(yscale1);
    set(h(4),'xtick',[])
    m=xlabel(['Filtered Rest: Channel ' num2str(step)]);
    set(m, 'FontSize', 7);
    
%     %%TASK classification
    axes(h(1)); pca_line(1)=plot([task(1) task(1)],[-1,1],'Color',[0 0.75 0],'Linestyle','--','linewidth',2);
    axes(h(2)); pca_line(2)=plot([task(1) task(1)],[-1,1],'Color',[0 0.75 0],'Linestyle','--','linewidth',2);
    %%%
    
    if check==1
        if check2==0
            delete(findobj('tag','ox3'))
            delete(findobj('tag','ox4'))
        end
    elseif check==0
        delete(findobj('tag','deox3'))
        delete(findobj('tag','deox4'))
        if check2==0
            delete(findobj('tag','ox3'))
            delete(findobj('tag','ox4'))
        end
        
    end
end
%%%

if check==1
    if check2==0
        delete(findobj('tag','deox1'))
        if process==1
            delete(findobj('tag','deox2'))
        end
    end
    
elseif check== 0
    delete(findobj('tag','ox1'))
    if process==1
        delete(findobj('tag','ox2'))
    end
    
    if check2==0
        delete(findobj('tag','deox1'))
        if process==1
            delete(findobj('tag','deox2'))
        end
    end

end

% --- Executes on button press in right_pushbutton.
function right_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to right_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ch, 
global ox1, global deox1, global ox2, global deox2
global signal
global h,global ax, global c, global yscale1
global rest_oxy, global rest_deoxy, global task_oxy, global task_deoxy
global ax1, global ax2, global ax3, global length
global step, global step2
global oxy,global deoxy,global oxy1,global deoxy1,global oxy_filt1,global deoxy_filt1
global string3, global a, global b, global process, global filt_num
global task_line1, global rest_line1, global task_line2, global rest_line2, global task, global rest, global task_mark

if process==1
   set(handles.process_uipanel,'Visible', 'off') 
end

step=str2num(get(handles.ch_edit,'String'));
step=step+1;
if step>ch
    step=1;
end
letter=rem(step,10);
if (step~=11)&(step~=12)&(step~=13)
    if letter==1
        set(handles.ch_text,'string','st');
    elseif letter==2
        set(handles.ch_text,'string','nd');
    elseif letter==3
        set(handles.ch_text,'string','rd');
    else
        set(handles.ch_text,'string','th');
    end
end

set(handles.ch_edit,'string',num2str(step));

check=get(handles.oxy_checkbox,'Value');
check2=get(handles.deoxy_checkbox,'Value');
for i=1:2
    cla(h(i))
end
axes(h(1)); 
ox1=plot(oxy(:,step),'r');set(ox1,'tag','ox1');
hold on
deox1=plot(deoxy(:,step),'b');set(deox1,'tag','deox1');
xlim([0 length]);
set(h(1),'xtick',[])
m=title(h(1),['raw data: Channel ' num2str(step)]);

TaskRest=get(handles.TaskRest_togglebutton,'Value')
if TaskRest==1
    for i=1:size(task,2)
        task_line1(i)=plot([task(i) task(i)],[-1,1],'Color',[0 0.75 0], 'Linestyle','--');%line([5,5],ylim)    
        rest_line1(i)=plot([rest(i) rest(i)],[-1,1],'Color',[0.25 0.25 0.25]);
    end
end

if process==1
    if c==0
        oxy1=oxy;
        deoxy1=deoxy;
    elseif c==1
        oxy1=oxy_filt1;
        deoxy1=deoxy_filt1;
    elseif c==-1
        string3=['filter ' num2str(step2) ': channel ' num2str(step)];
    end

    axes(h(2));
    ox2=plot(oxy1(:,step),'r');set(ox2,'tag','ox2');
    hold on
    deox2=plot(deoxy1(:,step),'b');set(deox2,'tag','deox2');

    xlim([0 length]);
    set(h(2),'xtick',[])
    title(h(2),[string3 ': Channel ' num2str(step)]);
    if TaskRest==1
        for i=1:size(task,2)
            task_line2(i)=plot([task(i) task(i)],[-1,1],'Color',[0 0.75 0], 'Linestyle','--');%line([5,5],ylim)    
            rest_line2(i)=plot([rest(i) rest(i)],[-1,1],'Color',[0.25 0.25 0.25]);
        end
    end

end

%%%%RESTING-STATE REFERENCE
if c==4
    %%REST
    cla(h(3));axes(h(3))
    ox3=plot(rest_oxy(:,step),'r');set(ox3,'tag','ox3');
    hold on
    deox3=plot(rest_deoxy(:,step),'b');set(deox3,'tag','deox3') 
    xlim([0 task_mark]);ylim(yscale1);
    set(h(3),'xtick',[])
    m=xlabel(['Original Rest: Channel ' num2str(step)]);
    set(m, 'FontSize', 7);
    
     %%Filtered rest
    cla(h(4));axes(h(4))
    ox4=plot(oxy1(1:task_mark,step),'r');set(ox4,'tag','ox4');
    hold on
    deox4=plot(deoxy(1:task_mark,step),'b');set(deox4,'tag','deox4') 
    xlim([0 task_mark]);ylim(yscale1);
    set(h(4),'xtick',[])
    m=xlabel(['Filtered Rest: Channel ' num2str(step)]);
    set(m, 'FontSize', 7);
    
%     %%TASK classification
    axes(h(1)); pca_line(1)=plot([task(1) task(1)],[-1,1],'Color',[0 0.75 0],'Linestyle','--','linewidth',2);
    axes(h(2)); pca_line(2)=plot([task(1) task(1)],[-1,1],'Color',[0 0.75 0],'Linestyle','--','linewidth',2);
%     %%%
    
    if check==1
        if check2==0
            delete(findobj('tag','ox3'))
            delete(findobj('tag','ox4'))
        end
    elseif check==0
        delete(findobj('tag','deox3'))
        delete(findobj('tag','deox4'))
        if check2==0
            delete(findobj('tag','ox3'))
            delete(findobj('tag','ox4'))
        end
        
    end
end


if check==1
    if check2==0
        delete(findobj('tag','deox1'))
        if process==1
            delete(findobj('tag','deox2'))
        end
    end
    
elseif check== 0
    delete(findobj('tag','ox1'))
    if process==1
        delete(findobj('tag','ox2'))
    end
    
    if check2==0
        delete(findobj('tag','deox1'))
        if process==1
            delete(findobj('tag','deox2'))
        end
    end

end


function ch_edit_Callback(hObject, eventdata, handles)
% hObject    handle to ch_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch_edit as text
%        str2double(get(hObject,'String')) returns contents of ch_edit as a double


% --- Executes during object creation, after setting all properties.
function ch_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function total_ch_edit_Callback(hObject, eventdata, handles)
% hObject    handle to total_ch_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_ch_edit as text
%        str2double(get(hObject,'String')) returns contents of total_ch_edit as a double


% --- Executes during object creation, after setting all properties.
function total_ch_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to total_ch_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in filt_left_pushbutton.
function filt_left_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to filt_left_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ch, 
global ox1, global deox1, global ox2, global deox2
global signal
global length
global step
global oxy,global deoxy,global oxy1,global deoxy1,global oxy_filt1,global deoxy_filt1
global string3, global a, global b
global oxyref,global deoxyref
global T, global filename
global h,global ax,global ax1, global ax2, global ax3
global c
global short_step, global sav_data
global check_plot, global process
global filter, global num_filt, global filt_num,global step2

step=str2num(get(handles.ch_edit,'String'));
step2=str2num(get(handles.filter_edit,'String'));
step2=step2-1;
if step2<1
    step2=num_filt;
end
string3=['filter ' num2str(step2) ': channel ' num2str(step)];
set(handles.filter_edit,'string',num2str(step2));

plot_filt=filter{step2};
filt_sig=mat2cell(plot_filt,size(plot_filt,1),[ch ch]);
oxy1=filt_sig{1}; deoxy1=filt_sig{2};

cla(h(2))
axes(h(2))
plot(oxy1(:,step),'r');
hold on
plot(deoxy1(:,step),'b');

xlim([0 length]);
set(h(2),'xtick',[])
title(h(2),string3);

% --- Executes on button press in filt_right_pushbutton.
function filt_right_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to filt_right_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ch, 
global ox1, global deox1, global ox2, global deox2
global signal
global length
global step
global oxy,global deoxy,global oxy1,global deoxy1,global oxy_filt1,global deoxy_filt1
global string3, global a, global b
global oxyref,global deoxyref
global T, global filename
global h,global ax,global ax1, global ax2, global ax3
global c
global short_step, global sav_data
global check_plot, global process
global filter, global num_filt, global filt_num,global step2

step=str2num(get(handles.ch_edit,'String'));
step2=str2num(get(handles.filter_edit,'String'));
step2=step2+1;
if step2>num_filt
    step2=1;
end
string3=['filter ' num2str(step2) ': channel ' num2str(step)];
set(handles.filter_edit,'string',num2str(step2));

plot_filt=filter{step2};
filt_sig=mat2cell(plot_filt,size(plot_filt,1),[ch ch]);
oxy1=filt_sig{1}; deoxy1=filt_sig{2};

cla(h(2))
axes(h(2))
plot(oxy1(:,step),'r');
hold on
plot(deoxy1(:,step),'b');

xlim([0 length]);
set(h(2),'xtick',[])
title(h(2),string3);


function filter_edit_Callback(hObject, eventdata, handles)
% hObject    handle to filter_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filter_edit as text
%        str2double(get(hObject,'String')) returns contents of filter_edit as a double


% --- Executes during object creation, after setting all properties.
function filter_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filter_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in raw_pushbutton.
function raw_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to raw_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global step
global ch
global oxy,global deoxy,global oxy1,global deoxy1, global oxyref,global deoxyref
global T, global filename
global length
global h,global ax,global ax1, global ax2, global ax3
global ox1, global deox1, global ox2, global deox2
global string3
global signal
global c
global short_step, global sav_data
global check_plot, global process
global yscale1, global yscale2
global task_line1, global rest_line1, global task_line2, global rest_line2, global task, global rest

process=1;
string3='not filtered yet';
set(handles.filtered_uipanel,'Visible', 'off')
set(handles.filter_uipanel,'Visible', 'on')
set(handles.savename_pushbutton,'Visible', 'on')

%%% hide Bandpass buttons
set(handles.type_popupmenu,'Visible', 'off');
set(handles.order_text,'Visible', 'off');
set(handles.order_edit,'Visible', 'off');
set(handles.cutoff1_edit,'Visible', 'off');
set(handles.cut1_text,'Visible', 'off');
set(handles.cutoff2_edit,'Visible', 'off');
set(handles.cut2_text,'Visible', 'off');
set(handles.method_popupmenu,'Visible', 'off');
set(handles.passband_edit,'Visible', 'off');
set(handles.passband_text,'Visible', 'off');
set(handles.stopband_edit,'Visible', 'off');
set(handles.stopband_text,'Visible', 'off');
set(handles.filter1_pushbutton,'Visible', 'off');
set(handles.save1_pushbutton,'Visible', 'off');
set(handles.sav1_checkbox,'Visible', 'off');
set(handles.text15,'String', '');

%%%hide Adaptive buttons
set(handles.low_pushbutton,'Visible', 'off');
set(handles.adapt_popupmenu,'Visible', 'off');
set(handles.ref_text,'Visible', 'off');
set(handles.adapt_left_pushbutton,'Visible', 'off');
set(handles.ref_edit,'Visible', 'off');
set(handles.adapt_right_pushbutton,'Visible', 'off');
set(handles.adapt_select_pushbutton,'Visible', 'off');
set(handles.text4,'Visible', 'off');
set(handles.filter2_pushbutton,'Visible', 'off');
set(handles.save2_pushbutton,'Visible', 'off');
set(handles.sav2_checkbox,'Visible', 'off');

%%%hide Smooth buttons
set(handles.gaussian_togglebutton,'Visible', 'off');
set(handles.ema_togglebutton,'Visible', 'off');
set(handles.win_edit,'Visible', 'off');
set(handles.combine3_togglebutton,'Visible', 'off');
set(handles.wsize_text,'Visible', 'off');
set(handles.alpha_edit,'Visible', 'off');
set(handles.alpha_text,'Visible', 'off');
set(handles.filter3_pushbutton,'Visible', 'off');
set(handles.save3_pushbutton,'Visible', 'off');
set(handles.sav3_checkbox,'Visible', 'off');
set(handles.text16,'String', '');

%%%hide RESTING-STATE buttons
set(handles.pca_togglebutton,'Visible', 'off');
set(handles.combine4_togglebutton,'Visible', 'off');
set(handles.k_text,'String', '');
set(handles.k_edit,'String', '');
set(handles.k_edit,'Visible', 'off');
set(handles.knum_text,'String', '');
% set(handles.text20,'String', '');
set(handles.filter4_pushbutton,'Visible', 'off');
set(handles.save4_pushbutton,'Visible', 'off');
set(handles.sav4_checkbox,'Visible', 'off');

%%%hide Kalman buttons
set(handles.combine5_togglebutton,'Visible', 'off');
set(handles.noiseQ_text,'Visible', 'off');
set(handles.Q_edit,'Visible', 'off');
set(handles.Q_edit,'String', '');
set(handles.Q_text,'Visible', 'off');
set(handles.noiseR_text,'Visible', 'off');
set(handles.R_edit,'Visible', 'off');
set(handles.R_edit,'String', '');
set(handles.R_text,'Visible', 'off');
set(handles.filter5_pushbutton,'Visible', 'off');
set(handles.save5_pushbutton,'Visible', 'off');
set(handles.text27,'String', '');
set(handles.sav5_checkbox,'Visible', 'off');
set(handles.sav5_checkbox,'Value',0);

%%%hide SASS buttons
set(handles.combine6_togglebutton,'Visible', 'off');
set(handles.SASS_pushbutton,'Visible', 'off');
set(handles.filter6_pushbutton,'Visible', 'off');
set(handles.save6_pushbutton,'Visible', 'off');
set(handles.sav6_checkbox,'Visible', 'off');
set(handles.sav6_checkbox,'Value',0);

%%%Reset channel
set(handles.ch_edit,'String','1')
set(handles.text4,'string','st');
step=str2num(get(handles.ch_edit,'String'));
set(handles.ch_edit,'String',1)
set(handles.text4,'string','st');

%%Plot 
set(h(2),'Visible', 'on')
axes(h(2)); cla(h(2));
plot(oxy(:,step),'r');
hold on
plot(deoxy(:,step),'b'); 
ylim(yscale1);

xlim([0 length]);
set(h(2),'xtick',[])
title(h(2),string3);

TaskRest=get(handles.TaskRest_togglebutton,'Value')
% if TaskRest==1
%     for i=1:size(task,2)
%         task_line2(i)=plot([task(i) task(i)],[-1,1],'Color',[0 0.75 0], 'Linestyle','--');%line([5,5],ylim)    
%         rest_line2(i)=plot([rest(i) rest(i)],[-1,1],'Color',[0.25 0.25 0.25]);
%     end
% end


% --- Executes on button press in compare_filters_pushbutton.
function compare_filters_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to compare_filters_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global step
global ch
global oxy,global deoxy,global oxy1,global deoxy1, global oxyref,global deoxyref
global T, global filename
global length
global h,global ax,global ax1, global ax2, global ax3
global ox1, global deox1, global ox2, global deox2
global string3
global signal
global c
global short_step, global sav_data
global check_plot, global process
global filter, global num_filt, global step2
global yscale1, global yscale2
global task_line1, global rest_line1, global task_line2, global rest_line2, global task, global rest

process=1; c=-1;
num_filt=size(filter,2);

set(handles.filter_edit,'Visible', 'on')
set(handles.filter_edit,'String','1');
step=str2num(get(handles.ch_edit,'String'));
step2=str2num(get(handles.filter_edit,'String')), filter
plot_filt=filter{step2};
filt_sig=mat2cell(plot_filt,size(plot_filt,1),[ch ch]);
oxy1=filt_sig{1}; deoxy1=filt_sig{2};
%%Plot 
TaskRest=get(handles.TaskRest_togglebutton,'Value')

cla(h(2));set(h(2),'visible','on')
axes(h(2))
plot(oxy1(:,step),'r');
hold on
plot(deoxy1(:,step),'b');

xlim([0 length]);ylim(yscale2)
set(h(2),'xtick',[])
string3=['filter ' num2str(step2) ': channel ' num2str(step)];
title(h(2),string3);
if TaskRest==1
    for i=1:size(task,2)
        task_line2(i)=plot([task(i) task(i)],[-1,1],'Color',[0 0.75 0], 'Linestyle','--');%line([5,5],ylim)    
        rest_line2(i)=plot([rest(i) rest(i)],[-1,1],'Color',[0.25 0.25 0.25]);
    end
end

set(handles.filtered_uipanel,'Visible', 'on')


% --- Executes on button press in filter4_pushbutton.
function filter4_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to filter4_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ch,global ox1, global deox1, global ox2, global deox2
global signal,global step
global h,global ax, global c, global ax1, global ax2, global ax3, global length
global oxy,global deoxy,global oxy1,global deoxy1,global oxy_filt1,global deoxy_filt1
global string3, global a, global b, 
global task_line1, global task_line2,global rest_line1, global rest_line2 
global tasks, global rest_oxy, global task, global rest, global rest_deoxy, global task_oxy, global task_deoxy, global task_mark
global final1, global final2
global oxy_pca, global deoxy_pca, global Uox, global Sox, global Ude, global Sde
global pca_check, 
c=4;

pca_check;
% www=size(oxy1)
%%%%%%%%%%%%%PCA
if pca_check==1
    
    combine4=get(handles.combine4_togglebutton,'value');
    if combine4==1
        y1=oxy_filt1;
        y2=deoxy_filt1;
        
    elseif combine4==0
        y1=oxy;
        y2=deoxy;
    end
    
    rest_oxy=y1(1:task_mark,1:ch);
    task_oxy=y1(task_mark+1:end,1:ch);
    rest_deoxy=y2(1:task_mark,1:ch);
    task_deoxy=y2(task_mark+1:end,1:ch);
    
    K=str2num(get(handles.k_edit,'string'));
    k=K;
    check_k=size(K,2); check_U=size(Uox,2);

    if check_k==0
        k=1;
    else
        if K<1
            k=1;
        end
    
        if K>check_U
            k=check_U;
        end
    
    end
    set(handles.k_edit,'string',num2str(k))

    Uox1=[]; Ude1=[];
    Uox1=Uox(1:k,:)';
    Ude1=Ude(1:k,:)';

    for i=1:size(Uox,1)
        I(i,i)=1;
    end

    meanOxy=mean(y1);
    OXY= y1-repmat(meanOxy,length,1);

    meanDeoxy=mean(y2);
    DEOXY= y2-repmat(meanDeoxy,length,1);

    oxy1= (OXY*(I-(Uox1*Uox1')));
    deoxy1= (DEOXY*(I-(Ude1*Ude1')));
end
%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%WIENER
% if wiener_check==1
%     size(oxy1)
%     size(deoxy1)
% %     oxy1=final1;
% %     deoxy1=final2;
% end
% %%%%%%%%%%%%%%%%%%%
% ww=size(oxy1)
% size(deoxy1)
string3='Resting-state reference';
%%%Plot
check=get(handles.oxy_checkbox,'Value');
check2=get(handles.deoxy_checkbox,'Value');

axes(h(1))
pca_line(1)=plot([task(1) task(1)],[-1,1],'Color',[0 0.75 0],'Linestyle','--', 'linewidth',2);

cla(h(2))
axes(h(2))
ox2=plot(oxy1(:,step),'r');set(ox2,'tag','ox2');
hold on
deox2=plot(deoxy1(:,step),'b');set(deox2,'tag','deox2');

xlim([0 length]);
set(h(2),'xtick',[])
title(h(2),[string3 ': channel ' num2str(step)]);

pca_line(2)=plot([task(1) task(1)],[-1,1],'Color',[0 0.75 0],'Linestyle','--','linewidth',2);

 

TaskRest=get(handles.TaskRest_togglebutton,'Value');
if TaskRest==1
    for i=1:size(task,2)
        task_line2(i)=plot([task(i) task(i)],[-1,1],'Color',[0 0.75 0], 'Linestyle','--');%line([5,5],ylim)    
        rest_line2(i)=plot([rest(i) rest(i)],[-1,1],'Color',[0.25 0.25 0.25]);
    end
end

if check==1
    if check2==0
        delete(findobj('tag','deox1'))
        delete(findobj('tag','deox2'))
    end
    
elseif check== 0
    delete(findobj('tag','ox1'))
    delete(findobj('tag','ox2'))
    if check2==0
        delete(findobj('tag','deox1'))
        delete(findobj('tag','deox2'))
    end

end

%%Filtered rest
    cla(h(4));axes(h(4))
    ox4=plot(oxy1(1:task_mark,step),'r');set(ox4,'tag','ox4');
    hold on
    deox4=plot(deoxy1(1:task_mark,step),'b');set(deox4,'tag','deox4') 
    
    set(h(4),'xtick',[])
    m=xlabel(['Filtered Rest: Channel ' num2str(step)]);
    set(m, 'FontSize', 7);

set(handles.save4_pushbutton,'Visible', 'on')
set(handles.sav4_checkbox,'Value',0)

%%%%%SAVE DATA
global filter4
filter4=[oxy1 deoxy1];


% --- Executes on button press in save4_pushbutton.
function save4_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to save4_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filter4, global sav_data4,
a=get(handles.sav4_checkbox,'Value')
if a==0
    sav_data4=[sav_data4 filter4];
    filter4=[];
    set(handles.sav4_checkbox,'Value',1);
end

% --- Executes on button press in sav4_checkbox.
function sav4_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to sav4_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');
% Hint: get(hObject,'Value') returns toggle state of sav1_checkbox
if a==1
    set(hObject,'Value',0)
else
    set(hObject,'Value',1)
end

% --- Executes on button press in rest_pushbutton.
function rest_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to rest_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in task_pushbutton.
function task_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to task_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in resting_togglebutton.
function resting_togglebutton_Callback(hObject, eventdata, handles)
% hObject    handle to resting_togglebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
on4=get(hObject,'Value');

global ch,global ox1, global deox1, global ox2, global deox2
global signal,global step
global h,global ax, global c, global ax1, global ax2, global ax3, global length
global oxy,global deoxy,global oxy1,global deoxy1,global oxy_filt1,global deoxy_filt1
global string3, global a, global b, 
global tasks, global rest_oxy, global rest_deoxy, global task_oxy, global task_deoxy, global task_mark
global yscale1
string3='not filtered yet';

set(handles.process_uipanel,'Visible', 'off')
% set(handles.text20,'String', '');
% Hint: get(hObject,'Value') returns toggle state of smooth_togglebutton
if on4==0
    c=0;
    cla(h(3))
    set(h(3),'Visible', 'off');
    cla(h(4))
    set(h(4),'Visible', 'off');
    %%% hide RESTING-STATE REFERENCE buttons
    %%%
    set(handles.combine4_togglebutton,'Visible', 'off');
    set(handles.pca_togglebutton,'Visible', 'off');
    set(handles.k_text,'String', '');
    set(handles.k_edit,'String', '');
    set(handles.k_edit,'Visible', 'off');
    set(handles.knum_text,'String', '');
    set(handles.filter4_pushbutton,'Visible', 'off');
    set(handles.save4_pushbutton,'Visible', 'off');
    set(handles.sav4_checkbox,'Visible', 'off');
    
    %%show other options
    set(handles.adapt_uipanel,'Visible', 'on');%%show adaptive option
    set(handles.adapt_togglebutton,'Visible', 'on');
    set(handles.band_uipanel,'Visible', 'on');%%show bandpass option
    set(handles.band_togglebutton,'Visible', 'on');
    set(handles.smooth_uipanel,'Visible', 'on');%%show smooths reference option
    set(handles.smooth_togglebutton,'Visible', 'on'); 
    set(handles.Kalman_uipanel,'Visible', 'on');%%show Kalman option
    set(handles.kalman_togglebutton,'Visible', 'on');
    set(handles.SASS_uipanel,'Visible', 'on');%%show SASS option
    set(handles.sass_togglebutton,'Visible', 'on');
     
    %%%reset
    set(handles.win_edit,'String','');
    set(handles.alpha_edit,'String','');
    set(handles.text14,'String','');
    set(handles.gaussian_togglebutton,'Value',0);
    set(handles.ema_togglebutton,'Value',0);
    set(handles.sav3_checkbox,'Value',0);
    set(handles.pca_togglebutton,'value',0);

    c=0;
    rest_oxy=[];
    task_oxy=[];
    rest_deoxy=[];
    task_deoxy=[];
   
   
   %%Plot
    check=get(handles.oxy_checkbox,'Value');
    check2=get(handles.deoxy_checkbox,'Value');


    cla(h(2));
    axes(h(2))
    ox2=plot(oxy(:,step),'r');set(ox2,'tag','ox2');
    hold on
    deox2=plot(deoxy(:,step),'b');set(deox2,'tag','deox2');

    xlim([0 length]);
    set(h(2),'xtick',[])
    title(h(2),string3);
    
    cla(h(1));
    axes(h(1))
    ox1=plot(oxy(:,step),'r');set(ox1,'tag','ox1');
    hold on
    deox1=plot(deoxy(:,step),'b');set(deox2,'tag','deox1');

    xlim([0 length]);
    set(h(1),'xtick',[])
    title(h(2),['raw data: Channel ' num2str(step)]);
    
    global task_line1, global rest_line1, global task_line2, global rest_line2, global task, global rest
    TaskRest=get(handles.TaskRest_togglebutton,'Value');
    if TaskRest==1
        for i=1:size(task,2)
            task_line2(i)=plot([task(i) task(i)],[-1,1],'Color',[0 0.75 0], 'Linestyle','--');%line([5,5],ylim)    
            rest_line2(i)=plot([rest(i) rest(i)],[-1,1],'Color',[0.25 0.25 0.25]);
        end
    end

    if check==1
        if check2==0
            delete(findobj('tag','deox1'))
            delete(findobj('tag','deox2'))
        end
    
    elseif check== 0
        delete(findobj('tag','ox1'))
        delete(findobj('tag','ox2'))
        if check2==0
            delete(findobj('tag','deox1'))
            delete(findobj('tag','deox2'))
        end

    end
   
else
    c=4;
    %%%
    %%%
    set(handles.pca_togglebutton,'Visible', 'on');
    set(handles.sav4_checkbox,'Visible', 'on');
    set(handles.combine4_togglebutton,'Visible', 'on');
    set(handles.combine4_togglebutton,'Value', 0);
    
    %%hide other options
    set(handles.adapt_uipanel,'Visible', 'off');%%hide adaptive option
    set(handles.adapt_togglebutton,'Visible', 'off');
    set(handles.band_uipanel,'Visible', 'off');%%hide bandpass option
    set(handles.band_togglebutton,'Visible', 'off');
    set(handles.smooth_uipanel,'Visible', 'off');%%hide Smooths option
    set(handles.smooth_togglebutton,'Visible', 'off');
    set(handles.Kalman_uipanel,'Visible', 'off');%%hide Kalman option
    set(handles.kalman_togglebutton,'Visible', 'off');
    set(handles.SASS_uipanel,'Visible', 'off');%%hide SASS option
    set(handles.sass_togglebutton,'Visible', 'off');
    
    
    step=str2num(get(handles.ch_edit,'String'));
    
    for i=2: size(tasks,1)
        if tasks(i,1)==1 && tasks(i-1,1)==0
            break
        end
    end
    task_mark=i;
   
    rest_oxy=oxy(1:task_mark,1:ch);
    task_oxy=oxy(task_mark+1:end,1:ch);
    rest_deoxy=deoxy(1:task_mark,1:ch);
    task_deoxy=deoxy(task_mark+1:end,1:ch);
    
    %%%Plot REST
    cla(h(3)); set(h(3),'Visible', 'on');
    axes(h(3));
    ox3=plot(rest_oxy(:,step),'r');set(ox3,'tag','ox3');
    hold on
    deox3=plot(rest_deoxy(:,step),'b'); set(deox3,'tag','deox3')
%     axis tight
    set(h(3),'xtick',[])
    xlim([0 task_mark]);ylim(yscale1);
    m=xlabel(['Original REST: Channel ' num2str(step)]);
    set(m, 'FontSize', 7);
    %%%Plot TASK
    cla(h(4));set(h(4),'Visible', 'on');
    axes(h(4));
    ox4=plot(rest_oxy(:,step),'r'); set(ox4,'tag','ox4');
    hold on
    deox4=plot(rest_deoxy(:,step),'b'); set(deox4,'tag','deox4') 
    xlim([0 task_mark]);ylim(yscale1);
    set(h(4),'xtick',[])
    m=xlabel(['REST: Channel ' num2str(step)]);
    set(m, 'FontSize', 7);
    
    %%%
    check=get(handles.oxy_checkbox,'Value');
    check2=get(handles.deoxy_checkbox,'Value');
    
    if check==1
        if check2==0
            delete(findobj('tag','deox3'))
            delete(findobj('tag','deox4'))
        end
    
    elseif check==0
        delete(findobj('tag','ox3'))
        delete(findobj('tag','ox4'))
        if check2==0
            delete(findobj('tag','deox3'))
            delete(findobj('tag','deox4'))
        end

    end
    
end




% --- Executes on selection change in scale1_popupmenu.
function scale1_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to scale1_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global h,global ax, global c,global c2
global ax1, global ax2, global ax3, global length
global step, global adapt_step
global rest_oxy, global rest_deoxy, global task_oxy, global task_deoxy
global oxy,global deoxy,global oxy1,global deoxy1
global string3
global yscale1, global yscale2
global process
if process==1
   set(handles.process_uipanel,'Visible', 'off') 
end

% Hints: contents = cellstr(get(hObject,'String')) returns scale1_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from scale1_popupmenu
val= get(hObject,'value');
switch val
    case 1
        yscale1=[-1 1];
    case 2
        yscale1=[-0.5 0.5];
    case 3
        yscale1=[-0.1 0.1];
    case 4
        yscale1=[-0.05 0.05];
    case 5
        yscale1=[-0.01 0.01];
  
end

%%%%%PLOT
%H1
cla(h(1));axes(h(1))
ox1=plot(oxy(:,step),'r');set(ox1,'tag','ox1');
hold on
deox1=plot(deoxy(:,step),'b');set(deox1,'tag','deox1');
xlim([0 length]);ylim(yscale1);
set(h(1),'xtick',[])
m=title(h(1),['raw data: Channel ' num2str(step)]);

global task_line1, global task_line2,global rest_line1, global rest_line2,global task, global rest 
TaskRest=get(handles.TaskRest_togglebutton,'Value')
if TaskRest==1
    for i=1:size(task,2)
        task_line1(i)=plot([task(i) task(i)],[-1,1],'Color',[0 0.75 0], 'Linestyle','--');%line([5,5],ylim)    
        rest_line1(i)=plot([rest(i) rest(i)],[-1,1],'Color',[0.25 0.25 0.25]);
    end
end

check=get(handles.oxy_checkbox,'Value');
check2=get(handles.deoxy_checkbox,'Value');
if check==1
   if check2==0
      delete(findobj('tag','deox1'))
%       delete(findobj('tag','deox2')) 
   end
   
elseif check==0
    delete(findobj('tag','ox1'))
%     delete(findobj('tag','ox2'))
    if check2==0
      delete(findobj('tag','deox1'))
%       delete(findobj('tag','deox2')) 
   end
end

if process==1
    %%H2
    cla(h(2));axes(h(2));
    ox2=plot(oxy1(:,step),'r');set(ox2,'tag','ox2');
    hold on
    deox2=plot(deoxy1(:,step),'b');set(deox2,'tag','deox2');
    xlim([0 length]);ylim(yscale1);
    set(h(2),'xtick',[])
    m1=title(h(2),string3);

    if TaskRest==1
        for i=1:size(task,2)
            task_line1(i)=plot([task(i) task(i)],[-1,1],'Color',[0 0.75 0], 'Linestyle','--');%line([5,5],ylim)    
            rest_line1(i)=plot([rest(i) rest(i)],[-1,1],'Color',[0.25 0.25 0.25]);
        end
    end
    
    if check==1
        if check2==0
%             delete(findobj('tag','deox1'))
            delete(findobj('tag','deox2')) 
        end
   
    elseif check==0
%         delete(findobj('tag','ox1'))
        delete(findobj('tag','ox2'))
        if check2==0
%             delete(findobj('tag','deox1'))
            delete(findobj('tag','deox2')) 
        end
    end
   %%%%%%%H3, H4 (RESTING) 
   global task_mark
   if (c==4)
       %%%H3
        cla(h(3));axes(h(3));
        ox3=plot(oxy(1:task_mark,step),'r');set(ox3,'tag','ox3');
        hold on
        deox3=plot(deoxy(1:task_mark,step),'b');set(deox3,'tag','deox3');
        xlim([0 task_mark]);ylim(yscale1);
        set(h(3),'xtick',[])
        m=xlabel(['Original Rest: Channel ' num2str(step)]);
        set(m, 'FontSize', 7);

    
        if check==1
            if check2==0
%               delete(findobj('tag','deox1'))
                delete(findobj('tag','deox3')) 
            end
   
        elseif check==0
%           delete(findobj('tag','ox1'))
            delete(findobj('tag','ox3'))
            if check2==0
%               delete(findobj('tag','deox1'))
                delete(findobj('tag','deox3')) 
            end
        end
        
        %%%H4
        cla(h(4));axes(h(4));
        ox4=plot(oxy1(1:task_mark,step),'r');set(ox4,'tag','ox4');
        hold on
        deox4=plot(deoxy1(1:task_mark,step),'b');set(deox4,'tag','deox4');
        xlim([0 task_mark]);ylim(yscale1);
        set(h(4),'xtick',[])
        m=xlabel(['Filtered Rest: Channel ' num2str(step)]);
        set(m, 'FontSize', 7);

    
        if check==1
            if check2==0
%               delete(findobj('tag','deox1'))
                delete(findobj('tag','deox4')) 
            end
   
        elseif check==0
%           delete(findobj('tag','ox1'))
            delete(findobj('tag','ox4'))
            if check2==0
%               delete(findobj('tag','deox1'))
                delete(findobj('tag','deox4')) 
            end
        end
   end
end


% --- Executes during object creation, after setting all properties.
function scale1_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scale1_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in scale2_popupmenu.
function scale2_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to scale2_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global h,global ax, global c,global c2, 
% global ax1, global ax2, global ax3, global length
% global step, global adapt_step
% global rest_oxy, global rest_deoxy, global task_oxy, global task_deoxy
% global oxy,global deoxy,global oxy1,global deoxy1
% global string3
% global yscale1, global yscale2
% global process
% if process==1
%    set(handles.process_uipanel,'Visible', 'off') 
% end
% % Hints: contents = cellstr(get(hObject,'String')) returns scale2_popupmenu contents as cell array
% %        contents{get(hObject,'Value')} returns selected item from scale2_popupmenu
% val= get(hObject,'value');
% switch val
%     case 1
%         yscale2=[-1 1];
%     case 2
%         yscale2=[-0.5 0.5];
%     case 3
%         yscale2=[-0.1 0.1];
%     case 4
%         yscale2=[-0.05 0.05];
%     case 5
%         yscale2=[-0.01 0.01];
%   
% end
% %%PLOT
% if process==1
%     axes(h(2));
%     plot(oxy1(:,step),'r');
%     hold on
%     plot(deoxy1(:,step),'b');
%     xlim([0 length]);ylim(yscale2);
% 
%     set(h(2),'xtick',[])
%     title(h(2),string3);
% end

% --- Executes during object creation, after setting all properties.
function scale2_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scale2_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in TaskRest_togglebutton.
function TaskRest_togglebutton_Callback(hObject, eventdata, handles)
% hObject    handle to TaskRest_togglebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global step
global ch, global tasks, global task, global rest
global oxy,global deoxy,global oxy1,global deoxy1, global oxyref,global deoxyref
global T, global filename
global length
global h,global ax,global ax1, global ax2, global ax3
global ox1, global deox1, global ox2, global deox2
global string3
global signal
global c
global short_step, global sav_data
global check_plot, global process
global yscale1, global yscale2
global task_line1, global task_line2,global rest_line1, global rest_line2 

if process==1
   set(handles.process_uipanel,'Visible', 'off') 
end
% Hint: get(hObject,'Value') returns toggle state of TaskRest_togglebutton
taskrest=get(hObject,'Value');

if taskrest==1
% %     for i=2: size(tasks,1)
% %         if tasks(i,1)==1 && tasks(i-1,1)==0
% %             task=[task i];
% %         elseif tasks(i,1)~=1 && tasks(i-1,1)==1
% %             rest=[rest i];
% %         end
% %     end
%   task(1);
%   rest;
  axes(h(1))
  for i=1:size(task,2)
        task_line1(i)=plot([task(i) task(i)],[-1,1],'Color',[0 0.75 0], 'Linestyle','--');%line([5,5],ylim)    
        rest_line1(i)=plot([rest(i) rest(i)],[-1,1],'Color',[0.25 0.25 0.25]);
  end
 
  
  if c~=0 || process==1
        axes(h(2))
        for i=1:size(task,2)
            task_line2(i)=plot([task(i) task(i)],[-1,1],'Color',[0 0.75 0], 'Linestyle','--');%line([5,5],ylim)   
            rest_line2(i)=plot([rest(i) rest(i)],[-1,1],'Color',[0.25 0.25 0.25]);
        end
  end    
else
    for i=1:size(task,2)
        delete(task_line1(i))  
        delete(rest_line1(i))
    end
    
     if c~=0 || process==1
        for i=1:size(task,2)
            delete(task_line2(i))   
            delete(rest_line2(i))
        end
     end
end


function snr_edit_Callback(hObject, eventdata, handles)
% hObject    handle to snr_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of snr_edit as text
%        str2double(get(hObject,'String')) returns contents of snr_edit as a double


% --- Executes during object creation, after setting all properties.
function snr_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to snr_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pca_togglebutton.
function pca_togglebutton_Callback(hObject, eventdata, handles)
% hObject    handle to pca_togglebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ch,global ox1, global deox1, global ox2, global deox2
global signal,global step
global h,global ax, global c, global ax1, global ax2, global ax3, global length
global oxy,global deoxy,global oxy1,global deoxy1,global oxy_filt1,global deoxy_filt1
global string3, global a, global b, 
global tasks, global rest_oxy, global rest_deoxy, global task_oxy, global task_deoxy
global oxy_pca, global deoxy_pca, global Uox, global Sox, global Ude, global Sde, global length1;
global pca_check, 

oxy_pca=[]; deoxy_pca=[];
pca_value=get(hObject,'Value');

if pca_value==1
    pca_check=1;
%%%OXY
    H_base=rest_oxy;
    [length1 ch]=size(H_base);
    mH_base=mean(H_base);
    H_base= H_base-repmat(mH_base,length1,1);
 
    C = (1/length1)*(H_base')*(H_base); % Covariance matrix

    [Uox Sox]=eig(C); 

    %%%DEOXY
    H_base1=rest_deoxy;
    % [length ch]=size(H_base)
    mH_base1=mean(H_base1);
    H_base1= H_base1-repmat(mH_base1,length1,1);
    C = (1/length1)*(H_base1')*(H_base1); % Covariance matrix

    [Ude Sde]=eig(C); %??

    %%% Choose  k
    string=['(from 1 to ' num2str(size(Uox,2)) ')'];
    pause (0.5);
    set(handles.k_text,'String', 'Choose K');
    set(handles.k_edit,'String', '');
    set(handles.k_edit,'Visible', 'on');
    set(handles.knum_text,'String', string);

    set(handles.filter4_pushbutton,'Visible', 'on');
    set(handles.save4_pushbutton,'Visible', 'on');
else
    pca_check=0;
    set(handles.k_text,'String', '');
    set(handles.k_edit,'String', '');
    set(handles.k_edit,'Visible', 'off');
    set(handles.knum_text,'String','');

    set(handles.filter4_pushbutton,'Visible', 'off');
    set(handles.save4_pushbutton,'Visible', 'off');
end

function k_edit_Callback(hObject, eventdata, handles)
% hObject    handle to k_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of k_edit as text
%        str2double(get(hObject,'String')) returns contents of k_edit as a double


% --- Executes during object creation, after setting all properties.
function k_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to k_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes on button press in home_pushbutton.
function home_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to home_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(GUI_offline1);
run('C:\Users\NHUT TUAN\Dropbox\GUI\fNIRS home interface\fNIRS_home.m');
cd('C:\Users\NHUT TUAN\Dropbox\GUI\fNIRS home interface');


% --- Executes on button press in kalman_togglebutton.
function kalman_togglebutton_Callback(hObject, eventdata, handles)
% hObject    handle to kalman_togglebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global cut1,global cut2,global Fcutoff,global passband,global stopband
global ch,global ox1, global deox1, global ox2, global deox2
global signal,global step
global h,global ax, global c, global ax1, global ax2, global ax3, global length
global oxy,global deoxy,global oxy1,global deoxy1,global oxy_filt1,global deoxy_filt1
global string3, global a, global b
string3='not filtered yet';
set(handles.process_uipanel,'Visible', 'off')
set(handles.text27,'String', '');
% Hint: get(hObject,'Value') returns toggle state of band_togglebutton
on5=get(hObject,'Value');

if on5==0
    %%%hide Kalman buttons
    set(handles.combine5_togglebutton,'Visible', 'off');
    set(handles.combine5_togglebutton,'Value', 0);
    set(handles.noiseQ_text,'Visible', 'off');
    set(handles.Q_edit,'Visible', 'off');
    set(handles.Q_edit,'String', '');
    set(handles.Q_text,'Visible', 'off');
    set(handles.noiseR_text,'Visible', 'off');
    set(handles.R_edit,'Visible', 'off');
    set(handles.R_edit,'String', '');
    set(handles.R_text,'Visible', 'off');
    set(handles.filter5_pushbutton,'Visible', 'off');
    set(handles.save5_pushbutton,'Visible', 'off');
    set(handles.text27,'String', '');
    set(handles.sav5_checkbox,'Visible', 'off');
    
    %%show other options
    set(handles.band_uipanel,'Visible', 'on');%%show Bandpass option
    set(handles.band_togglebutton,'Visible', 'on');
    set(handles.adapt_uipanel,'Visible', 'on');%%show adaptive option
    set(handles.adapt_togglebutton,'Visible', 'on');
    set(handles.smooth_uipanel,'Visible', 'on');%%show smooths option
    set(handles.smooth_togglebutton,'Visible', 'on');
    set(handles.resting_uipanel,'Visible', 'on');%%show Resting-state reference option
    set(handles.resting_togglebutton,'Visible', 'on');
    set(handles.SASS_uipanel,'Visible', 'on');%%show SASS option
    set(handles.sass_togglebutton,'Visible', 'on');
    
    oxy1=oxy;
    deoxy1=deoxy;
    %%%plot
    check=get(handles.oxy_checkbox,'Value');
    check2=get(handles.deoxy_checkbox,'Value');

    cla(h(2));
    axes(h(2))
    ox2=plot(oxy1(:,step),'r');set(ox2,'tag','ox2');
    hold on
    deox2=plot(deoxy1(:,step),'b');set(deox2,'tag','deox2');

    xlim([0 length]);
    set(h(2),'xtick',[])
    title(h(2),string3);
    
    global task_line1, global rest_line1, global task_line2, global rest_line2, global task, global rest
    TaskRest=get(handles.TaskRest_togglebutton,'Value');
    if TaskRest==1
        for i=1:size(task,2)
            task_line2(i)=plot([task(i) task(i)],[-1,1],'Color',[0 0.75 0], 'Linestyle','--');%line([5,5],ylim)    
            rest_line2(i)=plot([rest(i) rest(i)],[-1,1],'Color',[0.25 0.25 0.25]);
        end
    end

    if check==1
        if check2==0
            delete(findobj('tag','deox1'))
            delete(findobj('tag','deox2'))
        end
    
    elseif check== 0
        delete(findobj('tag','ox1'))
        delete(findobj('tag','ox2'))
        if check2==0
            delete(findobj('tag','deox1'))
            delete(findobj('tag','deox2'))
        end

    end
    %%%%%%%%%%%%%
else
    %%%show Kalman buttons
    set(handles.combine5_togglebutton,'Visible', 'on');
    set(handles.noiseQ_text,'Visible', 'on');
    set(handles.Q_edit,'Visible', 'on');
    set(handles.Q_edit,'String', '');
    set(handles.Q_text,'Visible', 'on');
    set(handles.noiseR_text,'Visible', 'on');
    set(handles.R_edit,'Visible', 'on');
    set(handles.R_edit,'String', '');
    set(handles.R_text,'Visible', 'on');
    set(handles.filter5_pushbutton,'Visible', 'on');
    set(handles.save5_pushbutton,'Visible', 'on');
    set(handles.text27,'String', '');
    set(handles.sav5_checkbox,'Visible', 'on');
    set(handles.sav5_checkbox,'Value', 0);
    
    %%hide other options
    set(handles.band_uipanel,'Visible', 'off');%%hide Bandpass option
    set(handles.band_togglebutton,'Visible', 'off');
    set(handles.adapt_uipanel,'Visible', 'off');%%hide adaptive option
    set(handles.adapt_togglebutton,'Visible', 'off');
    set(handles.smooth_uipanel,'Visible', 'off');%%hide smooths option
    set(handles.smooth_togglebutton,'Visible', 'off');
    set(handles.resting_uipanel,'Visible', 'off');%%hide Resting-state reference option
    set(handles.resting_togglebutton,'Visible', 'off');
    set(handles.SASS_uipanel,'Visible', 'off');%%hide SASS option
     set(handles.sass_togglebutton,'Visible', 'off');
end

% --- Executes on button press in filter5_pushbutton.
function filter5_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to filter5_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gaus, global ema
global oxyref, global deoxyref
global ch,global ox1, global deox1, global ox2, global deox2
global signal,global step
global h,global ax, global c, global ax1, global ax2, global ax3, global length
global oxy,global deoxy,global oxy1,global deoxy1,global oxy_filt1,global deoxy_filt1,global oxy_filt3, global deoxy_filt3, global filter3
global string3, global a, global b
global task_line1, global rest_line1, global task_line2, global rest_line2, global task, global rest

c=5;

q=str2num(get(handles.Q_edit,'String'));check_Q=size(q,2);
r=str2num(get(handles.R_edit,'String'));check_R=size(r,2);

CHECK=check_Q*check_R;
if CHECK==0
    set(handles.text27,'String', 'not enough info');
else
    
    combine5=get(handles.combine5_togglebutton,'value');
    if combine5==1
        y1=oxy_filt1;
        y2=deoxy_filt1;
        
    elseif combine5==0
        y1=oxy;
        y2=deoxy;
    end
    
    set(handles.text27,'String', '');
    DIM = ch;
    LEN = length;
    % this is the output:
    S = [];
    SS = [];
    
    % assume measurement matrix H is identical:
    H = eye(DIM);

    % and the state transition matrix T as well:
    T = eye(DIM);
    
    %%%%--------OXY
    % init
    p = H*y1(1,:)';
    P = eye(DIM)*1; % just an initial guess

    Q = eye(DIM)*q;
    R = eye(DIM)*r ;
    
    % loop for the entire dataset:

    for i=2:LEN,

          % estimate step:

          p_est = T*p;
          P_est = T*P*T'+Q; 

          % correction step:

          K = P_est*H'*inv(H*P_est*H'+R);
          p = p_est + K*( y1(i,:)' - H*p_est );
          P = (eye(DIM) - K*H)*P_est;

          S = [S p];

          SS = [SS; P(1,1) P(1,2) P(2,1) P(2,2)];
    end

    oxy1 = S'; oxy1=[y1(1,:) ; oxy1];
    
    %%%%--------DEOXY
    
    % this is the output:
    S = [];
    SS = [];
    
    % init
    p = H*y2(1,:)';
    
    % loop for the entire dataset:

    for i=2:LEN,

          % estimate step:

          p_est = T*p;
          P_est = T*P*T'+Q; 

          % correction step:

          K = P_est*H'*inv(H*P_est*H'+R);
          p = p_est + K*( y2(i,:)' - H*p_est );
          P = (eye(DIM) - K*H)*P_est;

          S = [S p];

          SS = [SS; P(1,1) P(1,2) P(2,1) P(2,2)];
    end

    deoxy1 = S';deoxy1=[y2(1,:) ; deoxy1];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%Plot
    string3='KALMAN FILTER';
    check=get(handles.oxy_checkbox,'Value');
    check2=get(handles.deoxy_checkbox,'Value');

    cla(h(2))
    axes(h(2))
    ox2=plot(oxy1(:,step),'r');set(ox2,'tag','ox2');
    hold on
    deox2=plot(deoxy1(:,step),'b');set(deox2,'tag','deox2');

    xlim([0 length]);
    set(h(2),'xtick',[])
    title(h(2),[string3 ': Channel ' num2str(step)]);
    
    TaskRest=get(handles.TaskRest_togglebutton,'Value');
    if TaskRest==1
        for i=1:size(task,2)
            task_line2(i)=plot([task(i) task(i)],[-1,1],'Color',[0 0.75 0], 'Linestyle','--');%line([5,5],ylim)    
            rest_line2(i)=plot([rest(i) rest(i)],[-1,1],'Color',[0.25 0.25 0.25]);
        end
    end
    
    if check==1
        if check2==0
            delete(findobj('tag','deox1'))
            delete(findobj('tag','deox2'))
        end
    
    elseif check==0
        delete(findobj('tag','ox1'))
        delete(findobj('tag','ox2'))
        if check2==0
            delete(findobj('tag','deox1'))
            delete(findobj('tag','deox2'))
        end

    end

    set(handles.save5_pushbutton,'Visible', 'on')
    set(handles.sav5_checkbox,'Value',0)
    
    %%%%%SAVE DATA
    global filter5
    filter5=[oxy1 deoxy1];
end

% --- Executes on button press in save5_pushbutton.
function save5_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to save5_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filter5, global sav_data5,
a=get(handles.sav5_checkbox,'Value')
if a==0
    sav_data5=[sav_data5 filter5];
    filter5=[];
    set(handles.sav5_checkbox,'Value',1);
end

% --- Executes on button press in sav5_checkbox.
function sav5_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to sav5_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');
% Hint: get(hObject,'Value') returns toggle state of sav1_checkbox
if a==1
    set(hObject,'Value',0)
else
    set(hObject,'Value',1)
end

function R_edit_Callback(hObject, eventdata, handles)
% hObject    handle to R_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of R_edit as text
%        str2double(get(hObject,'String')) returns contents of R_edit as a double


% --- Executes during object creation, after setting all properties.
function R_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to R_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Q_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Q_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Q_edit as text
%        str2double(get(hObject,'String')) returns contents of Q_edit as a double


% --- Executes during object creation, after setting all properties.
function Q_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SASS_pushbutton.
function SASS_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to SASS_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gaus, global ema
global oxyref, global deoxyref
global ch,global ox1, global deox1, global ox2, global deox2
global signal,global step
global h,global ax, global c, global ax1, global ax2, global ax3, global length
global oxy,global deoxy,global oxy1,global deoxy1,global oxy_filt1,global deoxy_filt1,global oxy_filt3, global deoxy_filt3, global filter3
global string3,
global task_line1, global rest_line1, global task_line2, global rest_line2, global task, global rest



combine6=get(handles.combine6_togglebutton,'value');
if combine6==1
    y1=oxy_filt1;
    y2=deoxy_filt1;
        
elseif combine6==0
    y1=oxy;
    y2=deoxy;
end

N = length;
n = 0:N-1;

sigma = 0.1;                    % sigma : noise standard deviation


% data = noisyData(:,1);             % data : noisy NIRS
for i=1:ch
   %%
    data = y1(:,i);

%%%
    r = 2;
    M = 15;
    y = preproc(r, M, data);
%%%

    d = 2;                          % filter is of order 2d
    fc = 0.03;                      % fc : cut-off frequency (0 < fc < 0.5) (cycles/sample)
    K = 3;                          % K : order of sparse derivative

%%%

% Banded filter matrices:
    [A, B, B1, D, a, b, b1, H1norm HTH1norm] = ABfilt(d, fc, N, K);

    H = @(x) [nan(d,1); A\(B*x); nan(d,1)];     % H: high-pass filter
    L = @(x) x - H(x);                          % L: low-pass filter

%%%

    %%% Low-pass filter

    x_lpf = L(y);

%%%
    beta = 3;
    lam = beta * sigma * HTH1norm;  % lam : regularization parameter

    Nit = 100;                      % Nit : number of iterations

    [x_L1, cost_L1, u_L1, v_L1] = sass(y, d, fc, K, lam, 'L1', [], Nit);
%%%

    rho = 0.5;

    [x_atan1, cost_atan1, u_atan1, v_atan1, a] = sass(y, d, fc, K, lam, 'atan', rho, Nit, u_L1);
    
    [x_atan, cost_atan, u_atan, v_atan, a] = sass2(y, d, fc, K, lam, 'atan', rho, Nit, u_L1);


    oxy1(:,i)=x_atan;
    
    
    
    %%
    data = y2(:,i);

%%%
    r = 2;
    M = 15;
    y = preproc(r, M, data);
%%%

    d = 2;                          % filter is of order 2d
    fc = 0.03;                      % fc : cut-off frequency (0 < fc < 0.5) (cycles/sample)
    K = 3;                          % K : order of sparse derivative

%%%

% Banded filter matrices:
    [A, B, B1, D, a, b, b1, H1norm HTH1norm] = ABfilt(d, fc, N, K);

    H = @(x) [nan(d,1); A\(B*x); nan(d,1)];     % H: high-pass filter
    L = @(x) x - H(x);                          % L: low-pass filter

%%%

    %%% Low-pass filter

    x_lpf = L(y);

%%%
    beta = 3;
    lam = beta * sigma * HTH1norm;  % lam : regularization parameter

    Nit = 100;                      % Nit : number of iterations

    [x_L1, cost_L1, u_L1, v_L1] = sass(y, d, fc, K, lam, 'L1', [], Nit);
%%%

    rho = 0.5;

    [x_atan1, cost_atan1, u_atan1, v_atan1, a] = sass(y, d, fc, K, lam, 'atan', rho, Nit, u_L1);
    
    [x_atan, cost_atan, u_atan, v_atan, a] = sass2(y, d, fc, K, lam, 'atan', rho, Nit, u_L1);


    deoxy1(:,i)=x_atan;
end

size(oxy1)

set(handles.filter6_pushbutton,'Visible', 'on');
set(handles.save6_pushbutton,'Visible', 'on');
set(handles.sav6_checkbox,'Visible', 'on');


% --- Executes on button press in filter6_pushbutton.
function filter6_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to filter6_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global oxyref, global deoxyref
global ch,global ox1, global deox1, global ox2, global deox2
global signal,global step
global h,global ax, global c, global ax1, global ax2, global ax3, global length
global oxy,global deoxy,global oxy1,global deoxy1,global oxy_filt1,global deoxy_filt1,global oxy_filt3, global deoxy_filt3, global filter3
global string3, global a, global b
global wsize, global alpha
global task_line1, global rest_line1, global task_line2, global rest_line2, global task, global rest

c=6; string3='SASS';

%%%%%%%%%%%%%%%%%%%%%%%%%Plot
    check=get(handles.oxy_checkbox,'Value');
    check2=get(handles.deoxy_checkbox,'Value');

    cla(h(2))
    axes(h(2))
    ox2=plot(oxy1(:,step),'r');set(ox2,'tag','ox2');
    hold on
    deox2=plot(deoxy1(:,step),'b');set(deox2,'tag','deox2');

    xlim([0 length]);
    set(h(2),'xtick',[])
    title(h(2),[string3 ': Channel ' num2str(step)]);
    
    TaskRest=get(handles.TaskRest_togglebutton,'Value');
    if TaskRest==1
        for i=1:size(task,2)
            task_line2(i)=plot([task(i) task(i)],[-1,1],'Color',[0 0.75 0], 'Linestyle','--');%line([5,5],ylim)    
            rest_line2(i)=plot([rest(i) rest(i)],[-1,1],'Color',[0.25 0.25 0.25]);
        end
    end
    
    if check==1
        if check2==0
            delete(findobj('tag','deox1'))
            delete(findobj('tag','deox2'))
        end
    
    elseif check==0
        delete(findobj('tag','ox1'))
        delete(findobj('tag','ox2'))
        if check2==0
            delete(findobj('tag','deox1'))
            delete(findobj('tag','deox2'))
        end

    end

    set(handles.save6_pushbutton,'Visible', 'on')
    set(handles.sav6_checkbox,'Value',0)
    
    %%%%%SAVE DATA
    global filter6
    filter6=[oxy1 deoxy1];size(filter6) 
    global sav_data6
    size(sav_data6)
    


% --- Executes on button press in save6_pushbutton.
function save6_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to save6_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filter6, global sav_data6,
a=get(handles.sav6_checkbox,'Value')
if a==0
    assignin('base', 'sav_data6', sav_data6);assignin('base', 'filter6', filter6);
    sav_data6=[sav_data6 filter6];
    filter6=[];
    set(handles.sav6_checkbox,'Value',1);
    sav=size(sav_data6)
end

% --- Executes on button press in sav6_checkbox.
function sav6_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to sav6_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');
% Hint: get(hObject,'Value') returns toggle state of sav1_checkbox
if a==1
    set(hObject,'Value',0)
else
    set(hObject,'Value',1)
end

% --- Executes on button press in sass_togglebutton.
function sass_togglebutton_Callback(hObject, eventdata, handles)
% hObject    handle to sass_togglebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global cut1,global cut2,global Fcutoff,global passband,global stopband
global ch,global ox1, global deox1, global ox2, global deox2
global signal,global step
global h,global ax, global c, global ax1, global ax2, global ax3, global length
global oxy,global deoxy,global oxy1,global deoxy1,global oxy_filt1,global deoxy_filt1
global string3, global a, global b
string3='not filtered yet';
set(handles.process_uipanel,'Visible', 'off')
% Hint: get(hObject,'Value') returns toggle state of sass_togglebutton
on1=get(hObject,'Value');
if on1==0
    %%%hide SASS buttons
    set(handles.combine6_togglebutton,'Visible', 'off');
    set(handles.combine6_togglebutton,'Value', 0);
    set(handles.SASS_pushbutton,'Visible', 'off');
    set(handles.filter6_pushbutton,'Visible', 'off');
    set(handles.save6_pushbutton,'Visible', 'off');
    set(handles.sav6_checkbox,'Visible', 'off');
    set(handles.sav6_checkbox,'Value',0);
    
    
    %%show other options
    set(handles.band_uipanel,'Visible', 'on');%%show bandpass option
    set(handles.band_togglebutton,'Visible', 'on');
    set(handles.adapt_uipanel,'Visible', 'on');%%show adaptive option
    set(handles.adapt_togglebutton,'Visible', 'on');
    set(handles.smooth_uipanel,'Visible', 'on');%%show smooths option
    set(handles.smooth_togglebutton,'Visible', 'on');
    set(handles.resting_uipanel,'Visible', 'on');%%show Resting-state reference option
    set(handles.resting_togglebutton,'Visible', 'on'); 
    set(handles.Kalman_uipanel,'Visible', 'on');%%show Kalman option
    set(handles.kalman_togglebutton,'Visible', 'on');
    
    %%%reset
    c=0;
    oxy1=oxy;
    deoxy1=deoxy;
    
    %%%plot
    check=get(handles.oxy_checkbox,'Value');
    check2=get(handles.deoxy_checkbox,'Value');
    
    cla(h(2));
    axes(h(2));
    oxy1=oxy; deoxy1=deoxy;
    ox2=plot(oxy(:,step),'r');set(ox2,'tag','ox2');
    hold on
    deox2=plot(deoxy(:,step),'b');set(deox2,'tag','deox2');

    xlim([0 length]);
    set(h(2),'xtick',[])
    title(h(2),string3);
    
    global task_line1, global rest_line1, global task_line2, global rest_line2, global task, global rest
    TaskRest=get(handles.TaskRest_togglebutton,'Value');
    if TaskRest==1
        for i=1:size(task,2)
            task_line2(i)=plot([task(i) task(i)],[-1,1],'Color',[0 0.75 0], 'Linestyle','--');%line([5,5],ylim)    
            rest_line2(i)=plot([rest(i) rest(i)],[-1,1],'Color',[0.25 0.25 0.25]);
        end
    end

    if check==1
        if check2==0
            delete(findobj('tag','deox1'))
            delete(findobj('tag','deox2'))
        end
    
    elseif check== 0
        delete(findobj('tag','ox1'))
        delete(findobj('tag','ox2'))
        if check2==0
            delete(findobj('tag','deox1'))
            delete(findobj('tag','deox2'))
        end

    end
else
    %%show other options
    set(handles.band_uipanel,'Visible', 'off');%%show bandpass option
    set(handles.band_togglebutton,'Visible', 'off');
    set(handles.adapt_uipanel,'Visible', 'off');%%show adaptive option
    set(handles.adapt_togglebutton,'Visible', 'off');
    set(handles.smooth_uipanel,'Visible', 'off');%%show smooths option
    set(handles.smooth_togglebutton,'Visible', 'off');
    set(handles.resting_uipanel,'Visible', 'off');%%show Resting-state reference option
    set(handles.resting_togglebutton,'Visible', 'off'); 
    set(handles.Kalman_uipanel,'Visible', 'off');%%show Kalman option
    set(handles.kalman_togglebutton,'Visible', 'off');
    
    %%%%
    set(handles.combine6_togglebutton,'Visible', 'on');
    set(handles.SASS_pushbutton,'Visible', 'on');
end


% --- Executes on button press in combine3_togglebutton.
function combine3_togglebutton_Callback(hObject, eventdata, handles)
% hObject    handle to combine3_togglebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

combine3=get(hObject,'Value')
%%%reset lowpass
set(handles.type_popupmenu,'Value', 1);
set(handles.method_popupmenu,'Value', 1);
set(handles.sav1_checkbox,'Value',0);
set(handles.order_edit,'String','');
set(handles.cutoff1_edit,'String','');
set(handles.cutoff2_edit,'String','');
set(handles.passband_edit,'String','');
set(handles.passband_edit,'String','');
    
if combine3==1
    set(handles.band_uipanel,'Visible', 'on');
    set(handles.type_popupmenu,'Visible', 'on');

else
    set(handles.band_uipanel,'Visible', 'off');
    set(handles.type_popupmenu,'Visible', 'off');
    
    %%% hide Bandpass buttons
    set(handles.type_popupmenu,'Visible', 'off');
    set(handles.order_text,'Visible', 'off');
    set(handles.order_edit,'Visible', 'off');
    set(handles.cutoff1_edit,'Visible', 'off');
    set(handles.cut1_text,'Visible', 'off');
    set(handles.cutoff2_edit,'Visible', 'off');
    set(handles.cut2_text,'Visible', 'off');
    set(handles.method_popupmenu,'Visible', 'off');
    set(handles.passband_edit,'Visible', 'off');
    set(handles.passband_text,'Visible', 'off');
    set(handles.stopband_edit,'Visible', 'off');
    set(handles.stopband_text,'Visible', 'off');
    set(handles.filter1_pushbutton,'Visible', 'off');
    set(handles.save1_pushbutton,'Visible', 'off');
    set(handles.sav1_checkbox,'Visible', 'off');

    
end
    
    
    
    


% --- Executes on button press in combine4_togglebutton.
function combine4_togglebutton_Callback(hObject, eventdata, handles)
% hObject    handle to combine4_togglebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of combine4_togglebutton

combine4=get(hObject,'Value');
%%%reset lowpass
set(handles.type_popupmenu,'Value', 1);
set(handles.method_popupmenu,'Value', 1);
set(handles.sav1_checkbox,'Value',0);
set(handles.order_edit,'String','');
set(handles.cutoff1_edit,'String','');
set(handles.cutoff2_edit,'String','');
set(handles.passband_edit,'String','');
set(handles.passband_edit,'String','');
    
if combine4==1
    set(handles.band_uipanel,'Visible', 'on');
    set(handles.type_popupmenu,'Visible', 'on');

else
    set(handles.band_uipanel,'Visible', 'off');
    set(handles.type_popupmenu,'Visible', 'off');
    
    %%% hide Bandpass buttons
    set(handles.type_popupmenu,'Visible', 'off');
    set(handles.order_text,'Visible', 'off');
    set(handles.order_edit,'Visible', 'off');
    set(handles.cutoff1_edit,'Visible', 'off');
    set(handles.cut1_text,'Visible', 'off');
    set(handles.cutoff2_edit,'Visible', 'off');
    set(handles.cut2_text,'Visible', 'off');
    set(handles.method_popupmenu,'Visible', 'off');
    set(handles.passband_edit,'Visible', 'off');
    set(handles.passband_text,'Visible', 'off');
    set(handles.stopband_edit,'Visible', 'off');
    set(handles.stopband_text,'Visible', 'off');
    set(handles.filter1_pushbutton,'Visible', 'off');
    set(handles.save1_pushbutton,'Visible', 'off');
    set(handles.sav1_checkbox,'Visible', 'off');

    
end


% --- Executes on button press in combine6_togglebutton.
function combine6_togglebutton_Callback(hObject, eventdata, handles)
% hObject    handle to combine6_togglebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of combine6_togglebutton
combine6=get(hObject,'Value')
%%%reset lowpass
set(handles.type_popupmenu,'Value', 1);
set(handles.method_popupmenu,'Value', 1);
set(handles.sav1_checkbox,'Value',0);
set(handles.order_edit,'String','');
set(handles.cutoff1_edit,'String','');
set(handles.cutoff2_edit,'String','');
set(handles.passband_edit,'String','');
set(handles.passband_edit,'String','');
    
if combine6==1
    set(handles.band_uipanel,'Visible', 'on');
    set(handles.type_popupmenu,'Visible', 'on');

else
    set(handles.band_uipanel,'Visible', 'off');
    set(handles.type_popupmenu,'Visible', 'off');
    
    %%% hide Bandpass buttons
    set(handles.type_popupmenu,'Visible', 'off');
    set(handles.order_text,'Visible', 'off');
    set(handles.order_edit,'Visible', 'off');
    set(handles.cutoff1_edit,'Visible', 'off');
    set(handles.cut1_text,'Visible', 'off');
    set(handles.cutoff2_edit,'Visible', 'off');
    set(handles.cut2_text,'Visible', 'off');
    set(handles.method_popupmenu,'Visible', 'off');
    set(handles.passband_edit,'Visible', 'off');
    set(handles.passband_text,'Visible', 'off');
    set(handles.stopband_edit,'Visible', 'off');
    set(handles.stopband_text,'Visible', 'off');
    set(handles.filter1_pushbutton,'Visible', 'off');
    set(handles.save1_pushbutton,'Visible', 'off');
    set(handles.sav1_checkbox,'Visible', 'off');

    
end

% --- Executes on button press in combine5_togglebutton.
function combine5_togglebutton_Callback(hObject, eventdata, handles)
% hObject    handle to combine5_togglebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of combine5_togglebutton
combine5=get(hObject,'Value')
%%%reset lowpass
set(handles.type_popupmenu,'Value', 1);
set(handles.method_popupmenu,'Value', 1);
set(handles.sav1_checkbox,'Value',0);
set(handles.order_edit,'String','');
set(handles.cutoff1_edit,'String','');
set(handles.cutoff2_edit,'String','');
set(handles.passband_edit,'String','');
set(handles.passband_edit,'String','');
    
if combine5==1
    set(handles.band_uipanel,'Visible', 'on');
    set(handles.type_popupmenu,'Visible', 'on');

else
    set(handles.band_uipanel,'Visible', 'off');
    set(handles.type_popupmenu,'Visible', 'off');
    
    %%% hide Bandpass buttons
    set(handles.type_popupmenu,'Visible', 'off');
    set(handles.order_text,'Visible', 'off');
    set(handles.order_edit,'Visible', 'off');
    set(handles.cutoff1_edit,'Visible', 'off');
    set(handles.cut1_text,'Visible', 'off');
    set(handles.cutoff2_edit,'Visible', 'off');
    set(handles.cut2_text,'Visible', 'off');
    set(handles.method_popupmenu,'Visible', 'off');
    set(handles.passband_edit,'Visible', 'off');
    set(handles.passband_text,'Visible', 'off');
    set(handles.stopband_edit,'Visible', 'off');
    set(handles.stopband_text,'Visible', 'off');
    set(handles.filter1_pushbutton,'Visible', 'off');
    set(handles.save1_pushbutton,'Visible', 'off');
    set(handles.sav1_checkbox,'Visible', 'off');

    
end
