function stim=getStimVector(d)
stim=d(:,2);
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
end