ENR=0;                          %initially value of Eb/No
trans=[3+3j 1+3j -1+3j -3+3j 3+1j 1+1j -1+1j -3+1j 3-1j 1-1j -1-1j -3-1j 3-3j 1-3j -1-3j -3-3j]; %Matrix of Symbols
Matrix=[0 0 0 0; 0 0 0 1; 0 0 1 1; 0 0 1 0; 0 1 0 0; 0 1 0 1; 0 1 1 1; 0 1 1 0; 1 1 0 0; 1 1 0 1; 1 1 1 1; 1 1 1 0; 1 0 0 0; 1 0 0 1; 1 0 1 1; 1 0 1 0]; %Matrix of possible bit combinations

while (ENR<=10)                 %plot for 11 values of ENR
bits=0;                         %count of bits for which error is 500
error=0;                        %count of errors till they reaches 500
while (error<500)               %500 errors before calculting BER
    x=rand(1, 4);               %4 input bits uniformly generated
    x=round(x);                 
                                
    if x==[0 0 0 0]             %Mapping of x to one of 16 possible waveforms
        T=3+3j;                 %Complex representation used to represent 2 orthogonal waveforms
    end
    if x==[0 0 0 1]
        T=1+3j;
    end
    if x==[0 0 1 1]
        T=-1+3j;
    end
    if x==[0 0 1 0]
        T=-3+3j;
    end
    if x==[0 1 0 0]
        T=3+1j;
    end
    if x==[0 1 0 1]
        T=1+1j;
    end
    if x==[0 1 1 1]
        T=-1+1j;
    end
    if x==[0 1 1 0]
        T=-3+1j;
    end
    if x==[1 1 0 0]
        T=3-1j;
    end
    if x==[1 1 0 1]
        T=1-1j;
    end
    if x==[1 1 1 1]
        T=-1-1j;
    end
    if x==[1 1 1 0]
        T=-3-1j;
    end
    if x==[1 0 0 0]
        T=3-3j;
    end
    if x==[1 0 0 1]
        T=1-3j;
    end
    if x==[1 0 1 1]
        T=-1-3j;
    end
    if x==[1 0 1 0]
        T=-3-3j;
    end

    Std=sqrt(1.25)/sqrt(10^(ENR/10));    %Std of AWGN
    N=Std.*randn(1, 1);              %1 sample of Gaussian Noise with mean=0 and Std for I component
    M=Std.*randn(1, 1);              % for Q component
    Rec=T+M+N*1j;               %Received waveform with effect of noise
    
    R=intdump(Rec, 1);      %Integrate and dump with one sample of waveform
    
    for n=1:16
        Correlation(n)=(real(R)*real(trans(n))+imag(R)*imag(trans(n)))-(0.5*(abs(trans(n))^2)); %Correlation receiver implementation
    end
    
    [Rx, n]=max(Correlation);               
    r=Matrix(n, :);                 %Pick m for which correlation is maximum
    
    bits=bits+4;        %Count the bits transmitted just now
    E=mod(r+x, 2);      %Error between input and received bits
    error=error+sum(E); %Count any error found
end
BER(ENR+1)=500/bits;    %Calculation of BER
ENR=ENR+1;              %ENR increased by 1 for calculation of next BER
end
ENR=0:10;               %range of ENR at which BER is found
plot(ENR, BER, 'b')     %plot of BER Vs ENR with default blue color

