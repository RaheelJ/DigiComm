ENR=0;                          %initially value of Eb/No
while (ENR<=10)                  %plot for 9 values of ENR
bits=0;                         %count of bits for which error is 500
error=0;                        %count of errors till they reaches 500
while (error<300)               %500 errors before calculting BER
    x=rand(1, 1);               %4 input bits uniformly generated
    x=round(x);                 
    T=x;                        %T is to be mapped and transmitted
    for i=1                   
        if T(i)==0             
            T(i)=-1;            % 0 --> -1    
        else
            T(i)=1;             % 1 --> 1
        end
    end
    Std=0.707/sqrt(10^(ENR/10));    %Std of AWGN
    N=Std.*randn(1, 1); %4 sample of Gaussian Noise with mean=0 and Std
    R=T+N;              %Received bits with effect of noise
    for i=1
        if R(i)>0       %Hard decision to identify the received bits
            R(i)=1;
        else 
            R(i)=0;
        end
    end
    bits=bits+1;        %Count the bits transmitted just now
    E=mod(R+x, 2);      %Error between input and received bits
    error=error+E; %Count any error found
end
BER(ENR+1)=300/bits;    %Calculation of BER
ENR=ENR+1;              %ENR increased by 1 for calculation of next BER
end
ENR=0:10;         %range of ENR at which BER is found
hold off
plot(ENR, BER, 'k')   %plot of BER Vs ENR with default blue color
