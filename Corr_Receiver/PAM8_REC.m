ENR=0;

while (ENR<=10)             %BER is to plotted for 11 values of ENR
    error=0;                %initial count of errors 
    bits=0;                 %initial count of bits transmitted
 while (error<500)          %BER calculated when 500 errors are obtained
    x=rand(1, 3);           %3 bits uniformly generated
    x=round(x);

    if x==[0 0 0]           %Bit mapping to 1 of 8 waveforms
        s=[7]; end
    if x==[0 0 1]
        s=[5]; end
    if x==[0 1 1]
        s=[3]; end
    if x==[0 1 0]
        s=[1]; end
    if x==[1 1 0] 
        s=[-1]; end
    if x==[1 0 0]
        s=[-3]; end
    if x==[1 0 1]
        s=[-5]; end
    if x==[1 1 1]
        s=[-7]; end


    Std=sqrt(3.5)/sqrt(10^(ENR/10));    %Std of AWGN
    N=Std.*randn(1, 1);                 %1 sample of Gaussian Noise with mean=0 and Std
    Rec=s+N;                            %Received bits with effect of noise
    
    R=intdump(Rec, 1);                  %integrate and dump for 1 sample of waveform
    
    i=1;
    for n=7:-2:-7               
        Correlation(i)=(R*n)-(0.5*(abs(n)^2));  %Implementation of correlation receiver
        i=i+1;
    end
    
    [Rx, n]=max(Correlation);           
    
   
    if n==1                     %Pick m for which correlation is maximum
        r=[0 0 0]; end
    if n==2
        r=[0 0 1]; end
    if n==3
        r=[0 1 1];end
    if n==4
        r=[0 1 0]; end
    
    if n==5 
        r=[1 1 0]; end
    if n==6
        r=[1 0 0]; end
    if n==7
        r=[1 0 1];end
    if n==8
        r=[1 1 1]; end
    
    bits=bits+3;                %Count the bits transmitted just now
    E=mod(r+x, 2);              %Error between input and received bits
    error=error+sum(E);         %count of errors
 end
    BER(ENR+1)=500/bits;    %Calculation of BER
    ENR=ENR+1; %ENR increased by 1 for calculation of next BER
end

ENR=0:10;             %range of ENR at which BER is found
plot(ENR, BER, 'r')   %plot of BER Vs ENR with default blue color
  

