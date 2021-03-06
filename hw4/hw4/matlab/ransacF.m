function [ F ] = ransacF( pts1, pts2, M )
% ransacF:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.X - Extra Credit:
%     Implement RANSAC
%     Generate a matrix F from some '../data/some_corresp_noisy.mat'
%          - using sevenpoint
%          - using ransac

%     In your writeup, describe your algorithm, how you determined which
%     points are inliers, and any other optimizations you made
nIter = 100;
bestF = zeros(3,3);
bestIn = 0;

for i=1:nIter

    Matches = randperm(size(pts1,1), 8);
    F_fit = eightpoint(pts1(Matches,:), pts2(Matches,:),M);
   
    %keyboard;
    inlier = 0;
    for j = 1 :size(pts1,1)
        l = F_fit * [pts1(j,:),1]';
        l = l/(norm(l(1:2)));
        dist = abs(dot([pts2(j,:),1]',l)/norm(l(1:2)));
        if dist < 1
            %keyboard;
            inlier =inlier+1;
        end
    end
    if inlier > bestIn
        bestIn = inlier
        bestF = F_fit
    end
end
F = bestF;
end

