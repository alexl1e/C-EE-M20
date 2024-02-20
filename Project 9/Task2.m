%{
M20 - Introduction to Computer Programming with MATLAB
Instructor: Prof. Enrique López Droguett, Ph.D.
Teacher Assistants: M. Fidansoy, G. San Martín, M. Pishahang, V. Vela.
Fall 2023 – UCLA
Student: Alex Lie
UCLA ID: 905901892
Task 2: Sinusoidal Fit
%}

%Beginning of code
clear
close all
clc

%Part a: Fitting a sinusoid to the data
Count = [150, 180, 250, 310, 350, 360, 310, 290, 260, 210, 160, 130];
Month = linspace(15,345,12);
N = length(Count); %Number of occurances
omega = 2*pi/360; %Angular frequency (radians/time)

% Fourier coefficients
A0 = sum(Count) / N
A1 =  (2/N) * sum(Count .* cos(omega * Month))
B1 =  (2/N) * sum(Count .* sin(omega * Month))

%Part b: Plotting time vs. the number of items sold
%Creating range of values
t=1:360;
y = A0 + A1 * cos(omega * t) + B1 * sin(omega * t);

% Plot data versus fit
figure;
scatter(Month, Count, "filled");
hold on;
plot(t, y);     
title("Count vs. Time");
xlabel("Time (Days)");
ylabel("Count");
xlim([0, 365]);

%Part c: Predicting number of items sold on May 15th
May15 = 30*5-15;
Prediction = A0 + A1 * cos(omega * May15) + B1 * sin(omega * May15)
