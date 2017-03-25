function [bestH] = ransacH(matches, locs1, locs2, nIter, tol)
% INPUTS
% locs1 and locs2 - matrices specifying point locations in each of the images
% matches - matrix specifying matches between these two sets of point locations
% nIter - number of iterations to run RANSAC
% tol - tolerance value for considering a point to be an inlier
%
% OUTPUTS
% bestH - homography model with the most inliers found during RANSAC


p1 = locs1(matches(:,1),1:2)';
p2 = locs2(matches(:,2),1:2)';
numMatches = size(p1,2);

bestH = zeros(3,3);
bestIn = 0

for i=1:nIter

    Matches = randperm(numMatches, 4);
    H = computeH(p1(:,Matches), p2(:,Matches));
   
    %keyboard;
    
    p1Warp = H * [p2;ones(1,numMatches)];
    
    lastElement = p1Warp(3,:);
 
    values = [1;1;1]*lastElement;
    
    p1Warp = p1Warp ./ values;
    
    error = sqrt(sum(abs(p1-p1Warp(1:2,:)).^2,1)) / numMatches;
    
    if length(find(error<tol)) > bestIn
        bestIn = length(find(error<tol));
        bestH = H;
    end
    
end
