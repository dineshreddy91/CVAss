function [ x2, y2 ] = epipolarCorrespondence( im1, im2, F, x1, y1 )
% epipolarCorrespondence:
%       im1 - Image 1
%       im2 - Image 2
%       F - Fundamental Matrix between im1 and im2
%       x1 - x coord in image 1
%       y1 - y coord in image 1

% Q2.6 - Todo:
%           Implement a method to compute (x2,y2) given (x1,y1)
%           Use F to only scan along the epipolar line
%           Experiment with different window sizes or weighting schemes
%           Save F, pts1, and pts2 used to generate view to q2_6.mat
%
%           Explain your methods and optimization in your writeup

points1 = [x1;y1;1];
l = F * points1;

l = l/(norm(l(1:2)));

window = 32;

h=fspecial('gaussian',[5 5], 3);

search_range = 30;

y_range = y1-search_range:1:y1 + search_range;
x_range = round(-(l(2)*y_range(:) + l(3))/l(1));
Finalx = 0;
Finaly = 0;
error = inf;
template = imfilter(im1(y1-window/2:y1+window/2,x1-window/2:x1+window/2),h);
for i = 1:size(x_range,1)
    if (y_range(i) - window < 1 || y_range(i) + window > size(im1,1) || x_range(i) - window < 1 || y_range(i) + window > size(im1,2)) 
        continue
    else
        checkWindow = im2(y_range(i)-window/2:y_range(i)+window/2,x_range(i)-window/2:x_range(i)+window/2);
        checkWindow = imfilter(checkWindow, h);
        dist = sum((template(:) - checkWindow(:)).^2);
        if(dist<error)
            Finalx = x_range(i);
            Finaly = y_range(i);
            error = dist;
        end
    end
        
        
end
x2 = Finalx;
y2 = Finaly;

end

