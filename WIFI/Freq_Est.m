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
Short_Sequence=W.*Short_S;

k=1:161;
F=0.2*0.05;
n=2*pi*F.*k;
phase=exp(1j*n);
P=Short_Sequence.*phase;
freq=zeros(1,400);

for a=113:128
offset=angle(conj(P(a))*(P(a+16)));
offset=offset/(32*pi*0.00000005);
if (offset~=0)
freq(round(offset/1000))=freq(round(offset/1000))+1;
end
end

stem([1:400], freq)

