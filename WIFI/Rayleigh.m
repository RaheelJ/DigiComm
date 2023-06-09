function[Wc] =Rayleigh(Pt, Ts, RMS_DS) 
n=1;                    
P(1)=1;                 
while(P(n)>Pt)
    P(n+1)=exp(-n*Ts/RMS_DS);
    n=n+1;
end
X=sum(P);               %Normalization factor
Pn=P./X;                %Normalized power
var=Pn./2;              %Variance of AWGN
std=sqrt(var);          %Std Deviation of AWGN
Pa=zeros(1, length(P));     
N=std.*randn(1, length(std));        
M=std.*randn(1, length(std));
Wc=N+M*1j;           %Rayleigh Channel as sum of 2 AWGN

end

  
   