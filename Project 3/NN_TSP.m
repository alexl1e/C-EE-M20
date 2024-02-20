%{
M20 - Introduction to Computer Programming with MATLAB
Instructor: Prof. Enrique López Droguett, Ph.D.
Teacher Assistants: M. Fidansoy, G. San Martín, M. Pishahang, V. Vela.
Fall 2023 – UCLA
Student: Alex Lie
UCLA ID: 905901892
Function for Task 3: Traveling Salesman Problem
%}

%total_cost: total distance traveled from following 'route'.
%route: list containing the route found by the nearest neighbor algorithm.
%start: starting node for the algorithm.
%D: matrix of distances.

function [total_cost, route] = NN_TSP(start, D)
    notVisited=ones(1,width(D)); %Initialize all the verticies as unvisited
    curLocation=start; %Choose an initial location
    route=zeros(size(notVisited)); %Create a route vector
    route(1)=curLocation; %Set the first element in the route vector to the start position
    notVisited(curLocation)=0; %Mark the starting position as visited
    total_cost=0; %Set the total cost to zero
    while width(notVisited(notVisited==0))~=width(notVisited) %Repeat until all locations have been visited
        possibleDistances=notVisited.*D(curLocation,:); %Show distances to all possible locations (excluding locations that have already been visited)
        possibleDistances(possibleDistances==0)=NaN; %Set 0 values to NaN (this is so that our next line of code ignores zeros and works as intended)
        [nextDistance, curLocation]=min(possibleDistances); %Find the smallest distance and the closest location
        notVisited(curLocation)=0; %Set the current location as visited
        route(width(notVisited(notVisited==0)))=curLocation; %Add location to the next available index in the route vector
        total_cost=total_cost+nextDistance %Update the total cost
    end
end