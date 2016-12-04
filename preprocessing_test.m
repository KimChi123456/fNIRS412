clear all
close all
clc
currentFolder=pwd;
%load data

% [filen, pathn] = uigetfile('*.txt','Select the Voltage txt file');
% path_file_n = [pathn filen];
% if filen(1) == 0 | pathn(1) == 0
%     return;
% end
% fid = fopen(path_file_n);
% disp('Loading data...');
% tline=fscanf(fid,'%c',Inf);
% data=str2num(tline);

load('TrangK13_short_001.TXT');
data=TrangK13_short_001;
filename='TrangK13_short_001_pp.mat';
% classify data
t=data(:,1);
stim=data(:,2);
fs=1/data(2,1);
data(:,[1:4])=[];
HbO=data(:,[1:3:21]);
lengthData=length(HbO);

%choose channel
oxy=HbO(:,1);
%stim vector
stim(find(stim==2))=0;
for i=1:length(stim)
    if i==length(stim)
        break;
    end
    if (stim(i+1)==1)&(stim(i)==0)
        stim(i+1)=2;
    end
    if (stim(i+1)==0)&(stim(i)==1)
        stim(i)=-1;
    end
end
stim(find(stim==1))=0;
stim(find(stim==2))=1;

% preprocess - bandpass filter
% Functional Near Infrared Spectroscopy (NIRS) signal improvement 
% based on negative correlation between oxygenated and deoxygenated hemoglobin dynamics
N=3;
x=HbO;
Wn1=0.01;
Wn2=0.5;
[b,a]=butter(N,2*0.055*[Wn1 Wn2],'bandpass');
y2=filter(b,a,x);

%moving average
a = 1;
b(1:ceil(fs*5))=1/(fs*5);
for i=1:7
    y3(:,i)=filtfilt(b,a,y2(:,i));
end


%smoothing
span = 155;
ch_num = 7;
for ch = 1:ch_num
    y4(:,ch) = smooth(y3(:,ch),span);
end

HbO1=y4;
save(filename,'HbO1');
%% short 002

load('TrangK13_short_002.TXT');
data=TrangK13_short_002;
filename='TrangK13_short_002_pp.mat';
% classify data
t=data(:,1);
stim=data(:,2);
fs=1/data(2,1);
data(:,[1:4])=[];
HbO=data(:,[1:3:21]);
lengthData=length(HbO);

%choose channel
oxy=HbO(:,1);
%stim vector
stim(find(stim==2))=0;
for i=1:length(stim)
    if i==length(stim)
        break;
    end
    if (stim(i+1)==1)&(stim(i)==0)
        stim(i+1)=2;
    end
    if (stim(i+1)==0)&(stim(i)==1)
        stim(i)=-1;
    end
end
stim(find(stim==1))=0;
stim(find(stim==2))=1;

% preprocess - bandpass filter
N=3;
x=HbO;
Wn1=0.01;
Wn2=0.5;
[b,a]=butter(N,2*0.055*[Wn1 Wn2],'bandpass');
y2=filter(b,a,x);

%moving average
y3=[];
a = 1;
b(1:ceil(fs*5))=1/(fs*5);
for i=1:7
    y3(:,i)=filtfilt(b,a,y2(:,i));
end


%smoothing
y4=[];
span = 155;
ch_num = 7;
for ch = 1:ch_num
    y4(:,ch) = smooth(y3(:,ch),span);
end

HbO2=y4;
save(filename,'HbO2');
%% short 003

load('TrangK13_short_003.TXT');
data=TrangK13_short_003;
filename='TrangK13_short_003_pp.mat';

% classify data
t=data(:,1);
stim=data(:,2);
fs=1/data(2,1);
data(:,[1:4])=[];
HbO=data(:,[1:3:21]);
lengthData=length(HbO);

%choose channel
oxy=HbO(:,1);
%stim vector
stim(find(stim==2))=0;
for i=1:length(stim)
    if i==length(stim)
        break;
    end
    if (stim(i+1)==1)&(stim(i)==0)
        stim(i+1)=2;
    end
    if (stim(i+1)==0)&(stim(i)==1)
        stim(i)=-1;
    end
