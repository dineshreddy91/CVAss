[~, grad] = f(x);
d = zeros(length(x),1);
epsilon = 1e-4;
fd = zeros(length(x),1);
for i=1:length(x)
    d(i) = epsilon;
    fd(i) = (f(x+d) - f(x-d))/(2*epsilon);
    d(i) = 0;
end
norm(grad - fd)/norm(grad + fd)
fprintf('this value should be small\n');