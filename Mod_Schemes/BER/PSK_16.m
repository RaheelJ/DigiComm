ENR=0;                          %initially value of Eb/No
while (ENR<=10)                  %plot for 9 values of ENR
symbol_error=0;
symbol=0;
bits=0;                         %count of bits for which error is 500
error=0;                        %count of errors till they reaches 500
while (error<1000)               %500 errors before calculting BER
    x=rand(1, 4);               %4 input bits uniformly generated
    x=round(x);                 %T is to be mapped and transmitted
    
    if x==[0 0 0 0]
        T=1;
    end
    if x==[0 0 0 1]
        T=1*exp(1j*(pi/8));
    end
    if x==[0 0 1 1]
        T=1*exp(1j*(2*pi/8));
    end
    if x==[0 0 1 0]
        T=1*exp(1j*(3*pi/8));
    end
    
    if x==[0 1 1 0]
        T=1*exp(1j*(4*pi/8));
    end
    
    if x==[0 1 0 0]
        T=1*exp(1j*(5*pi/8));
    end
    
    if x==[0 1 0 1]
        T=1*exp(1j*(6*pi/8));
    end
    if x==[0 1 1 1]
        T=1*exp(1j*(7*pi/8));
    end
    if x==[1 1 1 1]
        T=1*exp(1j*(8*pi/8));
    end
    
    if x==[1 1 1 0]
        T=1*exp(1j*(9*pi/8));
    end
    
    if x==[1 1 0 0]
        T=1*exp(1j*(10*pi/8));
    end
    
    if x==[1 1 0 1]
        T=1*exp(1j*(11*pi/8));
    end
    if x==[1 0 0 1]
        T=1*exp(1j*(12*pi/8));
    end
    if x==[1 0 1 1]
        T=1*exp(1j*(13*pi/8));
    end
    if x==[1 0 1 0]
        T=1*exp(1j*(14*pi/8));
    end
    if x==[1 0 0 0]
        T=1*exp(1j*(15*pi/8));
    end
     
    Std=(sqrt(0.125))/sqrt(10^(ENR/10));    %Std of AWGN
    N=Std.*randn(1, 1); %4 sample of Gaussian Noise with mean=0 and Std
    M=Std.*randn(1, 1);
    R=T+N+M*1j;                  %Received bits with effect of noise
    t=angle(R);  
        if(abs(t)<pi/16)
            r=[0 0 0 0];
        end
        if(t>pi/16 && t<3*pi/16)
            r=[0 0 0 1];
        end
        if(t>3*pi/16 && t<5*pi/16)
            r=[0 0 1 1];
        end
        if(t>5*pi/16 && t<7*pi/16)
            r=[0 0 1 0];
        end
        if(t>7*pi/16 && t<9*pi/16)
            r=[0 1 1 0];
        end
        if(t>9*pi/16 && t<11*pi/16)
            r=[0 1 0 0];
        end
        if(t>11*pi/16 && t<13*pi/16)
            r=[0 1 0 1];
        end
        if(t>13*pi/16 && t<15*pi/16)
            r=[0 1 1 1];
        end
        if(abs(t)>15*pi/16)
            r=[1 1 1 1];
        end
        if(t>-15*pi/16 && t<-13*pi/16)
            r=[1 1 1 0];
        end
        
        if(t>-13*pi/16 && t<-11*pi/16)
            r=[1 1 0 0];
        end
        if(t>-11*pi/16 && t<-9*pi/16)
            r=[1 1 0 1];
        end
        
        if(t>-9*pi/16 && t<-7*pi/16)
            r=[1 0 0 1];
        end
        if(t>-7*pi/16 && t<-5*pi/16)
            r=[1 0 1 1];
        end
        if(t>-5*pi/16 && t<-3*pi/16)
            r=[1 0 1 0];
        end
        if(t>-3*pi/16 && t<-pi/16)
            r=[1 0 0 0];
        end
        
    bits=bits+4;        %Count the bits transmitted just now
    symbol=symbol+1;
    E=mod(r+x, 2);      %Error between input and received bits
    if(sum(E)~=0)
        symbol_error=symbol_error+1;
    end
    error=error+sum(E); %Count any error found
end
BER(ENR+1)=1000/bits;    %Calculation of BER
SER(ENR+1)=symbol_error/symbol;
ENR=ENR+1;              %ENR increased by 1 for calculation of next BER
end
ENR=0:10;         %range of ENR at which BER is found
hold off

plot(ENR, BER, 'c')   %plot of BER Vs ENR with default blue color

