function [indicator] = CheckColonyProximity(x, y, colony_pos, colony_proximity_threshold)
%{

functionality:
    compute the distance between the ant location and the colony. If the
    distance is less than a threshold, ant is near colony and therefore drops food if it carries it.

outputs:
    indicator: 1, if the ant is near colony, and 0 else.

inputs:
    x: the x of ant
    y: the y of ant
    colon_pos: colony position
    colony_proximity_threshold: the threshold to determine proximity

%}

    % Extract x- and y- position of colony
    colony_x = colony_pos(1);
    colony_y = colony_pos(2);
    
    % Compute distance
    distance = sqrt((colony_x - x)^2 + (colony_y - y)^2);
    
    % Threshold conditions
    if distance < colony_proximity_threshold
        % Ant is near colony
        indicator = 1;
    else
        % Ant is not near colony
        indicator = 0;
    end
end