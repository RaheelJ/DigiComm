x=[1 1/2 -1/2 -1 -1/2 1/2 1];
y=[0 sqrt(3)/2 sqrt(3)/2 0 -sqrt(3)/2 -sqrt(3)/2 0];

O=sqrt(3)*exp(1j*pi/6);
for i=1:6
    a=real(O);
    b=imag(O);
    X=a+x;
    Y=b+y;
    line(X, Y)
    O=O*exp(1j*pi/3);
end

O=2*sqrt(3)*exp(1j*pi/6);
P=O+sqrt(3)*exp(1j*pi/6);
Q=P+sqrt(3)*exp(1j*pi/6);
S=Q+sqrt(3)*exp(1j*pi/6);
T=S+sqrt(3)*exp(1j*pi/6);

for i=1:6
    for j=1:6
        for k=1:6
            for l=1:6
                for m=1:6
                    a=real(T);
                    b=imag(T);
                    X=a+x;
                    Y=b+y;
                    line(X, Y)
                    T=(T-S)*exp(1j*pi/3)+S;
                end                    
                a=real(S);
                b=imag(S);
                X=a+x;
                Y=b+y;
                line(X, Y)
                S=(S-Q)*exp(1j*pi/3)+Q;
                T=S+sqrt(3)*exp(1j*pi/6);
            end
            a=real(Q);
            b=imag(Q);
            X=a+x;
            Y=b+y;
            line(X, Y)
            Q=(Q-P)*exp(1j*pi/3)+P;
            S=Q+sqrt(3)*exp(1j*pi/6);
            T=S+sqrt(3)*exp(1j*pi/6);
        end
        a=real(P);
        b=imag(P);
        X=a+x;
        Y=b+y;
        line(X, Y)
        P=(P-O)*exp(1j*pi/3)+O;
        Q=P+sqrt(3)*exp(1j*pi/6);
        S=Q+sqrt(3)*exp(1j*pi/6);
        T=S+sqrt(3)*exp(1j*pi/6);
    end
    O=O*exp(1j*pi/3);
    P=O+sqrt(3)*exp(1j*pi/6);
    Q=P+sqrt(3)*exp(1j*pi/6);
    S=Q+sqrt(3)*exp(1j*pi/6);
    T=S+sqrt(3)*exp(1j*pi/6);
end



