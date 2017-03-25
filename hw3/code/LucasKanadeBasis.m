function [u,v] = LucasKanadebases(It, It1, rect, bases)

% input - image at time t, image at t+1, rectangle (top left, bot right
% coordinates), bases 
% output - movement vector, [u,v] in the x- and y-directions.


width = rect(3)-rect(1);
height = rect(4)-rect(2);
template = imcrop(It, [rect(1) rect(2) width height]);

[m,n,l] = size(bases);
w = zeros(1,l);
VectorsBases = zeros(m*n, l);


for i=1:size(bases)
    current_bases = bases(i);
    VectorsBases(:,i) = current_bases(:);
end
[gradX,gradY] = gradient(double(template));
templateGrad = double([gradX(:),gradY(:), VectorsBases]);
H = templateGrad'*templateGrad;
%keyboard;
epsilon = 0.001;
u=0;v=0;

for i=1:200
    
    p = [u,v,w];
    x = (rect(1)+p(1)):(rect(3)+p(1));
    y = (rect(2)+p(2)):(rect(4)+p(2));
    [X,Y] = meshgrid(x,y);
    %keyboard;
    Checktemplate = interp2(double(It1), X, Y);
    %Checktemplate = imcrop(It1, [rect(1)+u rect(2)+v width height]);
    
    del = double(template - Checktemplate);
    del_p = H\(templateGrad'*del(:));
    u = u + del_p(1);
    v = v + del_p(2);
    w = del_p(3:12)';
    
	if (norm(del_p) < epsilon)
        break;
	end
end

