%{
M20 - Introduction to Computer Programming with MATLAB
Instructor: Prof. Enrique López Droguett, Ph.D.
Teacher Assistants: M. Fidansoy, G. San Martín, M. Pishahang, V. Vela.
Fall 2023 – UCLA
Student: Alex Lie
UCLA ID: 905901892
Task 3: Linearization
%}

%Beginning of code
clear
close
clc

%Part a: Creating function to solve linear regression models
%Function is located at the bottom of the code.

%Inputting the data
x_d = [1; 2; 3; 4; 5];
y_d = [0.5; 0.8; 1.1; 3; 4];

%Transforming the data
y_log = log(y_d);

%Declaring the basis functions row vector
functions = {@(x) 1, @(x) x};%Must use function handles!

%Running the general linear regression function
A = generalLinearRegression(x_d, y_log, functions);

%Calculating the values of a and b
%A(1) = ln(a/(20*b))
%A(2) = b
b = A(2)
a = 20*b*exp(A(1))

%Part b: Linearizing the model
fprintf("\nLinear Model:\nln(y) = %3.4f + %3.4fx\n", A(1), A(2));

%Plotting the linearized data points and equation
x_vals = linspace(min(x_d)-1, max(x_d)+1, 100);
y_vals= A(1)+A(2).*x_vals;
plot(x_d, y_log, 'X', x_vals, y_vals, 'linewidth', 1.5);
xlabel("x");
ylabel("ln(y)");
title("Linearized Model of y=(a/(20*b))*e^(^b^*^x^)");

%General linear regression function for part a.
function [A] = generalLinearRegression(x, y, functions)
%x: column vector of independent variable data
%y: column vector of dependent variable data
%b: row vector of basis function 
Z=zeros(length(x), length(functions));
    for i = 1:size(Z,1)
        for j = 1:size(Z,2)
            Z(i,j) = functions{j}(x(i));
        end
    end
    A = (Z' * Z) \ (Z' * y);
end