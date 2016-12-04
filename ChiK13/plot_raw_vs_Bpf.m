clear all
clc
close all

load('Chi_rawHbO_003.mat');
load('Chi_BpfHbO_003.mat');
load('t.mat');

figure

for i=1:7
   subplot(7,1,i), plot(t,rawHbO_003(:,i));
   if (i==7) 
     xlabel ('raw HbO Concentration 003');  
   end
end

figure 

for i=1:7
   subplot(7,1,i), plot(t,BpfHbO_003(:,i));
   if (i==7) 
     xlabel ('Bpf HbO Concentration 003');  
   end
end
