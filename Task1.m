%{
M20 - Introduction to Computer Programming with MATLAB
Instructor: Prof. Enrique López Droguett, Ph.D.
Teacher Assistants: M. Fidansoy, G. San Martín, M. Pishahang, V. Vela.
Fall 2023 – UCLA
Student: Alex Lie
UCLA ID: 905901892
Task 1: Beam Analysis
%}

%Beginning of code
clear
close
clc

%Variables/Constants (Given)
L=600; %Units: cm
E=50000; %Units: kN/cm^2
I=30000; %Units: cm^4
w_0=2.5; %Units: kN/cm
deltax=2; %Units: cm

%Functions (calculated by hand)
x=0:deltax:600;
displacement=w_0/120/E/I/L*(-x.^5+2*L.^2*x.^3-L.^4*x);
slope=w_0/120/E/I/L*(-5*x.^4+6*L^2*x.^2-L^4);
moment=w_0/120/L*(-20*x.^3+12*L^2*x);
shear=w_0/120/L*(-60*x.^2+12*L.^2);
loading=w_0/L*x;

%Part a: Displacement Graph
subplot(5,1,1);
plot(x,displacement);
xlabel('Horizontal Position');
ylabel('Displacement');
title('Displacement vs. Horizontal Position');

%Part b: Slope Graph
subplot(5,1,2);
plot(x,slope);
xlabel('Horizontal Position');
ylabel('Slope');
title('Slope vs. Horizontal Position');

%Part c: Moment Graph
subplot(5,1,3);
plot(x,moment);
xlabel('Horizontal Position');
ylabel('Moment');
title('Moment vs. Horizontal Position');

%Part d: Shear Graph
subplot(5,1,4);
plot(x,shear);
xlabel('Horizontal Position');
ylabel('Shear');
title('Shear vs. Horizontal Position');

%Part e: Loading Graph
subplot(5,1,5);
plot(x,loading);
xlabel('Horizontal Position');
ylabel('Loading');
title('Loading vs. Horizontal Position');

