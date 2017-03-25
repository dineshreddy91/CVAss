clear all;
close all;
clc;

img1 = imread('../data/model_chickenbroth.jpg');
img2 = imread('../data/model_chickenbroth.jpg');

[locs1 desc1] = briefLite_rotate(img1);

for angle=0:10:180
    im2 = imrotate(img2,angle);
    [locs2 desc2]= briefLite_rotate(im2);
    matches((angle/10)+1) = size(briefMatch(desc1, desc2,0.8),1);
end


close all;
bar(10*[0:18],matches)
xlabel('Rotation (in deg)');
ylabel('Number of Matches');
saveas(gcf,'../results/EC2_RotErr.jpg');

for scale=1:20
    im2 = imresize(img2,0.2*scale);
    [locs2 desc2]= briefLite_rotate(im2);
    matchPairs = briefMatch(desc1, desc2,0.8);
    matches(scale) = size(matchPairs,1);
    %plotMatches(img1,img2,matchPairs,locs1,locs2);
end


close all;
bar(0.3*[1:20],matches)
xlabel('Scale (in deg)');
ylabel('Number of Matches');
saveas(gcf,'../results/EC2_ScalErr.jpg');
