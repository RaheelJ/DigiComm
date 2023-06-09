
ENR=0;

while (ENR<=10)
    symbol=0;
    symbol_error=0;
    error=0;
    bits=0;
 while (error<500)
    x=rand(1, 3);
    x=round(x);

    if x==[0 0 0] 
    s=[7 7]; end
    if x==[0 0 1]
    s=[5 5]; end
    if x==[0 1 1]
    s=[3 3]; end
    if x==[0 1 0]
    s=[1 1]; end
    if x==[1 1 0] 
    s=[-1 -1]; end
    if x==[1 0 0]
    s=[-3 -3]; end
    if x==[1 0 1]
    s=[-5 -5]; end
    if x==[1 1 1]
    s=[-7 -7]; end


    Std=sqrt(3.5)/sqrt(10^(ENR/10));    %Std of AWGN
    N=Std.*randn(1, 2); %5 sample of Gaussian Noise with mean=0 and Std
    R=s+N;              %Received bits with effect of noise
    
    count111=0;
    count010=0;
    count101=0;
    count000=0;
    count001=0;
    count011=0;
    count110=0;
    count100=0;
    
    for i=1:2
        if (R(i)<0 && R(i)>-2)       %Hard decision to identify the received bits
            R(i)=-1;
            count110=count110+1 ;end
        if (R(i)<-2 && R(i)>-4)
            R(i)=-3;
            count100=count100+1;
        end
        if (R(i)>2 && R(i)<4)
            R(i)=3;
            count011=count011+1;
        end
        if (R(i)>0 && R(i)<2)
            R(i)=1;
            count010=count010+1;
        end
        
        if (R(i)<-4 && R(i)>-6)       %Hard decision to identify the received bits
            R(i)=-5;
            count101=count101+1 ;end
        if (R(i)<-6)
            R(i)=-7;
            count111=count111+1;
        end
        if (R(i)>4 && R(i)<6)
            R(i)=5;
            count001=count001+1;
        end
        if (R(i)>6)
            R(i)=7;
            count000=count000+1;
        end
    end
    
    count=[count000 count001 count010 count011 count100 count101 count110 count111];
    [m, n]=max(count);
    
    if n==1 
        r=[0 0 0]; end
    if n==2
        r=[0 0 1]; end
    if n==3
        r=[0 1 0];end
    if n==4
        r=[0 1 1]; end
    
    if n==5 
        r=[1 0 0]; end
    if n==6
        r=[1 0 1]; end
    if n==7
        r=[1 1 0];end
    if n==8
        r=[1 1 1]; end
    
    bits=bits+3; %Count the bits transmitted just now
    symbol=symbol+1;
    E=mod(r+x, 2); %Error between input and received bits
    if(sum(E)~=0)
        symbol_error=symbol_error+1;
    end
    error=error+sum(E);
 end
    BER(ENR+1)=500/bits;    %Calculation of BER
    SER(ENR+1)=symbol_error/symbol;
    ENR=ENR+1; %ENR increased by 1 for calculation of next BER

end

ENR=0:10;         %range of ENR at which BER is found
hold on
plot(ENR, BER, 'r')   %plot of BER Vs ENR with default blue color
  

