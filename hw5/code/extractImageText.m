function [text] = extractImageText(fname)
% [text] = extractImageText(fname) loads the image specified by the path 'fname'
% and returns the next contained in the image as a string.
%Mapping array
optchar_array = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',...
                 '0','1','2','3','4','5','6','7','8','9'];
load('nist36_model.mat');
i = imread(fname);
[lines, bw] = findLetters(i);
text = [];
%extract template and classify
%reshape 32x32 template and feed
for j=1:length(lines)
    data  = [];
    x_cent = []; % to keep track of spaces
    %width = [];
    for k=1:size(lines{j},1)
        extract = bw(lines{j}(k,2):lines{j}(k,4),lines{j}(k,1):lines{j}(k,3));
        x_cent(k) = (lines{j}(k,3) + lines{j}(k,1))/2;
        %width(k) = lines{j}(k,3)-lines{j}(k,1);
%         [h,w] = size(extract);
%         %make it square first
%         if h>w
%             extract = padarray(extract,[0,floor((h-w)/2)],1);
%         else
%             extract = padarray(extract,[floor((w-h)/2),0],1);
%         end
        padv = max(floor([0.15*(-lines{j}(k,2)+lines{j}(k,4)),0.15*(lines{j}(k,3)-lines{j}(k,1))]));
        %figure,imshow(imresize(padarray(extract,[padv,padv],1),[32,32]))
        %pad with 15% white area to centralize it
        data(k,:) = reshape(imresize(padarray(extract,[padv,padv],1),[32,32]),1,[]);
    end
    outputs = Classify(W, b, data);
    [~,ind] = max(outputs');
    %upp = max(x_cent(2:end) - x_cent(1:end-1));
    loww = min(x_cent(2:end) - x_cent(1:end-1));
    spa = (x_cent(2:end) - x_cent(1:end-1))./loww; %put a space at loc+1 position
    indsp = find(spa>2);
    for l = 1:length(ind)
        text = [text optchar_array(ind(l))];
        if ismember(l,indsp)
            text = [text ' '];
        end
    end
    %Write in text form
    %text = [text optchar_array(ind) '\n'];
    text = [text '\n'];
    %fprintf('\n');
end
