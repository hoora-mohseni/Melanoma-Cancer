function window=windowselection(image,n,i,j) % n: n*n window size ; (i,j): pixel position

    if i<=(n-1)/2 && j<=(n-1)/2
    window=image(1:i+(n-1)/2,1:j+(n-1)/2);
    elseif i<=(n-1)/2 && j>(n-1)/2 && j<size(image,2)-(n-1)/2
    window=image(1:i+(n-1)/2,j-(n-1)/2:j+(n-1)/2);
    elseif i<=(n-1)/2 && j>=size(image,2)-(n-1)/2
    window=image(1:i+(n-1)/2,j-(n-1)/2:size(image,2));
    
    elseif i>(n-1)/2 && i<size(image,1)-(n-1)/2 && j<=(n-1)/2
    window=image(i-(n-1)/2:i+(n-1)/2,1:j+(n-1)/2);
    elseif i>(n-1)/2 && i<size(image,1)-(n-1)/2 && j>(n-1)/2 && j<size(image,2)-(n-1)/2
    window=image(i-(n-1)/2:i+(n-1)/2,j-(n-1)/2:j+(n-1)/2);
    elseif i>(n-1)/2 && i<size(image,1)-(n-1)/2 && j>=size(image,2)-(n-1)/2
    window=image(i-(n-1)/2:i+(n-1)/2,j-(n-1)/2:size(image,2));
        
        
    elseif i>=size(image,1)-(n-1)/2 && j<=(n-1)/2
    window=image(i-(n-1)/2:size(image,1),1:j+(n-1)/2);
    elseif i>=size(image,1)-(n-1)/2 && j>(n-1)/2 && j<size(image,2)-(n-1)/2
    window=image(i-(n-1)/2:size(image,1),j-(n-1)/2:j+(n-1)/2);
    elseif i>=size(image,1)-(n-1)/2 && j>=size(image,2)-(n-1)/2
    window=image(i-(n-1)/2:size(image,1),j-(n-1)/2:size(image,2));
    end
    
end