%{
M20 - Introduction to Computer Programming with MATLAB
Instructor: Prof. Enrique López Droguett, Ph.D.
Teacher Assistants: M. Fidansoy, G. San Martín, M. Pishahang, V. Vela.
Fall 2023 – UCLA
Student: Alex Lie
UCLA ID: 905901892
Task 2: Surface Areas in the Solar System
%}

%Beginning of code
clear
close
clc

%Variables
Planet=["Mercury"; "Venus"; "Earth"; "Mars"; "Jupiter"; "Saturn"; "Uranus"; "Neptune"];
r1=[2440.5; 6051.8; 6378.1; 3396.2; 71492; 60268; 25559; 24764]; %Equatorial Radius; Units: km
r2=[2438.3; 6051.8; 6371; 3376.2; 66854.4; 54364; 24973; 24341]; %Polar Radius; Units: km
gamma= acos(r2./r1); %Value of gamma
TSA = 2.*pi.*(r1.^2+r2.^2./sin(gamma).*log(cos(gamma)./(1-sin(gamma)))); %True Surface Area; Units: km^2
ASA = 4.*pi.*((r1+r2)./2).^2; %Approximate Surface Area; Units: km^2

%Table creation
t=table(Planet, r1, r2, TSA, ASA, 'VariableNames', {'Planet','Equatorial Radius r1 [km]', 'Polar Radius r2 [km]', 'True Surafce Area [km^2]', 'Approximate Surafce Area [km^2]'});
disp(t);

