%{
M20 - Introduction to Computer Programming with MATLAB
Instructor: Prof. Enrique López Droguett, Ph.D.
Teacher Assistants: M. Fidansoy, G. San Martín, M. Pishahang, V. Vela.
Fall 2023 – UCLA
Student: Alex Lie
UCLA ID: 905901892
Task 2: Multiple Linear Regression
%}

%Beginning of code
clear
close
clc

%Part a: Mutliple Linear Regression (1985-2022)

%Importing data
data=readtable("data.xlsx");
year = data.Year;
fires = data.Fires;
acres = data.Acres;
cost = data.Cost;

%Independent variables: number of fires and burned acres
%Dependent variable: firefighting cost
disp("x1 = number of fires");
disp("x2 = burned acres");
disp("y = firefighting cost");
fprintf("\n");

%Declaring basis function matrix: Z
n = length(fires);
x1s = sum(fires);
x2s = sum(acres);

x1sq = sum(fires.^2);
x1x2 = sum(fires.*acres);
x2sq = sum(acres.^2);

Z = [n x1s x2s; x1s x1sq x1x2; x2s x1x2 x2sq];

%Declaring column vector: Y (dependent variable)
ys = sum(cost);
x1y = sum(fires.*cost);
x2y = sum(acres.*cost);

Y = [ys; x1y; x2y];

%Solving the solution of the system of linear equations: coefficients matrix C
C = inv(Z) * Y;

disp("Multiple Linear Regression (1985-2022)");
fprintf("y = %8.3f * x2 + %8.3f * x1 + %8.3f\n", C(3), C(2), C(1));
fprintf("a0 = %8.3f\n", C(1));
fprintf("a1 = %8.3f\n", C(2));
fprintf("a2 = %8.3f\n", C(3));
fprintf("\n");

%Part b: Multiple Linear Regression (1985-2020)

%Removing last 2 rows from the data
firesM= fires(1:end-2, :);
acresM = acres(1:end-2, :);
costM = cost(1:end-2, :);

%Declaring basis function matrix: Z
nM = length(firesM);
x1sM = sum(firesM);
x2sM = sum(acresM);

x1sqM = sum(firesM.^2);
x1x2M = sum(firesM.*acresM);
x2sqM = sum(acresM.^2);

ZM = [nM x1sM x2sM; x1sM x1sqM x1x2M; x2sM x1x2M x2sqM];

%Declaring column vector: Y (dependent variable)
ysM = sum(costM);
x1yM = sum(firesM.*costM);
x2yM = sum(acresM.*costM);

YM = [ysM; x1yM; x2yM];

%Solving the solution of the system of linear equations: coefficients matrix C
CM = inv(ZM) * YM;

disp("Multiple Linear Regression (1985-2020)");
fprintf("y = %8.3f * x2 + %8.3f * x1 + %8.3f\n", CM(3), CM(2), CM(1));
fprintf("a0 = %8.3f\n", CM(1));
fprintf("a1 = %8.3f\n", CM(2));
fprintf("a2 = %8.3f\n", CM(3));
fprintf("\n");

%Part c: Predicting firefighting costs when 70k fires consume 7.5 million acres
x1Val=70000; %number of fires
x2Val=7500000; %acres burned

%Using the 1985-2022 model
disp("Cost Prediction (1985-2022)");
cost_1 = C(3)*x2Val+C(2)*x1Val+C(1);
disp(cost_1);

%Using the 1985-2020 model
disp("Cost Prediction (1985-2020)");
cost_2 = CM(3)*x2Val+CM(2)*x1Val+CM(1);
disp(cost_2);

%Part d: 3D plots of regression planes

%Plotting 1985-2022 model
x1_fires = linspace(min(fires), max(fires), 100);
x2_acres = linspace(min(acres), max(acres), 100);
[x1fires, x2acres] = meshgrid(x1_fires, x2_acres);
ycost = C(3)*x2acres+C(2)*x1fires+C(1);
figure;
mesh(x1fires, x2acres, ycost);
hold on;

%Plotting 1985-2020 model
x1_firesM = linspace(min(firesM), max(firesM), 100);
x2_acresM = linspace(min(acresM), max(acresM), 100);
[x1firesM, x2acresM] = meshgrid(x1_firesM, x2_acresM);
ycostM = CM(3)*x2acresM+CM(2)*x1firesM+CM(1);
mesh(x1firesM, x2acresM, ycostM);
xlabel('x1 = Number of Fires');
ylabel('x2 = Acres Burned');
zlabel('y = Firefighting Cost');
title("Wildfire Statistics Multiple Linear Regression Model")
