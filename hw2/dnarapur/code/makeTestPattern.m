function [compareA, compareB] = makeTestPattern(patchWidth, nbits) 
%%Creates Test Pattern for BRIEF
%
% Run this routine for the given parameters patchWidth = 9 and n = 256 and
% save the results in testPattern.mat.
%
% INPUTS
% patchWidth - the width of the image patch (usually 9)
% nbits      - the number of tests n in the BRIEF descriptor
%
% OUTPUTS
% compareA and compareB - LINEAR indices into the patchWidth x patchWidth image 
%                         patch and are each nbits x 1 vectors. 


mu = 4.5;

sigma = 1.8;

sample = round(normrnd(mu, sigma, [nbits, 4]));

sample = max(sample, 1);

sample = min(sample, patchWidth);

compareA = sub2ind([patchWidth, patchWidth], sample(:,1), sample(:,2));

compareB = sub2ind([patchWidth, patchWidth], sample(:,3), sample(:,4));

save('testPattern.mat', 'compareA', 'compareB');
