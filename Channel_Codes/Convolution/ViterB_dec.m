g1=[1 0 1 1 0 1 1];             %Generator Polynomial
g2=[1 1 1 1 0 0 1];
Code_Gen=[133 171];             %Generaor Matrix
N=8190;                         %Packet length                             
M=N*2;                          %coded packet length
ENR=0 ;
trellis=poly2trellis(7,Code_Gen);   %Trellis
ENR=0;
while(ENR<7)
    error=0;
    bits=0;
    while(error<500)
        msg=round(rand(1, N));
        code = convenc(msg,trellis);    %Coded signal        
        for i=1:M                   
                if code(i)==0             
                    T(i)=-1;            % 0 --> -1    
                else
                    T(i)=1;             % 1 --> 1
                end
        end
        Std=1/sqrt(10^(ENR/10));    %Std of AWGN
        Nx=Std.*randn(1, M);         %samples of Gaussian Noise with mean=0 and Std
        R=T+Nx;                      %Received bits with effect of noise
        for i=1:M
            if R(i)>0       %Hard decision to identify the received bits
                R(i)=1;
            else 
                R(i)=0;
            end
        end
        [decoded] = vitdec(R,trellis,96,'trunc','hard');
        error=error+sum(mod(msg+decoded, 2));
        bits=bits+8192;
    end
    BER(ENR+1)=error/bits;
    ENR=ENR+1;
end
ENR=[0:6];
hold on
plot(ENR, BER, 'k')

    
    



