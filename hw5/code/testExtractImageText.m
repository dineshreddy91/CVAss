path{1} = '../images/01_list.jpg';
path{2} = '../images/02_letters.jpg';
path{3} = '../images/03_haiku.jpg';
path{4} = '../images/04_deep.jpg';

for k=1:4
    [text] = extractImageText(path{k});
    fprintf('%s\n',text);
end