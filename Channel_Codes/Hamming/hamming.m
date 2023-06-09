hold on             
ENR=0;                  %initially Eb/No =0
G=[ 0 1 1 1 0 0 0;      %Generator matrix systematic hamming code (7, 4)
    1 0 1 0 1 0 0;
    1 1 0 0 0 1 0;
    1 1 1 0 0 0 1 ];

H=[ 1 0 0 0 1 1 1;      %H matrix found from G matrix
    0 1 0 1 0 1 1;
    0 0 1 1 1 0 1 ];
while (ENR<=8)          %Plotting BER for 9 values of ENR
bits=0;                 %Count of bits for which the error reaches 500 
error=0;                %Count of errors till they reach 500
while (error<500)
    x=rand(1, 4);       %4 input bits generated uniformly
    x=round(x);
    T=mod(x*G, 2);      %Input coded with hamming code (7, 4)
    for i=1:7
        if T(i)==0      %Mapping of bits
            T(i)=-1;    % 0 --> -1
        else
            T(i)=1;     % 1 --> 1
        end
    end
    Std=0.935/sqrt(10^(ENR/10));    %St. deviation of AWGN
    N=Std.*randn(1, 7);     %4 samples of AWGN with mean=0 and Std
    R=T+N;                  %Received signal effected with noise
    for i=1:7
        if R(i)>0           %Hard decision to receive the identified bitsS
            R(i)=1;
        else 
            R(i)=0;
        end
    end
    S=mod(R*H', 2);         %Sydrome vector calculation 
                            %and error determination
        if S==[0 0 0]
            E=[0 0 0 0 0 0 0]; end
        if S==[1 1 1]
            E=[0 0 0 0 0 0 1]; end
        if S==[1 1 0]
            E=[0 0 0 0 0 1 0]; end 
        if S==[1 0 1]
            E=[0 0 0 0 1 0 0]; end
        if S==[0 1 1]
            E=[0 0 0 1 0 0 0]; end
        if S==[0 0 1]
            E=[0 0 1 0 0 0 0]; end
        if S==[0 1 0]
            E=[0 1 0 0 0 0 0]; end
        if S==[1 0 0]
            E=[1 0 0 0 0 0 0]; end
        
    R=R+E;              %Error correction
    R=mod(R, 2);        
    D=[R(4) R(5) R(6) R(7)];    %Extracting the detected source bits
    bits=bits+4;                %Count the bits just transmitted
    F=mod(D+x, 2);              %Error b/w input and detected source bits
    error=error+sum(F);         %Count if any error occured
end
BER(ENR+1)=500/bits;            %Calculation of BER
ENR=ENR+1;       %ENR increased for next calculation of BER               
end
ENR=0:8;        %Range of ENR for which BER calculations are made
plot(ENR, BER, 'r')         %Plot BER Vs ENR in red color
