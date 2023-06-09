Sig=[1 0 1 1 zeros(1, 3) 1 0 0 1 1 zeros(1, 12)];

Code_Gen=[133 171];
trellis=poly2trellis(7,Code_Gen);
code = convenc(Sig,trellis);

N=48;
k=0:N-1;
s=1;
i=(N/16).*mod(k, 16)+floor(k/16);
j=(s.*floor(i./s))+(mod((i+N-floor(i.*(16/N))), s));

signal(j+1)=code(k+1);


for n=1:48
    if signal(n)==1
        signal(n)=1;
    else
        signal(n)=-1;
    end
end

SIG=[signal(1:5) 1 signal(6:18) 1 signal(19:30) 1 signal(31:43) -1 signal(44:48)];
SIGNAL=[zeros(1, 6) SIG(1:26) 0 SIG(27:52) zeros(1, 5)];

S=ifft(SIGNAL);
S=[S(49:64) S(1:64) S(1)];
W=[0.5 ones(1, 79) 0.5];
Signal=W.*S;





    
