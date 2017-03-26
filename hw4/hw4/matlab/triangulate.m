function [ P, error ] = triangulate( C1, p1, C2, p2 )
% triangulate:
%       C1 - 3x4 Camera Matrix 1
%       p1 - Nx2 set of points
%       C2 - 3x4 Camera Matrix 2
%       p2 - Nx2 set of points

% Q2.4 - Todo:
%       Implement a triangulation algorithm to compute the 3d locations
%

n=size(p1,1);
P=zeros(4,n);
for i=1:n
  x=[0 1 -p1(i,2);-1 0 p1(i,1);p1(i,2) -p1(i,1) 0];
  y=[0 1 -p2(i,2);-1 0 p2(i,1);p2(i,2) -p2(i,1) 0];
  A = [x*C1; y*C2];
  [~,~,va] = svd(A);
  point3D = va(:,4);
  P(:,i) = point3D/point3D(4);
end

p1_new = C1*P;
p2_new = C2*P;


error = sum(sum((p1' - p1_new(1:2,:)).^2 + (p2' - p2_new(1:2,:)).^2,1));
P = P(1:3,:);
end

