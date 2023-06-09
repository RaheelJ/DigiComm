clear
clc

Pt=0.001;
Ts=12.5;
n=1;
P(1)=1;

while(P(n)>Pt)
    P(n+1)=exp(-n*Ts/50);
    n=n+1;
end
X=sum(P);
Pn=P./X;
var=Pn./2;
std=sqrt(var);
Pa=zeros(1, length(P));
s=0;

while (s<=5000)
   N=std.*randn(1, length(P));
   M=std.*randn(1, length(P));
   Wc=N+M*1j;
   Pa=Pa+Wc.*conj(Wc);
   s=s+1;
end

Pa=Pa./s;
Pa=Pa./max(Pa);
stem([0:length(P)-1], Pa)
  

  
   