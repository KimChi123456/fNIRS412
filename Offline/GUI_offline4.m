function varargout = GUI_offline4(varargin)
% GUI_OFFLINE4 MATLAB code for GUI_offline4.fig
%      GUI_OFFLINE4, by itself, creates a new GUI_OFFLINE4 or raises the existing
%      singleton*.
%
%      H = GUI_OFFLINE4 returns the handle to a new GUI_OFFLINE4 or the handle to
%      the existing singleton*.
%
%      GUI_OFFLINE4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_OFFLINE4.M with the given input arguments.
%
%      GUI_OFFLINE4('Property','Value',...) creates a new GUI_OFFLINE4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_offline4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_offline4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_offline4

% Last Modified by GUIDE v2.5 17-Feb-2014 22:27:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_offline4_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_offline4_OutputFcn, ...
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


% --- Executes just before GUI_offline4 is made visible.
function GUI_offline4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_offline4 (see VARARGIN)
global filename
clc
cla(handles.axes1);cla(handles.axes2);cla(handles.axes3);
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
set(handles.filter_uipanel,'Visible', 'off')

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


% Choose default command line output for GUI_offline4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_offline4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_offline4_OutputFcn(hObject, eventdata, handles) 
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
global sav_data1, global sav_data2,global sav_data3,
global raw,global filename, global ch, global T
global save_check
sav_data=[];
if save_check==0;
    sav_data=[raw sav_data1 sav_data2 sav_data3];
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
set(handles.text15,'String', '');
% Hint: get(hObject,'Value') returns toggle state of band_togglebutton
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
     
    
    %%%plot
    check=get(handles.oxy_checkbox,'Value');
    check2=get(handles.deoxy_checkbox,'Value');


    cla(h(2));
    axes(h(2));
    ox2=plot(oxy(:,step),'r');set(ox2,'tag','ox2');
    hold on
    deox2=plot(deoxy(:,step),'b');set(deox2,'tag','deox2');

    xlim([0 length]);
    set(h(2),'xtick',[])
    title(h(2),string3);

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
     
      %%%reset
    set(handles.type_popupmenu,'Value', 1);
    set(handles.method_popupmenu,'Value', 1);
    set(handles.sav1_checkbox,'Value',0);
    set(handles.order_edit,'String','');
    set(handles.cutoff1_edit,'String','');
    set(handles.cutoff2_edit,'String','');
    set(handles.passband_edit,'String','');
    set(handles.passband_edit,'String','');
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
global h,global ax, global c,global c1, global ax1, global ax2, global ax3, global length
global oxy,global deoxy,global oxy1,global deoxy1,global oxy_filt1,global deoxy_filt1
global string3, global a, global b
string3='not filtered yet';
% Hint: get(hObject,'Value') returns toggle state of adapt_togglebutton
on1=get(hObject,'Value');

count=0;
if on1==0
    c1=0;
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
     
   %%%reset
   set(handles.adapt_popupmenu,'Value', 1);
   set(handles.ref_edit,'String','0');
   set(handles.sav2_checkbox,'Value',0);
   c=0;
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
set(handles.text16,'String', '');
% Hint: get(hObject,'Value') returns toggle state of smooth_togglebutton
if on3==0
    cla(h(3))
    set(h(3),'Visible', 'off');
    %%% hide SMOOTHS buttons
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
     
    %%%reset
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
    set(handles.gaussian_togglebutton,'Visible', 'on');
    set(handles.ema_togglebutton,'Visible', 'on');
    set(handles.sav3_checkbox,'Visible', 'on');
    
    %%hide other options
    set(handles.adapt_uipanel,'Visible', 'off');%%hide adaptive option
    set(handles.adapt_togglebutton,'Visible', 'off');
    set(handles.band_uipanel,'Visible', 'off');%%hide bandpass option
    set(handles.band_togglebutton,'Visible', 'off');
    
end

% --- Executes on button press in deoxy_checkbox.
function deoxy_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to deoxy_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global h,global ax, global c,global c1, global ax1, global ax2, global ax3, global length
global step, global adapt_step
global oxy,global deoxy,global oxy1,global deoxy1
global string3
% Hint: get(hObject,'Value') returns toggle state of oxy_checkbox
check=get(hObject,'Value');
check2=get(handles.oxy_checkbox,'Value');
cla(h(1)); cla(h(2)); cla(h(3))

