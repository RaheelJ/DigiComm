    x=rand(1, 1002);
    x=round(x);
    j=0;
for i=1:3:1000
   
    if x(i:i+2)==[0 0 0] 
    s((1:9)+9*j)=[7*ones(1, 9)]; end
    if x(i:i+2)==[0 0 1]
    s((1:9)+9*j)=[5*ones(1, 9)]; end
    if x(i:i+2)==[0 1 1]
    s((1:9)+9*j)=[3*ones(1, 9)]; end
    if x(i:i+2)==[0 1 0]
    s((1:9)+9*j)=[ones(1, 9)]; end
    if x(i:i+2)==[1 1 0] 
    s((1:9)+9*j)=[-ones(1, 9)]; end
    if x(i:i+2)==[1 0 0]
    s((1:9)+9*j)=[-3*ones(1, 9)]; end
    if x(i:i+2)==[1 0 1]
    s((1:9)+9*j)=[-5*ones(1, 9)]; end
    if x(i:i+2)==[1 1 1]
    s((1:9)+9*j)=[-7*ones(1, 9)]; end
    j=j+1;
end

    h = fspecial('gaussian', [1 21], 2.5);
    y=conv(s, h);
    m=0:length(s)-1;
    n=0:length(y)-1;
    o=0:length(h)-1;
   
    H=fftshift(fft(h, 8001));
    X=fftshift(fft(s, 8001));
    n1=-2*[4000:-1:1]./8000;
    n2=2*[1:4000]./8000;
    N=[n1 0 n2];
    Y=fftshift(fft(y, 8001));
   
    PSD_H=H.*conj(H);
    PSD_X=X.*conj(X);
    PSD_Y=Y.*conj(Y);
    
    subplot(2, 2, 1)
    stem(o, h)
    subplot(2, 2, 2)
    stem(N, PSD_H)
    subplot(2, 2, 3)
    stem(N, PSD_X)
    subplot(2, 2, 4)
    stem(N, PSD_Y)
    
    

