function [lines, bw] = findLetters(im)
% [lines, BW] = findLetters(im) processes the input RGB image and returns a cell
% array 'lines' of located characters in the image, as well as a binary
% representation of the input image. The cell array 'lines' should contain one
% matrix entry for each line of text that appears in the image. Each matrix entry
% should have size Lx4, where L represents the number of letters in that line.
% Each row of the matrix should contain 4 numbers [x1, y1, x2, y2] representing
% the top-left and bottom-right position of each box. The boxes in one line should
% be sorted by x1 value.
img = rgb2gray(im);
%Binarize with Otsu's 
level = graythresh(img);
im2 = im2bw(img,level);
%figure,imshow(im2)
%find connected objects serving as characters
%need to invert images
i = 1-im2;

%Enhancing connectivity
se = strel('disk',6);
i = imdilate(i,se);
i = imerode(i,se);
%figure,imshow(i);
bw = 1-i;
C = bwconncomp(i);

%Put a threshold for small characters which is adaptive as sizes might vary
%in images of characters
ind = C.PixelIdxList;
objsize = [];
for k = 1:length(ind)
    objsize(k) = length(ind{k});
end
th = max(objsize)/10; %discard obj smaller than /10 of this

%Now search along the indices and find bounding boxes
%assuming boxes are overlapping
line = []; %store all the boxes
for k=1:length(ind)
    %bounding box for each
    if length(ind{k})>th
        Dim = [];
        for g=1:length(ind{k})
            [y,x] = ind2sub(size(im2),ind{k}(g));
            Dim = [Dim;[y,x]];
        end
        line = [line;[min(Dim(:,2)) min(Dim(:,1)) max(Dim(:,2)) max(Dim(:,1))]];
    end
end

%CHECK
% figure,imshow(bw);
% hold;
% plot(line(:,1),line(:,2),'ro');
% plot(line(:,3),line(:,4),'bo');

%sort the boxes in line now
%get the minimum y, all the y's coming before it's end are in one line
% can be made more complex but we are dealing with simpler alignments only
% here

%WHILE TRAINING
%creating boundaries with centered data gaps
%picx = floor(0.15*(line(:,3)-line(:,1)));
%picy = floor(0.15*(line(:,4)-line(:,2)));
%line = line + [-picx -picy picx picy]; %adaptive windowing

count = 1;
while(true)
    allidx = (1:size(line,1))';
    [~,idx] = min(line(:,2));
    idxin = find(line(:,2)<=line(idx,4)); %all these form a line
    lines{count} = sortrows(line(idxin,:));
    count = count+1;
    allidx = setdiff(allidx,idxin);
    if length(allidx) == 0
        break;
    end
    line = line(allidx,:);
end
