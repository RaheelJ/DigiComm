ENR=0;                          %initial value of Eb/No
% Matrix containing 16 waveforms
trans=[1*exp(1j*(0*pi/8)) 1*exp(1j*(1*pi/8)) 1*exp(1j*(2*pi/8)) 1*exp(1j*(3*pi/8)) 1*exp(1j*(4*pi/8)) 1*exp(1j*(5*pi/8)) 1*exp(1j*(6*pi/8)) 1*exp(1j*(7*pi/8)) 1*exp(1j*(8*pi/8)) 1*exp(1j*(9*pi/8)) 1*exp(1j*(10*pi/8)) 1*exp(1j*(11*pi/8)) 1*exp(1j*(12*pi/8)) 1*exp(1j*(13*pi/8)) 1*exp(1j*(14*pi/8)) 1*exp(1j*(15*pi/8))];
%Matrix containing possible bit combinations
Matrix=[0 0 0 0; 0 0 0 1; 0 0 1 1; 0 0 1 0; 0 1 1 0; 0 1 0 0; 0 1 0 1; 0 1 1 1; 1 1 1 1; 1 1 1 0; 1 1 0 0; 1 1 0 1; 1 0 0 1; 1 0 1 1; 1 0 1 0; 1 0 0 0];

while (ENR<=10)                  %plot for 11 values of ENR
bits=0;                         %count of bits for which error is 500
error=0;                        %count of errors till they reaches 500
while (error<500)               %500 errors before calculting BER
    x=rand(1, 4);               %4 input bits uniformly generated
    x=round(x);                 
    
    if x==[0 0 0 0]             %Mapping x to 1 of 16 possible waveforms
        T=1;
    end
    if x==[0 0 0 1]
        T=1*exp(1j*(pi/8));     %Complex representation used to represent 2 orthogonal waveforms
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
    N=Std.*randn(1, 1);                     %1 sample of Gaussian Noise with mean=0 and Std for I component
    M=Std.*randn(1, 1);                     % for Q component
    Rec=T+N+M*1j;                           %Received waveform with effect of noise
    
    R=intdump(Rec, 1);                      %Integrate and dump with 1 sample of waveform
    
    for n=1:16
        Correlation(n)=(real(R)*real(trans(n))+imag(R)*imag(trans(n)))-(0.5*(abs(trans(n))^2)); %Implementation of correlation receiver
    end
    
    [Rx, n]=max(Correlation);               
    r=Matrix(n, :);                         %Pick m for which correlation is maximum
    
    bits=bits+4;        %Count the bits transmitted just now
    E=mod(r+x, 2);      %Error between input and received bits
    error=error+sum(E); %Count any error found
end
BER(ENR+1)=500/bits;    %Calculation of BER
ENR=ENR+1;              %ENR increased by 1 for calculation of next BER
end

ENR=0:10;         %range of ENR at which BER is found
plot(ENR, BER, 'c')   %plot of BER Vs ENR with default blue color

