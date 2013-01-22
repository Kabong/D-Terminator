

% Author: Pierre Baillargeon
% Date: 3-25-04
% Description: The functionality to analyze a static image, determine
% the type of objects in the image and then move a robotic arm based on 
% user input. 


function robotic_vision(shape,color_string,logic)

% Image  - the file to be read in / expecting a webcam image - jpeg format (should be a string - the filename)
% Object - the user input specifing what the robotic arm should retrieve
% Logic - and/or   ex: do you want an object that is red and circular or do
%                      you simply want a circlular object that might be red?
    
    % initialize serial port
    s=serial('COM6');
    set(s,'BaudRate',9600);
    fopen(s);
    
    %move the arm out of the way of the camera
    arm_movement(s,'gripper',125);
    arm_movement(s,'arm',100);
    arm_movement(s,'forearm',120);
    
    vid=videoinput('winvideo',1,'RGB24_640x480');
    frame = getsnapshot(vid);
    I=frame;
    
    figure
    subplot(2,2,1),imshow(I),title('Captured Frame')

    I2=im2double(I);
    
    bw=(im2bw(I2,graythresh(I2)));
    subplot(2,2,2),imshow(bw),title('Result of thresholding')
    
    % Remove noise - our objects should be at least 600 pixels - anything else we can ignore
    bw=bwareaopen(bw,3000);
    subplot(2,2,3),imshow(bw),title('Noise removed')

    %fill in any holes
    bw=imfill(bw,'holes');
    subplot(2,2,4),imshow(bw),title('Objects filled')
          
    [B,L]=bwboundaries(bw);
    % Now B contains information about the objects in the image and L contains 
    
    % get some information about the objects
    var=bwlabel(bw);
    %properties of objects found
    x=regionprops(var,'all');
    %number of objects found
    num=size(x,1);
    
    % now that objects have been identified, we need to start processing
    % the users request 
    
    % color processing 
    switch(color_string)
        case 'red'
            color=1;
        case 'green'
            color=2;
        case 'blue'
            color=3;
    end
    
    object_num=-1;  % initialize our object variables so after we search
    object_num2=-1; % for an object below, we can tell if we had any
    obj_search=-1;  % matches or not and generate an error message if 
    obj_found=0;     % needed (now added support for too many matches)
    obj_found2=0;
        
    figure
    imshow(I(:,:,color));
    
    % loop through the detected objects and see if any match the color
    % we're looking for
    for z=1:num
        color_find=determine_colors(x,L,I2,color,z);
        if(color_find>.8)
            colors_found(1,z)=1;
            obj_found=obj_found+1;
        else
            colors_found(1,z)=0;
        end
    end
 
    for(y=1:num)
        shapes_found{1,y}=determine_shape(var,y)
        if(strcmp(shape,shapes_found{1,y})==1)
            obj_found2=obj_found2+1;
        end
    end
    
    count=0;
    switch(logic)
        case 'and'
           for(z=1:num)
               if(strcmp(shape,shapes_found{1,z})==1 & colors_found(1,z)==1)
                   object_num=z;
               end
           end           
           if(object_num == -1 )
               fclose(s);
               error('No object was found with the color and shape specified');
           end        
        case 'or'            
            for(z=1:num)
                if(strcmp(shape,shapes_found{1,z})==1 | colors_found(1,z)==1)
                    count=count+1;
                    object_num=z;
                end
            end
            if(count>1)
                fclose(s);
                error('More than one object matched this criteria, please be more specific');
            elseif(count==0)
                fclose(s);
                error('No object was found that matched this color or shape');
            end
    end
                            
    % get the centroid of the first object (center of gravity)
    centroid=x(object_num).Centroid;

    convert_factor = 85;  % estimate to turn the inches measurement into a usable realative pixel value
    
    % calculate the angle the robotic arm must rotate to be pointing at the
    % centroid of this object
    centroid(1)
    centroid(2)
   
    x_coord=320-(centroid(1)+.3*convert_factor)

    y_coord=480-centroid(2)
    y_offset=5.6*convert_factor; 
    y_coord=y_coord+y_offset;
    x_inch=x_coord/convert_factor;
    y_inch=y_coord/convert_factor;
    
    % we also now know the distance from the object to the arm
    object_distance=sqrt(x_coord^2 + y_coord^2)
    
    % we now know how far to rotate the base of the arm to be pointing at the center of the object - if this   
    % number is negative, it means turn right, else turn left
    base_rotate = (180 / pi) * atan(x_coord/ object_distance);
    
    base_rotate=90-base_rotate
    if(base_rotate>87)
        base_rotate=base_rotate-5;
    end
    
    %adjust object_distance since arm is actually higher than objects -
    arm_height=0*convert_factor;  % not needed - maybe used in future implementations

    object_distance=sqrt(object_distance^2+arm_height^2);  

    % start moving the arm
    arm_movement(s,'base',base_rotate);   % the arm is now pointed at the object
   
    % now we need to calculate the angle to move the arm and the forearm
    arm = 3.75*convert_factor;   % these arm/forearm estimates are based on the measurement of the physical robotic arm 
    forearm = 8*convert_factor;  
    
    
    dist_inch=object_distance/convert_factor;
    forearm_angle = (acos( ( object_distance^2 - arm^2 - forearm^2 ) / ( -2 * arm * forearm ) ) )* ( 180 / pi )
    arm_angle =  asin((forearm * sin(forearm_angle * pi/180)) / (object_distance -0*convert_factor) ) * (180/pi)

    arm_movement(s,'wrist',120);
    pause(1);
    arm_movement(s,'forearm',180-forearm_angle);
    pause(1);
    arm_movement(s,'arm',arm_angle-10);
    
    %move to the bin
    pause(1);
    arm_movement(s,'gripper',84);
    pause(1);
    arm_movement(s,'arm',90);
    pause(1);
    arm_movement(s,'forearm',100);
    pause(1);
    arm_movement(s,'base',0);
    pause(1);
    arm_movement(s,'gripper',120);
    
    fclose(s);  