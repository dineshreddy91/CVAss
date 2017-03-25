function M = LucasKanadeAffine(It, It1)

% input - image at time t, image at t+1 
% output - M affine transformation matrix


epsilon = 0.001;
del_p = 1;
param = zeros(1,6);

template = double(medfilt2(It/255));
img = double(medfilt2(It1/255));

width = size(template,2);
height = size(template,1);

[X, Y] = meshgrid(1:width, 1:height);
Xpoints = X(:);
Ypoints = Y(:);


for i=1:200
    
    wx = (1+param(1))*X + param(3)*Y + param(5);
    wy = param(2)*X + (1+param(4))*Y + param(6);
   
    m = zeros(height, width);
    m = m | (wx >=1 & wx <= width);
    m = m & (wy >=1 & wy <= height);
    
    wimg = interp2(X, Y, img, wx, wy);
    wimg(isnan(wimg)) = 0;
    
    delIm = template - wimg;
    delIm = m .* delIm;
    delIm = delIm(:);

    [gradX, gradY] = gradient(wimg);
    gradX = double(m .* gradX);
    gradY = double(m .* gradY);
    gradX = gradX(:);
    gradY = gradY(:);
    
    A = [gradX.*Xpoints gradY.*Xpoints gradX.*Ypoints gradY.*Ypoints gradX gradY];
        
    del_p = A' * A\A' * delIm;
    param = param + del_p';
    
    if (norm(del_p) < epsilon)
        break;
	end

end
M = [1+param(1),param(3),param(5);param(2),1+param(4),param(6);0,0,1,];
    
end
