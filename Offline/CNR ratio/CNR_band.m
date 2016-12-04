close all, clear all, clc

load('D:\IU\project(filtering fNIRS)\GUI\data testNIRS\rest\Tuan4.mat');
data=sav_data; Task=data(:,1);
oxy=data(:,2:8);
size(oxy)
deoxy=data(:,9:end);
[length ch]=size(oxy);
rest_find=find(Task==1);

task_mark=rest_find(1);

rest_oxy=oxy(1:task_mark,1:ch);
rest_deoxy=deoxy(1:task_mark,1:ch);
task_oxy=oxy(task_mark+1:end,1:ch);
task_deoxy=deoxy(task_mark+1:end,1:ch);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%LOWPASS
oxyRaw=oxy;
oxyLow=band_pass(1,0.01,0.5,oxyRaw);

%%%%%%%%%%%%%%%Plot
figure('Name','Lowpass','NumberTitle','off')
ax(1)=subplot(2,1,1);
plot(oxyRaw(:,2),'r')
axis tight

m=xlabel('RAW');
set(m, 'FontSize', 7);
ax(2)=subplot(2,1,2);
plot(oxyLow(:,2),'r')
linkaxes([ax(1) ax(2)],'xy')

m=xlabel('lowpass [butter(10, 0.5, low)]');
set(m, 'FontSize', 7);


% CNR_low=(mean(oxyFilter1)-mean(oxyRaw))/sqrt((std(oxyFilter1)).^2+(std(oxyRaw)).^2)

cnr=[];
for i=1:ch
    CNR_low=(mean(oxyLow(:,i))-mean(oxyRaw(:,i)))/sqrt((std(oxyLow(:,i))).^2+(std(oxyRaw(:,i))).^2);
    cnr=[cnr CNR_low];
end
cnr_band=cnr











