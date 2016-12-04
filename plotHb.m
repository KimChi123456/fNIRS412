% close all; 
% clear all
clc
[filen, pathn] = uigetfile('*.txt','Select the raw Hb txt file');
path_file_n = [pathn filen];
if filen(1) == 0 | pathn(1) == 0
    return;
end
fid = fopen(path_file_n);
disp('Loading data...');
tline=fscanf(fid,'%c',Inf);
data=str2num(tline);
currentFolder=pwd;
n=1;
%  load('ChiK13_short_1282_Hb.TXT');
%  data=ChiK13_short_1282_Hb;
t=data(:,1);
data=data(:,[2:size(data,2)]);
% HbO=data(:,[1:3:21]);
% HbR=data(:,[2:3:21]);
% HbT=data(:,[3:3:21]);

[filen, pathn] = uigetfile('*.txt','Select the Bpf Hb txt file');
path_file_n = [pathn filen];
if filen(1) == 0 | pathn(1) == 0
    return;
end
fid = fopen(path_file_n);
disp('Loading data...');
tline=fscanf(fid,'%c',Inf);
data2=str2num(tline);
data2=data2(:,[2:size(data2,2)]);
figure 
title('HbO');
for i=1:size(data,2)
    subplot(size(data,2),2,2*i-1), plot(t,data2(:,i),'r');
    subplot(size(data,2),2,2*i), plot (t,data(:,i));
    title(i);
end
figure
subplot(2,1,1), plot(t,data(:,1));
subplot(2,1,2), plot(t,data2(:,1));