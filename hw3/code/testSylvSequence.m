% load frames


% implementation
clc;
clear all;
close all;

load('../data/sylvseq.mat')
load('../data/sylvbases.mat')

[~,~,num] = size(frames);
rects = zeros(num,4);

rect = [102, 62, 156, 108];
rect_basis = rect;
width = rect(3)-rect(1);
height = rect(4)-rect(2);
rects(1,:)=rect_basis;

for i=1:num-1
    img = im2double(frames(:,:,i));
    imgNew = im2double(frames(:,:,i+1));
    
    imshow(img);
    hold on;
    %rectangle('Position',[rect(1),rect(2),width,height], 'LineWidth',3, 'EdgeColor', 'g');
    rectangle('Position',[rect_basis(1),rect_basis(2),width,height], 'LineWidth',3, 'EdgeColor', 'y');
    hold off;
    pause(0.001);
    if (rem(i,100) == 0 || i == 2)
        saveas(gcf,[num2str(i) '_sylv.png'])
    end

    [u,v] = LucasKanadeInverseCompositional(img,imgNew,rect);
    rect = round([rect(1)+u rect(2)+v rect(3)+u rect(4)+v]);
    
    [u,v] = LucasKanadeBasis(img,imgNew,rect_basis, bases);
    rect_basis = round([rect_basis(1)+u rect_basis(2)+v rect_basis(3)+u rect_basis(4)+v]);
    rects(i+1,:) = rect_basis;
end

save('sylvseqrects.mat','rects')