axes(h(1))
ox1=plot(oxy(:,step),'r');set(ox1,'tag','ox1');
hold on
deox1=plot(deoxy(:,step),'b');set(deox1,'tag','deox1');
xlim([0 length]);
set(h(1),'xtick',[])
m=title(h(1),'raw data');

axes(h(2)); 
ox2=plot(oxy1(:,step),'r');set(ox2,'tag','ox2');
hold on
deox2=plot(deoxy1(:,step),'b');set(deox2,'tag','deox2');

xlim([0 length]);
set(h(2),'xtick',[])
m1=title(h(2),string3);

if c1==1
    axes(h(3))
    ox3=plot(oxy(:,adapt_step),'r');set(ox3,'tag','ox3');
    hold on
    deox3=plot(deoxy(:,adapt_step),'b');set(deox3,'tag','deox3') 
    xlim([0 length]);
    set(h(3),'xtick',[])
    m=xlabel(['Reference: Channel ' num2str(adapt_step)]);
    set(m, 'FontSize', 7);
end

if check==1
    if check2==0
        delete(findobj('tag','ox1'))
        delete(findobj('tag','ox2'))
        if (adapt_step~=0)
            delete(findobj('tag','ox3'))
        end
    end
    
elseif check== 0
    delete(findobj('tag','deox1'))
    delete(findobj('tag','deox2'))
    delete(findobj('tag','deox3'))
    if check2==0
        delete(findobj('tag','ox1'))
        delete(findobj('tag','ox2'))
        if c1==1
            delete(findobj('tag','ox3'))
        end
    end

end


% --- Executes on button press in oxy_checkbox.
function oxy_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to oxy_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global h,global ax, global c, global ax1, global ax2, global ax3, global length
global step, global adapt_step
global oxy,global deoxy,global oxy1,global deoxy1
global string3

% Hint: get(hObject,'Value') returns toggle state of oxy_checkbox
check=get(hObject,'Value');
check2=get(handles.deoxy_checkbox,'Value');
cla(h(1)); cla(h(2)); cla(h(3));

axes(h(1))
ox1=plot(oxy(:,step),'r');set(ox1,'tag','ox1');
hold on
deox1=plot(deoxy(:,step),'b');set(deox1,'tag','deox1');
xlim([0 length]);
set(h(1),'xtick',[])
m=title(h(1),'raw data');

axes(h(2))
ox2=plot(oxy1(:,step),'r');set(ox2,'tag','ox2');
hold on
deox2=plot(deoxy1(:,step),'b');set(deox2,'tag','deox2');

xlim([0 length]);
set(h(2),'xtick',[])
m1=title(h(2),string3);


if (adapt_step>0)
    axes(h(3));
    ox3=plot(oxy(:,adapt_step),'r');set(ox3,'tag','ox3');
    hold on
    deox3=plot(deoxy(:,adapt_step),'b');set(deox3,'tag','deox3') 
    xlim([0 length]);
    set(h(3),'xtick',[])
    m=xlabel(['Reference: Channel ' num2str(adapt_step)]);
    set(m, 'FontSize', 7);
end

if check==1
    if check2==0
        delete(findobj('tag','deox1'))
        delete(findobj('tag','deox2'))
        if (adapt_step~=0)
            delete(findobj('tag','deox3'))
        end
    end
    
elseif check== 0
    delete(findobj('tag','ox1'))
    delete(findobj('tag','ox2'))
    delete(findobj('tag','ox3'))
    if check2==0
        delete(findobj('tag','deox1'))
        delete(findobj('tag','deox2'))
        if (adapt_step~=0)
            delete(findobj('tag','deox3'))
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

%%%Set oxy& deoxy
set(handles.oxy_checkbox,'Value',1);
set(handles.deoxy_checkbox,'Value',1);

%LOAD
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
global short_step, global raw,global sav_data1,global sav_data2,global sav_data3,
global check_plot, global process

process=1;
%%CLEAR data
sav_data1=[];sav_data2=[];sav_data3=[];
oxy=[]; deoxy=[];oxyref=[];deoxyref=[];
c=0; 
short_step=0;
string3='not filtered yet';
%%%%
[filename pathname]=uigetfile({'*.txt'},'File Selector');
fullpathname=strcat(pathname,filename);
data=load(fullpathname);
filename=strsplit(filename,'.txt');
filename=filename(1,1);
set(handles.edit1,'String',filename);

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
raw=[oxy deoxy];
%%%

%%%%%Plot
h(1)=handles.axes1;
h(2)=handles.axes2;
h(3)=handles.axes3;
for i=1:3
    cla(h(i))
end
%%%Raw signal

