hold on
a=1;
b=1;

Nc=sqrt(a^2 + b^2 + a*b);

P(1)=sqrt(3)*exp(1j*pi/6)+sqrt(3)*exp(1j*pi/2);

for i=2:6
    P(i)=P(i-1)*exp(1j*pi/3);
end

for j=1:6
    Q(1)=P(j)+sqrt(3)*exp(1j*pi/6)+sqrt(3)*exp(1j*pi/2);
    for k=2:6
        Q(k)=Q(k-1)*exp(1j*pi/3);
    end
    plot(real(Q), imag(Q), 'rx')
    hold on
end

plot(0,0,'ro')
hold on

plot(real(P), imag(P), 'r*')