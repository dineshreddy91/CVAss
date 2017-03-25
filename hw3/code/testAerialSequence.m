
% load frames


% implementation
clc;
clear all;
close all;
load('../data/aerialseq.mat');

[width,height,num] = size(frames);
segmented = zeros(width,height,num-1);

for i=1:num-1
    img = frames(:,:,i);
    img_next = frames(:,:,i+1);
    
    mask = SubtractDominantMotion(img,img_next);
    segmented(:,:,i) = mask;
    labelColor(:,:,1) = mask*255;
    labelColor(:,:,2) = mask*0;
    labelColor(:,:,3) = mask*120;
    
    labelledImg = imfuse(img, labelColor, 'blend', 'Scaling', 'joint');
    imshow(labelledImg);
    
    pause(0.01);
    if (rem(i,30) == 0)
         saveas(gcf,[num2str(i) '_ariel.png'])
    end
end

%save('aerialseqsegmented.mat','segmented');