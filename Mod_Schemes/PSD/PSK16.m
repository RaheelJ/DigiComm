   x=rand(1, 1004);
   x=round(x);
   r=0; 
   
   for (i=1:4:1000)
       
    if x(i:i+3)==[0 0 0 0]
        T((1:10)+r*10)=1;
    end
    if x(i:i+3)==[0 0 0 1]
        T((1:10)+r*10)=1*exp(1j*(pi/8));
    end
    if x(i:i+3)==[0 0 1 1]
        T((1:10)+r*10)=1*exp(1j*(2*pi/8));
    end
    if x(i:i+3)==[0 0 1 0]
        T((1:10)+r*10)=1*exp(1j*(3*pi/8));
    end
    
    if x(i:i+3)==[0 1 1 0]
        T((1:10)+r*10)=1*exp(1j*(4*pi/8));
    end
    
    if x(i:i+3)==[0 1 0 0]
        T((1:10)+r*10)=1*exp(1j*(5*pi/8));
    end
    
    if x(i:i+3)==[0 1 0 1]
        T((1:10)+r*10)=1*exp(1j*(6*pi/8));
    end
    if x(i:i+3)==[0 1 1 1]
        T((1:10)+r*10)=1*exp(1j*(7*pi/8));
    end
    if x(i:i+3)==[1 1 1 1]
        T((1:10)+r*10)=1*exp(1j*(8*pi/8));
    end
    
    if x(i:i+3)==[1 1 1 0]
        T((1:10)+r*10)=1*exp(1j*(9*pi/8));
    end
    
    if x(i:i+3)==[1 1 0 0]
        T((1:10)+r*10)=1*exp(1j*(10*pi/8));
    end
    
    if x(i:i+3)==[1 1 0 1]
        T((1:10)+r*10)=1*exp(1j*(11*pi/8));
    end
    if x(i:i+3)==[1 0 0 1]
        T((1:10)+r*10)=1*exp(1j*(12*pi/8));
    end
    if x(i:i+3)==[1 0 1 1]
        T((1:10)+r*10)=1*exp(1j*(13*pi/8));
    end
    if x(i:i+3)==[1 0 1 0]
        T((1:10)+r*10)=1*exp(1j*(14*pi/8));
    end
    if x(i:i+3)==[1 0 0 0]
        T((1:10)+r*10)=1*exp(1j*(15*pi/8));
    end
    
    r=r+1;
   end
     
    h=rcosine(2510, 2510*5, 'fir', 1);
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

    