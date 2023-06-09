function [y, m]=sigshift(x, n, M, N)
subplot(3,1,1),
stem(n , x),
grid
x_new = [x(1) zeros(1 ,N-1) ];
for i = 2:1:(length(x))
    
    x_new = [x_new x(i) zeros(1 ,N-1) ];
end

index = [1:1:length(x_new)]-1 + M;
subplot(3,1,2),
stem(index , x_new)
grid minor
x_newly = x_new(1);
for i = 1:1:length(x_new)
    if x_new(i) ~= 0
    x_newly = [x_newly x_new(i)];
    end
end

subplot(3,1,3),
stem([1:1:length(x_newly)]-1 + (M/N) , x_newly)
grid minor
