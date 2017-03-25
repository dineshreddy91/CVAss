function locsDoG = getLocalExtrema(DoGPyramid, DoGLevels, ...
                        PrincipalCurvature, th_contrast, th_r)
%%Detecting Extrema
% INPUTS
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
% DoG Levels  - The levels of the pyramid where the blur at each level is
%               outputs
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix contains the
%                      curvature ratio R
% th_contrast - remove any point that is a local extremum but does not have a
%               DoG response magnitude above this threshold
% th_r        - remove any edge-like points that have too large a principal
%               curvature ratio
%
% OUTPUTS
% locsDoG - N x 3 matrix where the DoG pyramid achieves a local extrema in both
%           scale and space, and also satisfies the two thresholds.


indices = find((abs(DoGPyramid)>th_contrast)&(PrincipalCurvature<th_r)&(PrincipalCurvature>0));

[y,x,z] = ind2sub(size(DoGPyramid),indices);

locsDoG = zeros(size(indices,1),3);

count = 1;

for i = 1:size(indices,1)

    % works better withour points from the first and last layer 
    if z(i) == 1 || z(i) == size(DoGPyramid,3)
      if x(i) < size(DoGPyramid,2) && x(i) > 1 && y(i) < size(DoGPyramid,1) && y(i) > 1 
       patch = DoGPyramid(y(i)-1:y(i)+1,x(i)-1:x(i)+1,z(i));
       DoGVector = DoGPyramid(y(i),x(i),1:2);

       if ( patch(2,2) == max(patch(:)) || patch(2,2) == min(patch(:)))
                %locsDoG(count,:) = [x(i),y(i),z(i)]; 
                %count = count + 1;
           
       end
       
      end
    continue;  
    end
    
    %  local for the middle layers
    if x(i) < size(DoGPyramid,2) && x(i) > 1 && y(i) < size(DoGPyramid,1) && y(i) > 1 
       patch = DoGPyramid(y(i)-1:y(i)+1,x(i)-1:x(i)+1,z(i));
       DoGVector = DoGPyramid(y(i),x(i),z(i)-1:z(i)+1);

       if ( patch(2,2) == max(patch(:)) || patch(2,2) == min(patch(:)))
           if (DoGVector(2) >= max(DoGVector(1),DoGVector(3)) || DoGVector(2) <= min(DoGVector(1),DoGVector(3)))
                locsDoG(count,:) = [x(i),y(i),z(i)]; 
                count = count + 1;
           end
           
       end
    end
end

locsDoG = locsDoG(1:count-1,:);
