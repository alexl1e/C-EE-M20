function [angle] = ComputeNewAngle(x, y, ant_angle, pheromones, concentration, r_smell, sigma_1, sigma_2)
%{

functionality:
    - if there are no pheromones in the map, change the angle following the
    random distribution specified in the project description.
    - compute the pheromones positions relative to x,y, and also their
    distance.
    - compute the pheromones angles relative to the x axis in range 0, 2pi.
    - filter out the unavailable pheromones.
    - if there are no available pheromones in the map, don't change the 
    angle, and terminate the function. Still, the angle changes slightly 
    random.
    - compute the mean of value of all the pheromones positions weighted by
    their concentration.
    - compute the new angle.

outputs:
    angle: the new angle of the ant

inputs:
    x: the x of ant
    y: the y of ant
    ant_angle: the current angle of ant
    pheromones: list of all pheromones
    concentration: list of all pheromone concentrations
    r_smell: the distance in which ant can smell pheromones
    sigma_1: the angle randomness sigma, if ant finds pheromones
    sigma_2: the angle randomness sigma, if ant does not find pheromones

%}
    %If there are no pheromones for the ant, set new angle with randomness using sigma_2
    if height(pheromones) == 0
        angle = ant_angle + normrnd(0, sigma_2); 
        return
    end
    
    %Calculate the distances between the ant and each pheromone
    delta_x=pheromones(:, 1)-x; %x-difference
    delta_y=pheromones(:, 2)-y; %y-difference
    distances0= sqrt(delta_x.^2 + delta_y.^2); %distance between ant and pheromones
    angles0 = mod(ant_angle, 2*pi) - mod(atan2(delta_y,delta_x), 2*pi); %angle difference between ant and pheromones
    
    %Filter pheromones by distance and angle difference
    p = height(pheromones); %Finding number of pheromones
    conditions_met = zeros(p, 1); %Creating a Boolen vector
    for i = 1:p %Iterating through every pheromone
        if distances0(i) <= r_smell && abs(angles0(i)) <= pi/2 %If the distance and angle difference is low enough
            conditions_met(i) = 1; %Set to true at the index corresponding to that pheromone
        end
    end
    
    %Filter all other data by pheromone distance and angle difference
    delta_x = delta_x(conditions_met(:) == 1, :);
    delta_y = delta_y(conditions_met(:) == 1, :);
    concentration = concentration(conditions_met(:) == 1, :);
    pheromones = pheromones(conditions_met(:) == 1, :);

    %If there are no pheromones for the ant, set new angle with randomness using sigma_2
    if height(pheromones) == 0
        angle = ant_angle + normrnd(0, sigma_2); 
        return
    end

    %Find mean value of pheromone positions weighted by their concentrations
    x_avg = mean(delta_x.*concentration);
    y_avg = mean(delta_y.*concentration);
    
    %Set new angle using the average position of the pheromones with randomness using sigma_1
    angle = atan2(y_avg, x_avg) + normrnd(0, sigma_1);
end