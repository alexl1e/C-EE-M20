%{
M20 - Introduction to Computer Programming with MATLAB
Instructor: Prof. Enrique López Droguett, Ph.D.
Teacher Assistants: M. Fidansoy, G. San Martín, M. Pishahang, V. Vela.
Fall 2023 – UCLA
Student: Alex Lie
UCLA ID: 905901892
Task 3: Traveling Salesman Problem
%}

%Beginning of code
clear
close
clc

%Declare X and Y positions
X=[67,11,65,39,72,95,22,26,29,80];
Y=[27,97,67,74,94,42,41,0,41,15];

%Create matrix of distances
d=zeros(width(X));
for i =1:width(X)
    for j=1:width(X)
        d(i,j)=sqrt( (X(i)-X(j))^2 + (Y(i)-Y(j))^2 ); %Distance formula
    end
end

%Call nearest neighbor function
tic;
[total_cost, route]=NN_TSP(1,d)
toc;