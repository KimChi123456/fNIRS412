function filtered=lowpass(N,Wn,x)
[b,a]=butter(N,2*0.055*Wn,'low');
filtered=filter(b,a,x);

end

