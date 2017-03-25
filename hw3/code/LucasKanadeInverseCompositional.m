function [u,v] = LucasKanadeInverseCompositional(It, It1, rect)

% input - image at time t, image at t+1, template (top left, bot right coordinates)
% output - movement vector, [u,v] in the x- and y-directions.

width = rect(3)-rect(1);
height = rect(4)-rect(2);
template = imcrop(It, [rect(1) rect(2) width height]);

[gradX,gradY] = gradient(double(template));
templateGrad = double([gradX(:),gradY(:)]);
H = templateGrad'*templateGrad;

epsilon = 0.001;
u=0;v=0;
for i=1:100
    x = (rect(1)+u):(rect(3)+u);
    y = (rect(2)+v):(rect(4)+v);
    [X,Y] = meshgrid(x,y);
    %keyboard;
    Checktemplate = interp2(double(It1), X, Y);
        
    del = double(template - Checktemplate);
    del_p = H\(templateGrad'*del(:));
    u = u + del_p(1);
    v = v + del_p(2);
	if (norm(del_p) < epsilon)
	i
        break;
	end
end

end