end
stim(find(stim==1))=0;
stim(find(stim==2))=1;

% preprocess - bandpass filter
N=3;
x=HbO;
Wn1=0.01;
Wn2=0.5;
[b,a]=butter(N,2*0.055*[Wn1 Wn2],'bandpass');
y2=filter(b,a,x);

%moving average
y3=[];
a = 1;
b(1:ceil(fs*5))=1/(fs*5);
for i=1:7
    y3(:,i)=filtfilt(b,a,y2(:,i));
end


%smoothing
y4=[];
span = 155;
ch_num = 7;
for ch = 1:ch_num
    y4(:,ch) = smooth(y3(:,ch),span);
end

HbO3=y4;
save(filename,'HbO3');
%% short 004
load('TrangK13_short_004.TXT');
data=TrangK13_short_004;
filename='TrangK13_short_004_pp.mat';
% classify data
t=data(:,1);
stim=data(:,2);
fs=1/data(2,1);
data(:,[1:4])=[];
HbO=data(:,[1:3:21]);
lengthData=length(HbO);

%choose channel
oxy=HbO(:,1);
%stim vector
stim(find(stim==2))=0;
for i=1:length(stim)
    if i==length(stim)
        break;
    end
    if (stim(i+1)==1)&(stim(i)==0)
        stim(i+1)=2;
    end
    if (stim(i+1)==0)&(stim(i)==1)
        stim(i)=-1;
    end
end
stim(find(stim==1))=0;
stim(find(stim==2))=1;

% preprocess - bandpass filter
N=3;
x=HbO;
Wn1=0.01;
Wn2=0.5;
[b,a]=butter(N,2*0.055*[Wn1 Wn2],'bandpass');
y2=filter(b,a,x);

%moving average
y3=[];
a = 1;
b(1:ceil(fs*5))=1/(fs*5);
for i=1:7
    y3(:,i)=filtfilt(b,a,y2(:,i));
end


%smoothing
y4=[];
span = 155;
ch_num = 7;
for ch = 1:ch_num
    y4(:,ch) = smooth(y3(:,ch),span);
end

HbO4=y4;
save(filename,'HbO4');
%% short 005
load('TrangK13_short_005.TXT');
data=TrangK13_short_005;
filename='TrangK13_short_005_pp.mat';
% classify data
t=data(:,1);
stim=data(:,2);
fs=1/data(2,1);
data(:,[1:4])=[];
HbO=data(:,[1:3:21]);
lengthData=length(HbO);

%choose channel
oxy=HbO(:,1);
%stim vector
stim(find(stim==2))=0;
for i=1:length(stim)
    if i==length(stim)
        break;
    end
    if (stim(i+1)==1)&(stim(i)==0)
        stim(i+1)=2;
    end
    if (stim(i+1)==0)&(stim(i)==1)
        stim(i)=-1;
    end
end
stim(find(stim==1))=0;
stim(find(stim==2))=1;

% preprocess - bandpass filter
N=3;
x=HbO;
Wn1=0.01;
Wn2=0.5;
[b,a]=butter(N,2*0.055*[Wn1 Wn2],'bandpass');
y2=filter(b,a,x);

%moving average
y3=[];
a = 1;
b(1:ceil(fs*5))=1/(fs*5);
for i=1:7
    y3(:,i)=filtfilt(b,a,y2(:,i));
end


%smoothing
y4=[];
span = 155;
ch_num = 7;
for ch = 1:ch_num
    y4(:,ch) = smooth(y3(:,ch),span);
end

HbO5=y4;
save(filename,'HbO5');
%% plot
figure
subplot (5,1,1), plot(HbO1); title ('TrangK13 short 001');
subplot (5,1,2), plot(HbO2); title ('TrangK13 short 002');
subplot (5,1,3), plot(HbO3); title ('TrangK13 short 003');
subplot (5,1,4), plot(HbO4); title ('TrangK13 short 004');
subplot (5,1,5), plot(HbO5); title ('TrangK13 short 005');
