ENR=0;

while (ENR<=10)
    symbol_error=0;
    symbol=0;
    error=0;
    bits=0;
 while (error<500)
    x=rand(1, 2);
    x=round(x);

    if x==[0 0] 
    s=[3 3]; end
    if x==[1 0]
    s=[1 1]; end
    if x==[1 1]
    s=[-1 -1]; end
    if x==[0 1]
    s=[-3 -3]; end

    Std=sqrt(1.25)/sqrt(10^(ENR/10));    %Std of AWGN
    N=Std.*randn(1, 2); %5 sample of Gaussian Noise with mean=0 and Std
    R=s+N;              %Received bits with effect of noise
    
    count11=0;
    count01=0;
    count10=0;
    count00=0;
    
    for i=1:2
        if (R(i)<0 && R(i)>-2)       %Hard decision to identify the received bits
            R(i)=-1;
            count11=count11+1 ;end
        if (R(i)<-2)
            R(i)=-3;
            count01=count01+1;
        end
        if (R(i)>2)
            R(i)=3;
            count00=count00+1;
        end
        if (R(i)>0 && R(i)<2)
            R(i)=1;
            count10=count10+1;
        end
    end
    
    count=[count00 count01 count10 count11];
    [m, n]=max(count);
    
    if n==4 
        r=[1 1]; end
    if n==2
        r=[0 1]; end
    if n==1
        r=[0 0];end
    if n==3
        r=[1 0]; end
    symbol=symbol+1;
    bits=bits+2;    %Count the bits transmitted just now
    
    E=mod(r+x, 2);      %Error between input and received bits
    if(sum(E)~=0)
        symbol_error=symbol_error+1;
    end
    error=error+sum(E);
 end
    BER(ENR+1)=500/bits;    %Calculation of BER
    SER(ENR+1)=symbol_error/symbol;
    ENR=ENR+1;              %ENR increased by 1 for calculation of next BER

end

ENR=0:10;         %range of ENR at which BER is found
hold on
plot(ENR, BER, 'b')   %plot of BER Vs ENR with default blue color

    

