clear all; close all; clc;

%-----------------------------------------------------------------------------------------------------------------------
load('D:\IU\project(filtering fNIRS)\SASS_toolbox\Free noise\Tuan_rest.mat');
% load('D:\IU\project(filtering fNIRS)\SASS_toolbox\Free noise\Giang_rest.mat');
%-----------------------------------------------------------------------------------------------------------------------

Length=size(sav_data,1);
L=3346;
% subplot(2,1,1)
% hrf_parameters=[5.4 5.2 10.8 7.35 0.35];
% time=(0:L)/10;
% hrf0=fmridesign(time,0,[1 0],[],hrf_parameters);
% plot(time,squeeze(hrf0.X(:,1,1,1)))
% hold on
% hrf=(hrf0.X);

% hrf_parameters=[2.4 4.2 5.8 7.35 1.37];
% hrf_parameters=[5.4 5.2 10.8 7.35 0.35];
% hrf_parameters=[5.4 8.5 10.8 7.35 0.9];
% hrf_parameters=[6.5 8.2 10.8 7.5 0.9];
% hrf_parameters=[6.5 8.2 10.8 8.5 0.9];
% hrf_parameters=[6.5 6.2 10.8 7.35 0.35];
% hrf_parameters=[7 6.5 17.8 15.5 0.5];

% hrf_parameters=[150.4 250.2 400.8 250.35 1];
time=(0:L)/10;
n=12;
hrf_parameters=n*[5.4 5.2 15.8 7.35 0.15/n];
hrf0=fmridesign(time,0,[1 0],[],hrf_parameters);
% hrf1=hrf0.X(:,1,1,1);
hrf1=hrf0.X(:,1,1,1);%hrf=hrf(1:1500);
plot(time,squeeze(10*hrf0.X(:,1,1,1)),'k--')
hold on

% n=12;
hrf_parameters=n*[9.4 8.2 19.8 4.35 0.2/n];
% hrf_parameters=n*[5.4 5.2 15.8 7.35 0.15/n];
% hrf_parameters=n*[6.4 4.2 15.8 8.35 0.15/n];


hrf0=fmridesign(time,0,[1 0],[],hrf_parameters);
hrf=hrf0.X(:,1,1,1);%hrf=hrf(1:1500);
min(hrf),max(hrf),mean(hrf)
plot(time,squeeze(10*hrf0.X(:,1,1,1)),'r')

xlabel('time (seconds)')
ylabel('hrf')
title(['min: ' num2str(min(hrf(:,1))) '  ,max: ' num2str(max(hrf(:,1)))])
 
% save ('HRF_signals','hrf');

HRF_signal=10*hrf';HRF_signal1=10*hrf1';
rawdata=[zeros(1,1000) HRF_signal zeros(1,1050) HRF_signal zeros(1,9) HRF_signal zeros(1,382) HRF_signal zeros(1,585)];
rawdata1=[zeros(1,1000) HRF_signal1 zeros(1,1050) HRF_signal1 zeros(1,9) HRF_signal1 zeros(1,382) HRF_signal1 zeros(1,585)];
RawData=rawdata';
RawData1=rawdata1';
time=(0:size(RawData,1))/10;
RawData=repmat(RawData,1,7);RawData=repmat(RawData,4,1);%RawData=RawData(1:Length,:);
RawData1=repmat(RawData1,1,7);RawData1=repmat(RawData1,4,1);%RawData1=RawData1(1:Length,:);
noisyData=0.1*randn(2*size(RawData));
save ('RawData','RawData');save ('noisyData','noisyData');

figure

plot(RawData1(:,1),'k--')
hold on
plot(RawData(:,1),'r')

title(['min: ' num2str(min(hrf(:,1))) '  ,max: ' num2str(max(hrf(:,1)))])
% set(gca,'xtick',[])
% axis tight
xlabel('fs=10')
xlim([0 Length])
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 