axes(h(1));
plot(oxy(:,step),'r');
hold on
plot(deoxy(:,step),'b');
xlim([0 length]);
set(h(1),'xtick',[])
title(h(1),['raw data: Channel ' num2str(step)]);

%%%Filtered data

axes(h(2));
plot(oxy(:,step),'r');
hold on
plot(deoxy(:,step),'b');
xlim([0 length]);
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

%%%Set oxy& deoxy
set(handles.oxy_checkbox,'Value',1);
set(handles.deoxy_checkbox,'Value',1);

%LOAD
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
global short_step, global raw,global sav_data1,global sav_data2,global sav_data3,
global check_plot, global process
global filter

process=0;
%%CLEAR data and plot
sav_data1=[];sav_data2=[];sav_data3=[];
oxy=[]; deoxy=[];oxyref=[];deoxyref=[];
c=0; 
short_step=0;
string3='not filtered yet';
%Clear plot
%%%%%Plot
h(1)=handles.axes1;
h(2)=handles.axes2;
h(3)=handles.axes3;
for i=1:3
    cla(h(i))
end

%%%Show process pannel
set(handles.process_uipanel,'Visible', 'on')
set(handles.filtered_uipanel,'Visible', 'off')%%Hide

%%%Hide 
set(handles.filter_uipanel,'Visible', 'off')
set(handles.axes2,'Visible', 'off')
set(handles.axes3,'Visible', 'off')

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
[filename pathname]=uigetfile({'*.mat'},'File Selector');
fullpathname=strcat(pathname,filename);
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
    data= struct2cell(data);
    data= cell2mat(data);
    size(data);
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
    set(handles.filter_uipanel,'Visible', 'off')
    
    set(handles. browse_pushbutton,'Visible','off');%hide browse button
    
    %%%%seperate data
    length=size(data,1);
    width_data=size(data,2);
    slit=ch*2;
    slit_array=zeros(1, width_data/slit);
    slit_array=slit_array+slit;
    data=mat2cell(data,length,slit_array);% data is a cell
    raw_data=data{1,1}; % raw_data is an array
    filter=data(:,2:end);
    
    %%%Plot raw data
    type_sig=mat2cell(raw_data,length, [ch ch]);
    oxy=type_sig{1}; deoxy=type_sig{2};

    set(h(1),'Visible', 'on')
    axes(h(1))  
    plot(oxy(:,step),'r');
    hold on
    plot(deoxy(:,step),'b');

    xlim([0 length]);
    set(h(1),'xtick',[])
    title(h(1),['raw data: channel ' num2str(step)]);
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
c=3;
wsize=str2num(get(handles.win_edit,'String'));
CHECK=size(wsize,2);
if CHECK==0
    set(handles.text16,'String', 'not enough information');
else
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
            oxy_filt=conv(oxy(:,i), gaussFilter);
            deoxy_filt=conv(deoxy(:,i), gaussFilter);
            oxy_gau=[oxy_gau oxy_filt];
            deoxy_gau=[deoxy_gau deoxy_filt];
        end
        oxy_filt3=oxy_gau(wsize:end,:);
        deoxy_filt3=deoxy_gau(wsize:end,:);
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%EMA smooth
    if ema==1
        string3='EMA SMOOTH';
        oxy_filt3 = tsmovavg(oxy,'e',wsize,1);
        deoxy_filt3 = tsmovavg(deoxy,'e',wsize,1);
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
    title(h(2),string3);

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
    set(handles.text14,'String','');
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
% Hint: get(hObject,'Value') returns toggle state of ema_togglebutton
if EMA==1
    ema=1;
    set(handles.win_edit,'Visible', 'on')
    set(handles.wsize_text,'Visible', 'on')
    set(handles.alpha_edit,'Visible', 'off')
    set(handles.alpha_text,'Visible', 'off')
    set(handles.filter3_pushbutton,'Visible', 'on')
    set(handles.text14,'String','EMA SMOOTH');
    set(handles.text14,'String','');
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
c=2;string3='ADAPTIVE filter';
oxy_filt2=[]; deoxy_filt2=[];

%%%rename data to manage
if glob==1
    oxyref=oxyref1;
    deoxyref=deoxyref1;
end

y1=oxy_filt1; x1=oxyref; x1=x1/std(x1)*std(y1);
y2=deoxy_filt1; x2=deoxyref; x2=x2/std(x2)*std(y2);

