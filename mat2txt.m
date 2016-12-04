Data = load('FileName.mat');
DataField = fieldnames(Data);
dlmwrite('FileName.txt', Data.(DataField{1}));