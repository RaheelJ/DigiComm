function [y] = cirshift(x,m,N)
x = [x zeros(1,length(x))];
n= 0:1:N-1;
n = mod(n-m , N);
y = x(n+1);