%%%Adaptive algorithm
k=20;
w_ox=zeros(1,k);w_ox(1)=1;e_ox=zeros(length,1);
w_deox=zeros(1,k);w_deox(1)=1;e_deox=zeros(length,1);
mu=0.01;

for i=1:ch
    for t=k+1:length
        e_ox(t)=y1(t)-w_ox*x1(t-k+1:t,i);
        w_ox=w_ox+2*mu*e_ox(t-1)*x1(t-k+1:t,i)';
    
        e_deox(t)=y2(t)-w_deox*x2(t-k+1:t,i);
        w_deox=w_deox+2*mu*e_deox(t-1)*x2(t-k+1:t,i)';
    end
    oxy_filt2(:,i)=e_ox; 
    deoxy_filt2(:,i)=e_deox;
end

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
title(h(2),string3);

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
global h,global ax, global c,global c1, global ax1, global ax2, global ax3, global length
global step
global oxy,global deoxy
set(handles.adapt_select_pushbutton,'Visible', 'on')
set(h(3),'Visible', 'on');
adapt_step=str2num(get(handles.ref_edit,'String'));
c1=1;
adapt_step=adapt_step+1;
if adapt_step>ch
    adapt_step=1;
end

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
global h,global ax, global c, global c1, global ax1, global ax2, global ax3, global length
global step
global oxy,global deoxy
set(handles.adapt_select_pushbutton,'Visible', 'on')
set(h(3),'Visible', 'on');
adapt_step=str2num(get(handles.ref_edit,'String'));
c1=1;
adapt_step=adapt_step-1;
if adapt_step<1
    adapt_step=ch;
end

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
    sav_data2=[sav_data2 filter2];
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

function order_edit_Callback(hObject, eventdata, handles)
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

cla(h(3));
val=get(handles.method_popupmenu,'value');
val1=get(handles.type_popupmenu,'value');

N=str2num(get(handles.order_edit,'String'));check_1=size(N,2);
cut1=str2num(get(handles.cutoff1_edit,'String'));check_2=size(cut1,2);
cut2=str2num(get(handles.cutoff2_edit,'String'));check_3=size(cut2,2);
passband=str2num(get(handles.passband_edit,'String'));check_4=size(passband,2);
stopband=str2num(get(handles.stopband_edit,'String'));check_5=size(stopband,2);


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
            r=0.5;
            set(handles.passband_edit,'String', num2str(r));
        else
            r=passband;
        end
        [b,a] = cheby1(N,r,Wn,ftype);
        
    elseif val==4
        if check_4==0
            r=20;
            set(handles.passband_edit,'String', num2str(r));
        else
            r=passband;
            [b,a] = cheby2(N,r,Wn,ftype);
        end
    elseif val==5
        if check_4==0
            rp=0.5;
            set(handles.passband_edit,'String', num2str(rp));
        else
            rp=passband;
        end
        
        if check_5==0
            rs=20;
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
    title(h(2),string3);

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

    adapt=get(handles.adapt_togglebutton,'Value');
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
function method_popupmenu_CreateFcn(hObject, eventdata, handles)
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
global h,global ax, global c, global ax1, global ax2, global ax3, global length
global step, global step2
global oxy,global deoxy,global oxy1,global deoxy1,global oxy_filt1,global deoxy_filt1
global string3, global a, global b, global process, global filt_num

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
    title(h(2),string3);

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

% --- Executes on button press in right_pushbutton.
function right_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to right_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ch, 
global ox1, global deox1, global ox2, global deox2
global signal
global h,global ax, global c, global ax1, global ax2, global ax3, global length
global step, global step2
global oxy,global deoxy,global oxy1,global deoxy1,global oxy_filt1,global deoxy_filt1
global string3, global a, global b, global process, global filt_num

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
    title(h(2),string3);

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

process=1; c=-1;
num_filt=size(filter,2);

set(handles.filter_edit,'Visible', 'on')
set(handles.filter_edit,'String','1')
step2=str2num(get(handles.filter_edit,'String'));
plot_filt=filter{step2};
filt_sig=mat2cell(plot_filt,size(plot_filt,1),[ch ch]);
oxy1=filt_sig{1}; deoxy1=filt_sig{2};
%%Plot 
cla(h(2));set(h(2),'visible','on')
axes(h(2))
plot(oxy1(:,step),'r');
hold on
plot(deoxy1(:,step),'b');

xlim([0 length]);
set(h(2),'xtick',[])
string3=['filter ' num2str(step2) ': channel ' num2str(step)];
title(h(2),string3);

set(handles.filtered_uipanel,'Visible', 'on')