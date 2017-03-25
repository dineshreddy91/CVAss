function H2to1 = computeH(p1,p2)
% INPUTS:
% p1 and p2 - Each are size (2 x N) matrices of corresponding (x, y)'  
%             coordinates between two images
%
% OUTPUTS:
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear 
%         equation
    
n = size(p2, 2);
x = p1(1, :);
y = p1(2,:);
X = p2(1,:);
Y = p2(2,:);

XY = -[X; Y; ones(1,n)];

hx = [XY; zeros(3, n); x.*X; x.*Y; x];
hy = [zeros(3, n); XY; y.*X; y.*Y; y];

[U, ~, ~] = svd([hx hy]);

H2to1 = (reshape(U(:,9), 3, 3)).';

