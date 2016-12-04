function f=CNR(d,stim)
T=find(stim==1);
R=find(stim==-1);
meanT=[];
meanTask=[];
meanR=[];
meanRest=[];
 for i=1:7
    meanT(:,1)=mean(d([T(1,:):R(1,:)],i));
    meanT(:,2)=mean(d([T(2,:):R(2,:)],i));
    meanT(:,3)=mean(d([T(3,:):R(3,:)],i));
    meanTask(:,i)=mean(meanT);
    
    meanR(:,1)=mean(d([1:T(1,:)],i));
    meanR(:,2)=mean(d([R(1,:):T(2,:)],i));
    meanR(:,3)=mean(d([R(2,:):T(3,:)],i));
    meanR(:,4)=mean(d([R(3,:):size(d,1)],i));
    meanRest(:,i)=mean(meanR);
    
    varT(:,1)=var(d([T(1,:):R(1,:)],i));
    varT(:,2)=var(d([T(2,:):R(2,:)],i));
    varT(:,3)=var(d([T(3,:):R(3,:)],i));
    varTask(:,i)=mean(varT);
    
    varR(:,1)=var(d([1:T(1,:)],i));
    varR(:,2)=var(d([R(1,:):T(2,:)],i));
    varR(:,3)=var(d([R(2,:):T(3,:)],i));
    varR(:,4)=var(d([R(3,:):size(d,1)],i));
    varRest(:,i)=mean(varR);
    
     f(i,1)=(abs(meanTask(:,i)-meanRest(:,i))/sqrt((varTask(:,i)+varRest(:,i))));
% f(i,1)=abs(meanTask(:,i)-meanRest(:,i));
 end

end