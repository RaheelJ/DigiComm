ENR=0;                          %initially value of Eb/No
while (ENR<=10)                  %plot for 9 values of ENR
symbol_error=0;
symbol=0;
bits=0;                         %count of bits for which error is 500
error=0;                        %count of errors till they reaches 500
while (error<500)               %500 errors before calculting BER
    x=rand(1, 3);               %4 input bits uniformly generated
    x=round(x);                 
                               %T is to be mapped and transmitted
    if x==[0 0 0]
        T=1+0j;
    end
    if x==[0 0 1]
        T=0.707+0.707j;
    end
    if x==[0 1 1]
        T=0+1j;
    end
    if x==[0 1 0]
        T=-0.707+0.707j;
    end
    if x==[1 1 0]
        T=-1+0j;
    end
    if x==[1 1 1]
        T=-0.707-0.707j;
    end
    if x==[1 0 1]
        T=0-1j;
    end
    if x==[1 0 0]
        T=0.707-0.707j;
    end
     
    Std=sqrt(0.5/3)/sqrt(10^(ENR/10));    %Std of AWGN
    N=Std.*randn(1, 1); %4 sample of Gaussian Noise with mean=0 and Std
    R=T+N+N*1j;                  %Received bits with effect of noise
       
        if ((real(R)>0) && (abs(imag(R))<(real(R)*0.4142)))       %Hard decision to identify the received bits
            R=1+0j;
            r=[0 0 0];
        end
        if ((real(R)>0) && (imag(R)>0) && ((imag(R)/real(R))>0.4142) && ((imag(R)/real(R))<2.4142))       %Hard decision to identify the received bits
            R=0.707+0.707j;
            r=[0 0 1];
        end
        if ((imag(R)>0) && (abs(real(R))<(imag(R)*0.4142)))       %Hard decision to identify the received bits
            R=0+1j;
            r=[0 1 1];
        end
     
        if ((real(R)<0) && (imag(R)>0) && ((imag(R)/real(R)>-2.4142)) && ((imag(R)/real(R))<-0.4142))       %Hard decision to identify the received bits
            R=-0.707+0.707j;
            r=[0 1 0];
        end
        if ((real(R)<0) && (abs(imag(R))<(real(R)*-0.4142)))       %Hard decision to identify the received bits
            R=-1+0j;
            r=[1 1 0];
        end
        if ((real(R)<0) && (imag(R)<0) && ((imag(R)/real(R))>0.4142) && ((imag(R)/real(R))<2.4142))       %Hard decision to identify the received bits
            R=-0.707-0.707j;
            r=[1 1 1];
        end
         if ((imag(R)<0) && (abs(real(R))<(imag(R)*-0.4142)))       %Hard decision to identify the received bits
            R=0-1j;
            r=[1 0 1];
         end
         if ((real(R)>0) && (imag(R)<0) && ((imag(R)/real(R))>-2.4142) && ((imag(R)/real(R))<-0.4142))       %Hard decision to identify the received bits
            R=0.707-0.707j;
            r=[1 0 0];
         end
        
        
    
    bits=bits+3;        %Count the bits transmitted just now
    symbol=symbol+1;
    E=mod(r+x, 2);      %Error between input and received bits
    if(sum(E)~=0)
        symbol_error=symbol_error+1;
    end
    error=error+sum(E); %Count any error found
end
BER(ENR+1)=500/bits;    %Calculation of BER
SER(ENR+1)=symbol_error/symbol;
ENR=ENR+1;              %ENR increased by 1 for calculation of next BER
end
ENR=0:10;         %range of ENR at which BER is found
hold off
plot(ENR, BER, 'r')   %plot of BER Vs ENR with default blue color
hold on
plot(ENR, SER, 'b')