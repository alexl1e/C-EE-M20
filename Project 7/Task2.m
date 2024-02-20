%{
M20 - Introduction to Computer Programming with MATLAB
Instructor: Prof. Enrique López Droguett, Ph.D.
Teacher Assistants: M. Fidansoy, G. San Martín, M. Pishahang, V. Vela.
Fall 2023 – UCLA
Student: Alex Lie
UCLA ID: 905901892
Task 2: Polynomial Regression
%}

%Beginning of code
clear
close
clc

%Part a: Creating our models

%Inputting data
v = [15; 25; 35; 40; 50; 65; 75; 80]; %Velocity in m/s
f = [55; 250; 470; 550; 610; 1000; 900; 1450]; %Force in N

%Defining the basis functions matrix
Zmatrix = [v, v.^2, v.^3];

%Solving for the coefficient matrix
A = (Zmatrix' * Zmatrix) \ (Zmatrix' * f);

%Outputting data
a = A(1)
b = A(2)
c = A(3)
d = 0

%Part b: Testing our model

%Creating a range of values for velocity and force
v_n = linspace(min(v)-5, max(v)+5, 100);
f_n = a*v_n+b*v_n.^2+c*v_n.^3+d;

%Plotting our linear regression and the original data points
figure;
plot(v, f, "o", v_n, f_n, 'linewidth', 2);
xlabel("Velocity (m/s)");
ylabel("Force (N)");
xlim([min(v)-5, max(v)+5]);
title("Force vs. Velocity of Water Flow from a Pump");
