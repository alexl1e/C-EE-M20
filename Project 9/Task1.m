%{
M20 - Introduction to Computer Programming with MATLAB
Instructor: Prof. Enrique López Droguett, Ph.D.
Teacher Assistants: M. Fidansoy, G. San Martín, M. Pishahang, V. Vela.
Fall 2023 – UCLA
Student: Alex Lie
UCLA ID: 905901892
Task 1: Taylor Series
%}

%Beginning of code
clear
close all
clc

%Part a: Creating Fourier Square Wave Function
%Located at the bottom!

%Part b: Plotting curves

%Defining variables
L=10;
deltax=0.05;
x=0:deltax:2*L;
N = [1, 3, 5, 10, 20, 50];

%Plotting f(x) and applying formatting to plot
f=2*(heaviside(x/L)-heaviside(x/L-1))-1;
figure;
plot(x, f);
grid on;
title("Fourier Series of Square Wave");
xlabel("x");
ylabel("y(x)");
legendID = cell(1,length(N)+1);
legendID{1} = 'Real Data';
hold on;

%Plotting g_N(x)
for Nval = 1:length(N) 
    g=zeros(size(x));
    for Xval = 1:length(x)
        g(Xval) = FourierSquareWave(N(Nval),L,x(Xval));
    end
    plot(x, g);
    legendID{Nval+1} = ['N = ' num2str(N(Nval))];
end

%Creating legend
legend(legendID,'location','northeast');

%Fourier Square Wave Function
function [y] = FourierSquareWave(N,L,x)
    y=0;
    for n = 0:N
        if mod(n, 2) ~= 0
            ck=4/n/pi;
        else
            ck = 0;
        end
        y = y + ck*sin(n*pi*x/L);
    end
end