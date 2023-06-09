S1(1)=0.046+0.046i;
S1(2)=-0.132+0.002i;
S1(3)=-0.013-0.079i;
S1(4)=0.143-0.013i;
S1(5)=0.092+0.000i;
S1(6)=0.143-0.013i;
S1(7)=-0.013-0.079i;
S1(8)=-0.132+0.002i;
S1(9)=0.046+0.046i;
S1(10)=0.002-0.132i;
S1(11)=-0.079-0.013i;
S1(12)=-0.013+0.143i;
S1(13)=0.000+0.092i;
S1(14)=-0.013+0.143i;
S1(15)=-0.079-0.013i;
S1(16)=0.002-0.132i;
Short=[S1 S1 S1 S1];
Short_S=[Short Short Short(1:33)];
W=[0.5 ones(1, 159) 0.5];
S=W.*Short_S;

L1=[0 0 0 0 0 0 1 1 -1 -1 1 1 -1 1 -1 1];
L2=[1 1 1 1 1 -1 -1 1 1 -1 1 -1 1 1 1 1];
L3=[0 1 -1 -1 1 1 -1 1 -1 1 -1 -1 -1 -1 -1 1];
L4=[1 -1 -1 1 -1 1 -1 1 1 1 1 0 0 0 0 0];
L=[L1 L2 L3 L4];
Long=ifftshift(ifft(L));
W=[0.5 ones(1, 159) 0.5];
Long_S=[Long Long Long(1:33)];
Long_Sequence=W.*Long_S;

Preamble=[S(1:160) S(161)+Long_Sequence(1) Long_Sequence(2:161)];

ENR=20;
std=sqrt(0.5)/sqrt(10^(ENR/10));
K=zeros(1, 160);
for m=1:100
    Wc=Rayleigh(0.001, 25, 100);
    P=conv(Preamble, Wc);
    N=std*randn(1,length(P));
    P=P+N;
    for d=1:160
        A1(d)=sum(P(d:d+15).*conj(P(d+16:d+31)));
        A2(d)=sum(P(d:d+15).*conj(P(d+32:d+47)));
        B(d)=sum((abs(P(d:d+15))).^2);
        M1(d)=A1(d)/B(d);
        M2(d)=A2(d)/B(d);
    end
    M=abs(M1-M2);
    [G, H]=max(M);
    K(H)=K(H)+1;
end
N=[1:160];
K=K/100;
plot(N, K)





