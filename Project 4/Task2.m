%{
M20 - Introduction to Computer Programming with MATLAB
Instructor: Prof. Enrique López Droguett, Ph.D.
Teacher Assistants: M. Fidansoy, G. San Martín, M. Pishahang, V. Vela.
Fall 2023 – UCLA
Student: Alex Lie
UCLA ID: 905901892
Task 2: Parabolic interpolation Optimization
%}

%Beginning of code
clear
close
clc

%Part a: Minimum drag force and velocity
%Constants and variables
rho=0.6; %Unitless
W=17500; %Units: lbs

%Funtion for drag force
Fd = @(V, rho, W) 0.01*rho*V.^2+0.95/rho*(W./V).^2;

% Setting the approximation error and maximum number of iterations
es = 1e-4;
maxit = 100;
Vl=1;
Vu=1200;
Vguesses = [Vl, (Vu+Vl)/2, Vu];

%Finding the minimum velocity and drag force
[Vmin, Fdmin, last3V, last3Fd, ea, iter]=parabIntMin(Fd,Vguesses, es, maxit, rho, W);
Vmin
Fdmin

%Part b: Plotting graphs
V=Vl:1:Vu;
figure;
plot(V, Fd(V, rho, W), 'k'); 
hold on;
plot(Vmin, Fdmin, "*r");
legend("Drag Force Equation", "Minimum Drag Force")
xlim([0,1200]);
ylim([3250, 100000]);
xlabel('Velocity');
ylabel('Drag Force');
title('Drag Force vs. Velocity (Weight = 17,500 lbs)');

%{
%This graph is the parabola that was used as the last approximation to find the
%minimum value of the drag force (not a part of the assignment).
[a,b,c]=parabInterp(last3V, last3Fd);
parab = @(x) a*x.^2+b*x+c;
hold on;
plot(V, parab(V), 'b');
legend("Drag Force Equation", "Minimum Drag Force", "Approximate Drag Force")
%}

%Part c: Modifying weight
Wrange=15000:500:20000;
A=zeros(2,length(Wrange));
for i=1:length(Wrange)
    [A(1,i), A(2,i)]=parabIntMin(Fd,Vguesses, es, maxit, rho, Wrange(i));
end
figure;
scatter(A(1,:), A(2,:));
xlabel('Velocity');
ylabel('Drag Force');
title('Minimum Drag Forces with Varying Weights');

%Part d: Change in optimal drag force and velocity as weight increases
%On report.pdf
