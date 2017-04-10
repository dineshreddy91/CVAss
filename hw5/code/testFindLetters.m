clear all;
close all;
clc;
i{1} = imread('../images/01_list.jpg');
i{2} = imread('../images/02_letters.jpg');
i{3} = imread('../images/03_haiku.jpg');
i{4} = imread('../images/04_deep.jpg');

for k=1:4
    [lines, bw] = findLetters(i{k});
    figure,imshow(bw);
    hold;
    for j=1:length(lines)
        line = [lines{j}(:,1) lines{j}(:,2) (lines{j}(:,3)-lines{j}(:,1)) (lines{j}(:,4)-lines{j}(:,2))];  
        for f=1:size(lines{j},1)
            rectangle('Position',line(f,:),'EdgeColor','r');   
        end
    end
end