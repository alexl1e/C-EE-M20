function [pheromone, concentration] = PheromonesUpdate(pheromone, concentration, decay)
%{

functionality:
    reduce all concentrations by decay, and only keep the pheromones with
    positive concentration.

outputs:
    pheromone: list of all modified pheromones
    concentration: list of all new pheromone concentrations

inputs:
    pheromone: list of all pheromones
    concentration: list of all pheromone concentrations
    decay: the concentration decay value

%}

    % Update pheromone concentration
    for i = 1:size(pheromone, 1) %Iterating through every pheromone
        if pheromone(i,3) == 0 %If the pheromone is blue
            concentration(i) = concentration(i) - decay(1); %Decrease concentration by delta_blue
        else %If the pheromone is red
            concentration(i) = concentration(i) - decay(2); %Decrease concentration by delta_red
        end
    end

    % Return pheromones and corresponding concentrations that have a concentration greater than zero
    pheromone = pheromone(concentration(:)>0, :);
    concentration = concentration(concentration>0);
end