function [x_new, y_new, angle] = MovementValidationExecution(x, y, angle, speed, allowed, forbidden)
%{

functionality:
    - compute the new ant position.
    - if the new position is valid, return the new position. else, keep the
    current position, and only change the angle by 180 degrees.

outputs:
    x_new: new x of ant
    y_new: new y of ant
    angle: new angle of ant

inputs:
    x: the x of ant
    y: the y of ant
    angle: ant current angle
    speed: ant speed
    allowed: a matrix of 1 rows and 4 columns, containing lower left and 
        upper right points of the map
    forbidden: a matrix of N rows and 4 columns, containing lower left and 
        upper right points of the walls

%}

    %Calculate the positions of the ant at the next step
    next_x = x + speed*cos(angle);
    next_y = y + speed*sin(angle);
    
    % Check to see if ant is out of the map
    if next_x >= allowed(1) && next_y >= allowed(2) && ...
            next_x <= allowed(3) && next_y <= allowed(4)
        % Valid position (return updated coordinates)
        x_new = next_x;
        y_new = next_y;
    else
        % Invalid position (change angle by 180 degrees)
        angle = angle + pi;
        x_new = x;
        y_new = y;
    end
end