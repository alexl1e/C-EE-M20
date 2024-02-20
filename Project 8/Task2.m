%{
M20 - Introduction to Computer Programming with MATLAB
Instructor: Prof. Enrique López Droguett, Ph.D.
Teacher Assistants: M. Fidansoy, G. San Martín, M. Pishahang, V. Vela.
Fall 2023 – UCLA
Student: Alex Lie
UCLA ID: 905901892
Task 2: Multivariate Nonlinear Regression
%}

%Beginning of code
clear
close
clc

%Part a: Multivariate nonlinear regression model (2 independent variables)

%Importing data
data = readmatrix("MVR_Data.xlsx");
D=data(:,1);
W=data(:,2);
H=data(:,3);
Y=data(:,4);
    
%Setting W to 6 for the first case
W_c=6;

%Finding values of coefficients a, b, c, and d that gives the least squares in the first case
options = optimset('TolX', 1e-7, 'TolFun', 1e-7, 'MaxIter', 300);
C1 = fminsearch(@(coeff) Yfunction(Y, D, W_c, H, coeff), [4, .4, .4, 330], options);

%Outputting the values of the coefficients in the first case
a_1 = C1(1)
b_1 = C1(2)
c_1 = C1(3)
d_1 = C1(4)

%Part b: Plotting datapoints and nonlinear model (2 independent variables)

%Creating range of values for D and H
Dvec = linspace(min(D), max(D), 100);
Hvec = linspace(min(H), max(H), 100);

%Turning range of values into matricies
[Dmesh, Hmesh] = meshgrid(Dvec, Hvec);

%Solving for Y for each combination of D and H in the first case
Ymesh1 = Dmesh.^a_1*W_c^b_1.*Hmesh.^c_1+d_1;

%Plotting data points and graph of the first case
figure;
scatter3(D, H, Y);
hold on;
mesh(Dmesh, Hmesh, Ymesh1);
xlabel("D");
ylabel("H");
zlabel("Y");
title("Multivariate Nonlinear Regression Model");

%Part c: Multivariate nonlinear regression model (3 independent variables)

%Finding values of coefficients a, b, c, and d that gives the least squares in the second case
C2 = fminsearch(@(coeff) Yfunction(Y, D, W, H, coeff), [4, .2, .5, 384], options);

%Outputting the values of the coefficients in the second case
a_2 = C2(1)
b_2 = C2(2)
c_2 = C2(3)
d_2 = C2(4)

%Part d: Variable relationship between input and ouput
%See report.pdf

%Function to find the sum of the squared residuals of Y  
function [RSS] = Yfunction(Y, D, W, H, coeff)
%coeff(1): a
%coeff(2): b
%coeff(3): c
%coeff(4): d
    Y_model=D.^coeff(1).*W.^coeff(2).* H.^coeff(3)+coeff(4);
    RSS = sum((Y_model-Y).^2);
end