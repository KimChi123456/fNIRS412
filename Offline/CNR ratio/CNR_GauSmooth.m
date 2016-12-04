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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%GAUSSIAN SMOOTH
oxyRaw=oxy;
oxyBand=band_pass(4,0.01,0.5,oxyRaw);

for i=1:ch
   oxy_filt(:,i)=gausmooth(100,2.5,oxyBand(:,i));  
end
size(oxy_filt)



cnr=[];
for i=1:ch
    CNR_filt=(mean(oxy_filt(:,i))-mean(oxyRaw(:,i)))/sqrt((std(oxy_filt(:,i))).^2+(std(oxyRaw(:,i))).^2);
    cnr=[cnr CNR_filt];
end
cnr_filt=cnr
mean_cnr=mean(cnr_filt)





%%%%%%%%%%%%%%%Plot
figure('Name','Lowpass','NumberTitle','off')
ax(1)=subplot(2,1,1);
plot(oxyRaw(:,1),'r')
axis tight

m=xlabel('RAW');
set(m, 'FontSize', 7);
ax(2)=subplot(2,1,2);
plot(oxyBand(:,1),'r')
linkaxes([ax(1) ax(2)],'xy')

m=xlabel('GAUSSIAN');
set(m, 'FontSize', 7);












