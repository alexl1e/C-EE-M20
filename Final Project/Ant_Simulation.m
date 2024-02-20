% cleaning stuff
clc
clear
close all

% load the map
load('map1.mat');

% fixed parameters

% customizable parameters
delta_blue = 0.2; %Value can range from 0 to 1 (exclusive)
delta_red = 0.1; %Value can range from 0 to 1 (exclusive)
decay = [delta_blue, delta_red]; %Vector of delta_blue and delta_red
r_smell = 10; %Value can range from 0 to 10 (inclusive)
sigma_phi_1 = .1; %Value can range from 0 to positive infinity
sigma_phi_2 = 1; %Value can range from 0 to positive infinity

% initialize the ants
N = n_ants; %Number of ants
ant_info = zeros(N,4); %Creating the matrix with the ant information
ant_info(:, 1) = colony_pos(1); %Column 1 represents the x-position
ant_info(:, 2) = colony_pos(2); %Column 2 represents the y-position
ant_info(:, 3) = (linspace(0, 2*pi, N))'; %Column 3 represents the facing angle
ant_info(:, 4) = 0; %Column 4 represents the food status

% initialize pheromones
pheromones_info = zeros(N,4); %Creating the matrix with the pheromone information
pheromones_info(:, 1) = colony_pos(1); %Column 1 represents the x-position
pheromones_info(:, 2) = colony_pos(2); %Column 2 represents the y-position
pheromones_info(:, 3) = 0; %Column 3 represents the color;
pheromones_info(:, 4) = 1; %Column 4 represents the concentration

% colony points
ca = 0:pi/50:2*pi; %Creating angles for the colony points
colony_info(:, 1) = colony_proximity_threshold * cos(ca) + colony_pos(1); %Column 1 represents the x-position
colony_info(:, 2) = colony_proximity_threshold * sin(ca) + colony_pos(2); %Column 2 represents the y-position
colony_info(:, 3) = 0; %Column 3 represents the "color"
colony_info(:, 4) = 100000; %Column 4 represents the "infinite" concentration

% food points
food_info = food_sources; %Column 1 represents the x-position, Column 2 represents the y-position
food_info(:,3) = 1; %Column 3 represents the "color"
food_info(:,4) = 100000; %Column 4 represents the infinite concentration;

% colony food counter variable
colony_food = 0;

% other variables
delta_t = 1; %Change in time between frames
speed = 1.5; %Amount of units ants move per unit frame

% creating a figure and video
figure;
videoFile = VideoWriter('finalProject.mp4', 'MPEG-4');
videoFile.FrameRate = 30;
open(videoFile)

% iterate over timestamps (i.e., for each timestamp...)
for t = 0:delta_t:T

    %Separating blue pheromone matrix
    blue_pheromones = pheromones_info(pheromones_info(:,3)==0, :); %Adding in blue_pheromones
    blue_pheromones = [blue_pheromones; colony_info]; %Adding in colony points

    %Creating red pheromone matrix
    red_pheromones = pheromones_info(pheromones_info(:,3)==1, :); %Adding in red pheromones
    red_pheromones = [red_pheromones; food_info]; %Adding in food points

    % iterate over ants (i.e., for each ant...)
    for a = 1:N
        ant = ant_info(a, :); %Extract the row vector data for a specific ant

        if ant(4) %If the ant has food
            temp_pheromones = blue_pheromones; %Pass the blue pheromone information into ComputeNewAngle()
        else %If the ant does not have food
            temp_pheromones = red_pheromones; %Pass the red pheromone information into ComputeNewAngle()
        end

        % compute the new angle
        ant(3) = ComputeNewAngle(ant(1), ant(2), ant(3), temp_pheromones(:, 1:2), temp_pheromones(:, 4), r_smell, sigma_phi_1, sigma_phi_2);

        % check movement validity and update ant loction and angle
        [ant(1), ant(2), ant(3)] = MovementValidationExecution(ant(1), ant(2), ant(3), speed, map_coordinates, zeros(0,4));

        % if ant is not carrying food, check the food proximity and grab food if it's close to a source.
        if ~ant(4) %If the ant is not carrying food
            [food_info, indicator] = CheckFoodProximity(ant(1), ant(2), food_info, food_proximity_threshold); %Check to see if the ant is close enough to pick up food (and return and updated food matrix)
            if indicator %If the ant is close enough to pick up the food
                ant(4) = 1; %Change the food status to true
                ant(3) = ant(3) + pi; %Turn the opposite direction
            end

        % else, check the colony proximity and drop the food if it's close.
        else %If the ant is carrying food
            indicator = CheckColonyProximity(ant(1), ant(2), colony_pos, colony_proximity_threshold); %Check to see if ant is close enough to drop the food
            if indicator %If the ant is close enough to drop the food
                ant(4) = 0; %Change the food status to false
                ant(3) = ant(3) + pi; %Turn the opposite direction
                colony_food = colony_food + 1; %Increase the colony food count 
            end
        end

        ant_info(a, :) = ant; %Input the updated row vector data for a specific ant
    % end iterate over ants
    end

    % update pheromones
    [p1, p2] = PheromonesUpdate(pheromones_info(:, 1:3), pheromones_info(:, 4), decay);
    pheromones_info = [p1, p2]; %Input output back into the pheromones information matrix
    pheromones_info = [pheromones_info; ant_info(:, 1:2), ant_info(:, 4), ones(N, 1)]; %Add in pheromones the ants just dropped

    % plot everything

    %Plotting blue pheromones
    blue_pheromones = pheromones_info(pheromones_info(:,3)==0, :); %Filter to get only blue pheromones
    scatter_blue = scatter(blue_pheromones(:, 1), blue_pheromones(:, 2), 10, "b", "filled"); %Must use scatter for transparency effect
    scatter_blue.AlphaData = blue_pheromones(:,4); %Adding transparency
    scatter_blue.MarkerFaceAlpha = 'flat'; %Makes transparency effect work
    hold on;

    %Plotting red pheromones
    red_pheromones = pheromones_info(pheromones_info(:,3)==1, :); %Filter to get only red pheromones
    scatter_red = scatter(red_pheromones(:, 1), red_pheromones(:,2), 10, "r", "filled"); %Must use scatter for transparency effect
    scatter_red.AlphaData = red_pheromones(:,4); %Adding transparency
    scatter_red.MarkerFaceAlpha = 'flat'; %Makes transparency effect work
    
    %Plotting colony and ants
    plot(food_info(:,1), food_info(:, 2), 'v', 'Color', 'm'); %Plotting food sources
    plot(colony_info(:,1), colony_info(:,2), 'Color', 'y', 'LineWidth', 2); %Plotting colony
    plot(ant_info(:, 1)', ant_info(:, 2)', '*', 'Color', 'k'); %Plotting ants

    %Graph display settings
    title("Time = " + num2str(t) + " Food in Colony: " + num2str(colony_food)); %Displaying updated time and food count
    xlim([map_coordinates(1) map_coordinates(3)]); %Setting x-axis limits
    ylim([map_coordinates(2) map_coordinates(4)]); %Setting y-axis limits
    grid on;

    %Add frame to video
    capturedFrame = getframe(gcf);
    writeVideo(videoFile, capturedFrame)
    hold off;

    %Amount of time between frames in seconds
    pause(0.001); 

% end iterate over timestamps
end

% end video
close(videoFile)
