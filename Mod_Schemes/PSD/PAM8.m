x=rand(1, 1002);
x=round(x);
j=0;

for i=1:3:1000

    if x(i:i+2)==[0 0 0] 
    s((1:10)+10*j)=[7*ones(1, 10)]; end
    if x(i:i+2)==[0 0 1]
    s((1:10)+10*j)=[5*ones(1, 10)]; end
    if x(i:i+2)==[0 1 1]
    s((1:10)+10*j)=[3*ones(1, 10)]; end
    if x(i:i+2)==[0 1 0]
    s((1:10)+10*j)=[1*ones(1, 10)]; end
    if x(i:i+2)==[1 1 0] 
    s((1:10)+10*j)=[-1*ones(1, 10)]; end
    if x(i:i+2)==[1 0 0]
    s((1:10)+10*j)=[-3*ones(1, 10)]; end
    if x(i:i+2)==[1 0 1]
    s((1:10)+10*j)=[-5*ones(1, 10)]; end
    if x(i:i+2)==[1 1 1]
    s((1:10)+10*j)=[-7*ones(1, 10)]; end

    j=j+1;

end

h=rcosine(3006, 15030);
y=conv(s, h);
m=0:length(s)-1;
n=0:length(y)-1;
o=0:length(h)-1;
stem(o, h)
pause
stem(m, s)
pause
stem(n, y)

X=fftshift(fft(s, 8001));
n1=-[4000:-1:1]./4000;
n2=[1:4000]./4000;
N=[n1 0 n2];
Y=fftshift(fft(y, 8001));
H=fftshift(fft(h, 8001));
pause
stem(N, abs(H))
pause
stem(N, abs(X))
pause
stem(N, abs(Y))

PSD_X=X.*conj(X);
PSD_Y=Y.*conj(Y);
pause
stem(N, PSD_X)
pause
stem(N, PSD_Y)
   