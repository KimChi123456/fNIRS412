close all; 
clear all
clc
[filen, pathn] = uigetfile('*.txt','Select the Hb txt file');
path_file_n = [pathn filen];
if filen(1) == 0 | pathn(1) == 0
    return;
end
fid = fopen(path_file_n);
disp('Loading data...');
tline=fscanf(fid,'%c',Inf);
data=str2num(tline);
% currentFolder=pwd;
% n=1;
%  load('ChiK13_short_1282_Hb.TXT');
%  data=ChiK13_short_1282_Hb;
t=data(:,1);
% data(:,[1:4])=[];
% HbO=data(:,[1:3:21]);
% HbR=data(:,[2:3:21]);
% HbT=data(:,[3:3:21]);
data(:,1)=[];
figure 
title('HbO');
for i=1:3
    subplot(3,1,i), plot(t,data(:,i));
    title(i);
end
