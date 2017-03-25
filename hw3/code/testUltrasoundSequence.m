
% load frames


% implementation
clc;
clear all;
close all;

load('../data/usseq.mat')

rect = [255, 105, 310, 170];

[~,~,num] = size(frames);

rects = zeros(num,4);
rects(1,:)=rect;
for i=1:num-1
    img = im2double(frames(:,:,i));
    imgNew = im2double(frames(:,:,i+1));

    imshow(img);
    hold on;
    rectangle('Position',[rect(1),rect(2),abs(rect(1)-rect(3)),abs(rect(2)-rect(4))], 'LineWidth',2, 'EdgeColor', 'y')    
    
    %keyboard;
    %hold off;
    pause(0.001); 
    [u,v] = LucasKanadeInverseCompositional(img,imgNew,rect);
    rect = [rect(1)+u rect(2)+v rect(3)+u rect(4)+v];
    rect = round(rect);
    rects(i+1,:) = rect;

    if rem(i,25) == 24 || i == 4
        saveas(gcf,[num2str(i+1) '_us.png'])
    end
end

save('usseqrects.mat','rects')
