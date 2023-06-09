   x=rand(1, 1004);
   x=round(x);
   r=0; 

for i=1:4:1000
    
    if x(i:i+3)==[0 0 0 0]
        T((1:10)+10*r)=3+3j;
    end
    if x(i:i+3)==[0 0 0 1]
        T((1:10)+10*r)=1+3j;
    end
    if x(i:i+3)==[0 0 1 1]
        T((1:10)+10*r)=-1+3j;
    end
    if x(i:i+3)==[0 0 1 0]
        T((1:10)+10*r)=-3+3j;
    end
    if x(i:i+3)==[0 1 1 0]
        T((1:10)+10*r)=3+1j;
    end
    if x(i:i+3)==[0 1 1 1]
        T((1:10)+10*r)=1+1j;
    end
    if x(i:i+3)==[0 1 0 1]
        T((1:10)+10*r)=-1+1j;
    end
    if x(i:i+3)==[0 1 0 0]
        T((1:10)+10*r)=-3+1j;
    end

    if x(i:i+3)==[1 1 0 0]
        T((1:10)+10*r)=3-1j;
    end
    if x(i:i+3)==[1 1 0 1]
        T((1:10)+10*r)=1-1j;
    end
    if x(i:i+3)==[1 1 1 1]
        T((1:10)+10*r)=-1-1j;
    end
    if x(i:i+3)==[1 1 1 0]
        T((1:10)+10*r)=-3-1j;
    end
    if x(i:i+3)==[1 0 1 0]
        T((1:10)+10*r)=3-3j;
    end
    if x(i:i+3)==[1 0 1 1]
        T((1:10)+10*r)=1-3j;
    end
    if x(i:i+3)==[1 0 0 1]
        T((1:10)+10*r)=-1-3j;
    end
    if x(i:i+3)==[1 0 0 0]
        T((1:10)+10*r)=-3-3j;
    end
    r=r+1;
end

Hx=0.2*rcosine(1, 5, 'fir', 1);
    h=abs(fftshift(fft(Hx, 50)));
    y1=conv(real(T), h);
    y2=conv(imag(T), h);
    m=0:length(T)-1;
    n=0:length(y1)-1;
    o=0:length(h)-1;
   
    H=fftshift(fft(h, 8001));
    X1=fftshift(fft(real(T), 8001));
    X2=fftshift(fft(imag(T), 8001));
    n1=-2*[4000:-1:1]./8000;
    n2=2*[1:4000]./8000;
    N=[n1 0 n2];
    Y1=fftshift(fft(y1, 8001));
    Y2=fftshift(fft(y2, 8001));
   
    PSD_H=H.*conj(H);
    PSD_X=abs(X1).^2 + abs(X2).^2;
    PSD_Y=abs(Y1).^2 + abs(Y2).^2;
    
    subplot(2, 2, 1)
    stem(o, h)
    subplot(2, 2, 2)
    stem(N, PSD_H)
    subplot(2, 2, 3)
    stem(N, PSD_X)
    subplot(2, 2, 4)
    stem(N, PSD_Y) 

    
    
    