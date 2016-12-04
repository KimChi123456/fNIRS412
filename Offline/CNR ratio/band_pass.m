function filtered=band_pass(N,Wn1,Wn2,x)
[b,a]=butter(N,2*0.055*[Wn1 Wn2],'bandpass');
filtered=filter(b,a,x);

end

