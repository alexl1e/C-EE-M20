function [food_sources, indicator] = CheckFoodProximity(x, y, food_sources, food_proximity_threshold)
%{

functionality:
    compute the distance between the ant location and all food sources.
    find the nearest food source.
    if the distance is less than a threshold, remove that source from the
    foods list, and return 1. else, return 0.

outputs:
    food_sources: the (probably) modified list of food sources.
    indicator: 1, if the ant is near a food source, and 0 else.

inputs:
    x: the x of ant
    y: the y of ant
    food_sources: the list of food sources
    food_proximity_threshold: the threshold to determine proximity

%}
    %If there is no food left return with indicator = 0
    if isempty(food_sources)
        indicator = 0;
        return
    end

    % Keep track of current minimum distance (start at infinity) and position
    current_min = inf;
    ID = 0;
    food_x = food_sources(:, 1);
    food_y = food_sources(:, 2);
    
    % Iterate through each food source and calculate distance
    for i = 1:size(food_sources,1)
    
        % Calculate distance
        current_distance = sqrt((food_x(i) - x).^2 + (food_y(i) - y).^2);
    
        % Determine if current minimum and position should be updated
        if current_distance < current_min
            current_min = current_distance;
            ID = i;
        end
    end
    
    % Determine threshold requirements
    if current_min < food_proximity_threshold
        food_sources(ID, :) = [];
        indicator = 1;
    else
        indicator = 0;
    end
end