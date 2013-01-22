

% Author: Pierre Baillargeon
% Date: 3-27-04
% Description: This script uses signatures to determine if an object
% is a circle, triangle, star or square


function x=determine_shape(I,obj_num)

    B = boundaries(I);
    [st, angle, x0, y0] = signature(B{obj_num});
    
    

    rounded=round(st);
    figure, plot(angle,rounded)
    %horizontal slicing plane
    slicing_plane=round(( max(st)+min(st) )/2)+3;
    %distance from max amplitude to min amplitude
    difference=max(st)-min(st);
    axis_pass=0;
    last_detect=0;
    
    for x=1:size(rounded,1)
        if (rounded(x)==slicing_plane | rounded(x)==slicing_plane+1 | rounded(x)==slicing_plane-1)
            % used to filter out noise
            if(x-last_detect>10)
                axis_pass=axis_pass+1;
                last_detect=x;
            end            
        end
    end
    axis_pass;
    peaks=floor(axis_pass/2);

    switch(peaks)
        case 3
            which_shape='triange';
        case 4
            which_shape='square';
        case 5
            which_shape='star';
        otherwise
            which_shape='circle';
    end
    
    % make sure we haven't erroneously detected a circle as something else
    % - we'ere doing this by looking at the difference between the max and
    % min amplitude, which for a circle will be much less than any of the
    % other objects
    if(difference<23)
        which_shape='circle';
    end
    
x=which_shape;