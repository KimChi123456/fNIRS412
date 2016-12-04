%%
%{
input: HbR .txt files of 5 measurement sections - [#time point] by [#channels]
output: segmented .mat file - [#sections*10] by 1000 by [#channels]
NOTE: each section is divided into 10 1000-points segments - 
rest task task rest task task rest task task rest
%}

%%
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
load('fNIRSdata2/ChiK13/ChiK13_short_001.TXT');
data=ChiK13_short_001;
filename='ChiK13_HbR.mat';
% classify data
t=data(:,1);
stim=data(:,2);
fs=1/data(2,1);
data(:,[1:4])=[];
HbR=data(:,[2:3:21]);
lengthData=length(HbR);
% for i=1:7
%     subplot(7,1,i), plot(t,HbR(:,i));
%     title(i);
% end
%choose channel
oxy=HbR(:,1);
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
x=HbR;
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

HbR=y4;

%segment
s=find(stim==1|stim==-1);
n=1000;
for i=1:7
r1(:,i)=HbR([1:n*floor(s(1)/n)],i);
t1(:,i)=HbR([n*floor(s(1)/n):n*floor(s(2)/n)-1],i);
r2(:,i)=HbR([n*floor(s(2)/n):n*floor(s(3)/n)-1],i);
t2(:,i)=HbR([n*floor(s(3)/n):n*floor(s(4)/n)-1],i);
r3(:,i)=HbR([n*floor(s(4)/n):n*floor(s(5)/n)-1],i);
t3(:,i)=HbR([n*floor(s(5)/n):n*floor(s(6)/n)-1],i);
r4(:,i)=HbR([n*floor(s(6)/n):n*floor(lengthData/n)-1],i);
data1(:,i)=[r1(:,i);t1(:,i);r2(:,i);t2(:,i);r3(:,i);t3(:,i);r4(:,i)];
end
   

% [filen, pathn] = uigetfile('*.txt','Select the Voltage txt file');
% path_file_n = [pathn filen];
% if filen(1) == 0 | pathn(1) == 0
%     return;
% end
% fid = fopen(path_file_n);
% disp('Loading data...');
% tline=fscanf(fid,'%c',Inf);
% data=str2num(tline);

load('fNIRSdata2/ChiK13/ChiK13_short_002.TXT');
data=ChiK13_short_002;
data(:,[1:4])=[];
HbR=data(:,[2:3:21]);
lengthData=length(HbR);
N=3;
x=HbR;
Wn1=0.01;
Wn2=0.5;
[b,a]=butter(N,2*0.055*[Wn1 Wn2],'bandpass');
y2=filter(b,a,x);
%moving average
a = 1;
b(1:ceil(fs*5))=1/(fs*5);
y3=[];
for i=1:7
    y3(:,i)=filtfilt(b,a,y2(:,i));
end

%smoothing
span = 155;
ch_num = 7;
y4=[];
for ch = 1:ch_num
    y4(:,ch) = smooth(y3(:,ch),span);
end

HbR=y4;
for i=1:7
r1(:,i)=HbR([1:n*floor(s(1)/n)],i);
t1(:,i)=HbR([n*floor(s(1)/n):n*floor(s(2)/n)-1],i);
r2(:,i)=HbR([n*floor(s(2)/n):n*floor(s(3)/n)-1],i);
t2(:,i)=HbR([n*floor(s(3)/n):n*floor(s(4)/n)-1],i);
r3(:,i)=HbR([n*floor(s(4)/n):n*floor(s(5)/n)-1],i);
t3(:,i)=HbR([n*floor(s(5)/n):n*floor(s(6)/n)-1],i);
r4(:,i)=HbR([n*floor(s(6)/n):n*floor(lengthData/n)-1],i);
data2(:,i)=[r1(:,i);t1(:,i);r2(:,i);t2(:,i);r3(:,i);t3(:,i);r4(:,i)];
end
% [filen, pathn] = uigetfile('*.txt','Select the Voltage txt file');
% path_file_n = [pathn filen];
% if filen(1) == 0 | pathn(1) == 0
%     return;
% end
% fid = fopen(path_file_n);
% disp('Loading data...');
% tline=fscanf(fid,'%c',Inf);
% data=str2num(tline);
load('fNIRSdata2/ChiK13/ChiK13_short_003.TXT');
data=ChiK13_short_003;

data(:,[1:4])=[];
HbR=data(:,[2:3:21]);
lengthData=length(HbR);
N=3;
x=HbR;
Wn1=0.01;
Wn2=0.5;
[b,a]=butter(N,2*0.055*[Wn1 Wn2],'bandpass');
y2=filter(b,a,x);
%moving average
a = 1;
b(1:ceil(fs*5))=1/(fs*5);
y3=[];
for i=1:7
    y3(:,i)=filtfilt(b,a,y2(:,i));
end

%smoothing
span = 155;
ch_num = 7;
y4=[];
for ch = 1:ch_num
    y4(:,ch) = smooth(y3(:,ch),span);
end

HbR=y4;
for i=1:7
r1(:,i)=HbR([1:n*floor(s(1)/n)],i);
t1(:,i)=HbR([n*floor(s(1)/n):n*floor(s(2)/n)-1],i);
r2(:,i)=HbR([n*floor(s(2)/n):n*floor(s(3)/n)-1],i);
t2(:,i)=HbR([n*floor(s(3)/n):n*floor(s(4)/n)-1],i);
r3(:,i)=HbR([n*floor(s(4)/n):n*floor(s(5)/n)-1],i);
t3(:,i)=HbR([n*floor(s(5)/n):n*floor(s(6)/n)-1],i);
r4(:,i)=HbR([n*floor(s(6)/n):n*floor(lengthData/n)-1],i);
data3(:,i)=[r1(:,i);t1(:,i);r2(:,i);t2(:,i);r3(:,i);t3(:,i);r4(:,i)];
end
% [filen, pathn] = uigetfile('*.txt','Select the Voltage txt file');
% path_file_n = [pathn filen];
% if filen(1) == 0 | pathn(1) == 0
%     return;
% end
% fid = fopen(path_file_n);
% disp('Loading data...');
% tline=fscanf(fid,'%c',Inf);
% data=str2num(tline);
load('fNIRSdata2/ChiK13/ChiK13_short_004.TXT');
data=ChiK13_short_004;

data(:,[1:4])=[];
HbR=data(:,[2:3:21]);
lengthData=length(HbR);
N=3;
x=HbR;
Wn1=0.01;
Wn2=0.5;
[b,a]=butter(N,2*0.055*[Wn1 Wn2],'bandpass');
y2=filter(b,a,x);
%moving average
a = 1;
b(1:ceil(fs*5))=1/(fs*5);
y3=[];
for i=1:7
    y3(:,i)=filtfilt(b,a,y2(:,i));
end

%smoothing
span = 155;
ch_num = 7;
y4=[];
for ch = 1:ch_num
    y4(:,ch) = smooth(y3(:,ch),span);
end

HbR=y4;
for i=1:7
r1(:,i)=HbR([1:n*floor(s(1)/n)],i);
t1(:,i)=HbR([n*floor(s(1)/n):n*floor(s(2)/n)-1],i);
r2(:,i)=HbR([n*floor(s(2)/n):n*floor(s(3)/n)-1],i);
t2(:,i)=HbR([n*floor(s(3)/n):n*floor(s(4)/n)-1],i);
r3(:,i)=HbR([n*floor(s(4)/n):n*floor(s(5)/n)-1],i);
t3(:,i)=HbR([n*floor(s(5)/n):n*floor(s(6)/n)-1],i);
r4(:,i)=HbR([n*floor(s(6)/n):n*floor(lengthData/n)-1],i);
data4(:,i)=[r1(:,i);t1(:,i);r2(:,i);t2(:,i);r3(:,i);t3(:,i);r4(:,i)];
end
% [filen, pathn] = uigetfile('*.txt','Select the Voltage txt file');
% path_file_n = [pathn filen];
% if filen(1) == 0 | pathn(1) == 0
%     return;
% end
% fid = fopen(path_file_n);
% disp('Loading data...');
% tline=fscanf(fid,'%c',Inf);
% data=str2num(tline);
load('fNIRSdata2/ChiK13/ChiK13_short_005.TXT');
data=ChiK13_short_005;

data(:,[1:4])=[];
HbR=data(:,[2:3:21]);
lengthData=length(HbR);
N=3;
x=HbR;
Wn1=0.01;
Wn2=0.5;
[b,a]=butter(N,2*0.055*[Wn1 Wn2],'bandpass');
y2=filter(b,a,x);

%moving average
a = 1;
b(1:ceil(fs*5))=1/(fs*5);
y3=[];
for i=1:7
    y3(:,i)=filtfilt(b,a,y2(:,i));
end

%smoothing
span = 155;
ch_num = 7;
y4=[];
for ch = 1:ch_num
    y4(:,ch) = smooth(y3(:,ch),span);
end

HbR=y4;
for i=1:7
r1(:,i)=HbR([1:n*floor(s(1)/n)],i);
t1(:,i)=HbR([n*floor(s(1)/n):n*floor(s(2)/n)-1],i);
r2(:,i)=HbR([n*floor(s(2)/n):n*floor(s(3)/n)-1],i);
t2(:,i)=HbR([n*floor(s(3)/n):n*floor(s(4)/n)-1],i);
r3(:,i)=HbR([n*floor(s(4)/n):n*floor(s(5)/n)-1],i);
t3(:,i)=HbR([n*floor(s(5)/n):n*floor(s(6)/n)-1],i);
r4(:,i)=HbR([n*floor(s(6)/n):n*floor(lengthData/n)-1],i);
data5(:,i)=[r1(:,i);t1(:,i);r2(:,i);t2(:,i);r3(:,i);t3(:,i);r4(:,i)];
end
for i=1:7
    d1=reshape(data1(:,i),n,10);
    d2=reshape(data2(:,i),n,10);
    d3=reshape(data3(:,i),n,10);
    d4=reshape(data4(:,i),n,10);
    d5=reshape(data5(:,i),n,10);
    datan(:,:,i)=[d1';d2';d3';d4';d5'];
end
% figure
% for i=1:50
%     
% subplot(5,10,i), plot(datan(i,:,2)); 
% hold on
%     
% end
% subplot(4,1,1), plot(x(:,1)); title('raw');
% subplot(4,1,2), plot(y2(:,1)); title('bandpass filtered');
% subplot(4,1,3), plot(y3(:,1)); title('moving average');
% subplot(4,1,4), plot(y4(:,1)); title('smooth');
save(filename,'datan');
