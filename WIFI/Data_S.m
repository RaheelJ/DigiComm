X=zeros(1, 5001);                   %Initialization of variable for PSD

for n=1:1000
MESS=round(rand(1, 864));           %Random generation of msg


I=[1 0 1 1 1 0 1];                  %Seed for scrambling
for n=1:127
    B(n)=mod(I(7)+I(4), 2);         %Generation of scrambler sequence
    I=[B(n) I(1:6)];
end
SCR=[B B B B B B B(1:102)];         %Scrambler sequence 
M_SCR=mod(MESS+SCR, 2);             %Scrambled msg
M_SCR(817:822)=0;

punc=[1 1 1 0 0 1 1 1 1 0 0 1 1 1 1 0 0 1]; %Puncture pattern
Code_Gen=[133 171];                         %Generator matrix
trellis=poly2trellis(7,Code_Gen);           %Trellis
code = convenc(M_SCR,trellis,punc);         %3/4 rate coding

N=192;                                      %Interleaving
k=0:N-1;
M=4;
s=max(M/2, 1);
i=(N/16).*mod(k, 16)+floor(k/16);               
j=(s.*floor(i./s))+(mod((i+N-floor(i.*(16/N))), s));
for n=0:5
    D(j+1+n*192)=code(k+1+n*192);           %Interleaved message
end

m=1;
for l=0:5                                   %Mapping 16 QAM
    for n=(1+l*192):4:(189+l*192)
        if D(n:n+1)==[0 0]
                I=-3;
        end
        if D(n:n+1)==[0 1]
                I=-1;
        end
        if D(n:n+1)==[1 0]
                I=1;
        end
        if D(n:n+1)==[1 1]
                I=3;
        end
        if D(n+2:n+3)==[0 0]
                Q=-3;
        end
        if D(n+2:n+3)==[0 1]
                Q=-1;
        end
        if D(n+2:n+3)==[1 0]
                Q=1;
        end
        if D(n+2:n+3)==[1 1]
                Q=3;
        end
        DATA(m)=(I+1j*Q)*(1/sqrt(10));
        m=m+1;    
    end
    if (l==3 || l==4 || l==5)               %Pilot insertion and zero padding
        DATA(1+l*64:52+l*64)=[DATA(1+l*64:5+l*64) -1 DATA(6+l*64:18+l*64) -1 DATA(19+l*64:30+l*64) -1 DATA(31+l*64:43+l*64) 1 DATA(44+l*64:48+l*64)];
    else
        DATA(1+l*64:52+l*64)=[DATA(1+l*64:5+l*64) 1 DATA(6+l*64:18+l*64) 1 DATA(19+l*64:30+l*64) 1 DATA(31+l*64:43+l*64) -1 DATA(44+l*64:48+l*64)];
    end
    DATA(1+l*64:64+l*64)=[zeros(1, 6) DATA(1+l*64:26+l*64) 0 DATA(27+l*64:52+l*64) zeros(1, 5)];
    m=m+16;
end

DAT1=DATA(1:64);                            %Data symbols
DAT2=DATA(65:128);
DAT3=DATA(129:192);
DAT4=DATA(193:256);
DAT5=DATA(257:320);
DAT6=DATA(321:384);


D1=ifft(DAT1);                              %Symbols conversion to time domain and windowing
D1=[D1(49:64) D1(1:64) D1(1)];
W=[0.5 ones(1, 79) 0.5];
D1=W.*D1;

D2=ifft(DAT2);
D2=[D2(49:64) D2(1:64) D2(1)];
W=[0.5 ones(1, 79) 0.5];
D2=W.*D2;

D3=ifft(DAT3);
D3=[D3(49:64) D3(1:64) D3(1)];
W=[0.5 ones(1, 79) 0.5];
D3=W.*D3;

D4=ifft(DAT4);
D4=[D4(49:64) D4(1:64) D4(1)];
W=[0.5 ones(1, 79) 0.5];
D4_F=W.*D4;

D5=ifft(DAT5);
D5=[D5(49:64) D5(1:64) D5(1)];
W=[0.5 ones(1, 79) 0.5];
D5=W.*D5;

D6=ifft(DAT6);
D6=[D6(49:64) D6(1:64) D6(1)];
W=[0.5 ones(1, 79) 0.5];
D6=W.*D6;
                                         %Concatenation of data symbols
    DAT=[D1(1:80) D1(81)+D2(1) D2(2:80) D2(81)+D3(1) D3(2:80) D3(81)+D4(1) D4(2:80) D4(81)+D5(1) D5(2:80) D5(81)+D6(1) D6(2:81)];
    D=fft(D2, 5001);                     %Calculation and plot of PSD
    n1=-2*[2500:-1:1]./5000;
    n2=2*[1:2500]./5000;
    N=[n1 0 n2];
    X=X+abs(D).^2;
end
X=X./1000;
plot(N, X)
    

