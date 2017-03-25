function PrincipalCurvature = computePrincipalCurvature(DoGPyramid)
%%Edge Suppression
% Takes in DoGPyramid generated in createDoGPyramid and returns
% PrincipalCurvature,a matrix of the same size where each point contains the
% curvature ratio R for the corre-sponding point in the DoG pyramid
%
% INPUTS
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
%
% OUTPUTS
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix where each 
%                      point contains the curvature ratio R for the 
%                      corresponding point in the DoG pyramid

PrincipalCurvature = zeros(size(DoGPyramid));

for loop=1:size(DoGPyramid,3)
    
    [GX, GY] = gradient(DoGPyramid(:,:,loop));
    
    [GXX, GXY] = gradient(GX);
    
    [GYX, GYY] = gradient(GY);
    
    tr_H = GXX + GYY;
    
    Det_H = (GXX.*GYY)-(GXY.*GYX);
    
    PrincipalCurvature(:,:,loop) = (tr_H.^2) ./ Det_H;
end
