%{
M20 - Introduction to Computer Programming with MATLAB
Instructor: Prof. Enrique López Droguett, Ph.D.
Teacher Assistants: M. Fidansoy, G. San Martín, M. Pishahang, V. Vela.
Fall 2023 – UCLA
Student: Alex Lie
UCLA ID: 905901892
Task 1: General Linear Least Squares
%}

%Beginning of code
clear
close
clc

%Inputting data
t = [0.5; 1; 2; 3; 4; 5; 6; 7; 9];
P = [6; 4.4; 3.2; 2.7; 2; 1.9; 1.7; 1.4; 1.1];

%Defining the basis functions matrix
Zmatrix = [exp(-1.5.*t), exp(-0.3.*t), exp(-0.05.*t)];

%Solving for the coefficient matrix
A = (Zmatrix' * Zmatrix) \ (Zmatrix' * P);

%Outputting data
X = A(1)
Y = A(2)
Z = A(3)

%Outputting equation
fprintf("\nEquation:\n");
fprintf("P(t) = %1.4f e^(-1.5t) + %1.4f e^(-0.3t) + %1.4f e^(-0.05t)\n", X, Y, Z);