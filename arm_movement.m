
% Author: Pierre Baillargeon
% Date: 3-27-04
% Description: The functionality to move the robotic arm it is assume that
% when this function is called the serial port is already opened and all we
% need to do is send the new positioning information to the Mini-SSC II


function arm_movement(s,joint,degree)
    % possible joints to be passed :
    %   base - arm - forearm - wrist - gripper
    % degree must be between 0-180

    % this check is done to make sure we don't send a command that might
    % try to move the motors too far and damage them
    if(degree<0 || degree>180)
        fclose(s);
        error('Incorrect degree input - must be between 0 and 180');        
    end
    
    % the motor controller takes movement input from 0-255 instead of 0 to
    % 180 degrees, so now convert the number
    degree=round(degree*(254/180));

    switch(joint)
        case 'base'
            joint_num=0;
        case 'arm'
            joint_num=1;
        case 'forearm'
            joint_num=2;
        case 'wrist'
            joint_num=3;
        case 'gripper'
            joint_num=4;
        otherwise
            fclose(s);
            error('Incorrect joint specified. Available joints are: base, arm, forearm, wrist, gripper');
    end 
   
    fwrite(s,255);
    fwrite(s,joint_num);
    fwrite(s,degree);
    
