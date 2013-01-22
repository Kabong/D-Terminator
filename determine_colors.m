
% Author: Pierre Baillargeon
% Date: 3-27-04
% Description: This script compares an RGB image (in double format) against
% a binary mask, and computes the average color intensity of a specified object within
% one of the specified color channels

function final = determine_colors(X,L,I,channel,object)

    % Input definitions:
    % - X: result of "var=bwlabel(bw)" then "x=regionprops(var,'all')"
    %      this variable contains information about the objects found such
    %      as Area, Centroid, etc
    % - L: result of "[B,L]=bwboundaries(bw)" - essentially a binary mask
    %      of the objects
    % - I: RGB image to be checked
    % - channel: Which of the three RGB channels to check
    % - object: The object number to check
    
    
    if (channel<1 || channel>3)
        fclose(s);
        error('Channel must be between 1 and 3');
    end
    
    color=0;
    for x=1:size(I(1,:,channel),2)
       for y=1:size(I(:,1,channel),1)
         if(L(y,x)==object)
               color=color+I(y,x,channel);
         end
       end
    end

    final=color/(X(object).Area)
