
% load frames


% implementation
clc;
clear all;
close all;

load('../data/carseq.mat')

rect = [60, 117, 146, 152];

[~,~,num] = size(frames);

rects = zeros(num,4);

rects(1,:)=rect;

width = rect(3)-rect(1);
height = rect(4)-rect(2);
template = imcrop(im2double(frames(:,:,1)), [rect(1) rect(2) width height]);

[gradX,gradY] = gradient(double(template));
templateGrad = double([gradX(:),gradY(:)]);
H = templateGrad'*templateGrad;


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

	%u = 0; v = 0;
    epsilon = 0.01;
	for j=1:100
		x = (rect(1)+u):(rect(3)+u);
		y = (rect(2)+v):(rect(4)+v);
		[X,Y] = meshgrid(x,y);
		Checktemplate = interp2(double(imgNew), X, Y);			
		del = double(template - Checktemplate);
		del_p = H\(templateGrad'*del(:));
		u = u + del_p(1);
		v = v + del_p(2);
		if ((norm(del_p) - norm([u v])) < epsilon)
		    rect = [rect(1)+u rect(2)+v rect(3)+u rect(4)+v];
			rect = round(rect);
			break;
		end
end



    rects(i+1,:) = rect;

    if (rem(i,100) == 99 || i == 1)
        saveas(gcf,[num2str(i+1) '_car_tempcorr.png'])
    end
end

save('carseqrects-wcrt.mat','rects')
