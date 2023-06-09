G=[ 1 0 0 0 1 0 1 1 1 0 0 0 0 0 0 ;     % Defining G Matrix
    0 1 0 0 0 1 0 1 1 1 0 0 0 0 0 ;
    0 0 1 0 0 0 1 0 1 1 1 0 0 0 0 ;
    0 0 0 1 0 0 0 1 0 1 1 1 0 0 0 ;
    0 0 0 0 1 0 0 0 1 0 1 1 1 0 0 ;
    0 0 0 0 0 1 0 0 0 1 0 1 1 1 0 ;
    0 0 0 0 0 0 1 0 0 0 1 0 1 1 1 ];

H=[ 0 0 1 0 0 1 0 1 1 1 1 1 1 0 0 ;     % Defining H Matrix
    0 0 0 1 0 0 1 0 1 1 1 1 1 1 0 ;
    0 0 0 0 1 0 0 1 0 1 1 1 1 1 1 ;
    1 0 0 0 0 1 0 0 1 0 1 1 1 1 1 ;
    1 1 0 0 0 0 1 0 0 1 0 1 1 1 1 ;
    1 1 1 0 0 0 0 1 0 0 1 0 1 1 1 ;
    1 1 1 1 0 0 0 0 1 0 0 1 0 1 1 ; 
    1 1 1 1 1 0 0 0 0 1 0 0 1 0 1 ];
    

H=H';                   % Taking transpose of H
A=G*H;                  % The product of G and H transposed
A=mod(A, 2);            % Limiting the result to binary numbers
    