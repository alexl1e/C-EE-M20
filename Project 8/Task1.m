%{
M20 - Introduction to Computer Programming with MATLAB
Instructor: Prof. Enrique López Droguett, Ph.D.
Teacher Assistants: M. Fidansoy, G. San Martín, M. Pishahang, V. Vela.
Fall 2023 – UCLA
Student: Alex Lie
UCLA ID: 905901892
Task 1: Nonlinear Regression
%}

%Beginning of code
clear
close
clc

%Part a: Generalized nonlinear regression model

%Importing data
data = readmatrix("Enzyme_Kinetics_Data.xlsx"); 
S = data(:, 1); %Concentration of substrate; Units: μmol
v = data(:, 2); %Velocity of reaction; Units: μmol/min

%Finding values of Vmax and KM that gives the least squares
options = optimset('TolX', 1e-7, 'TolFun', 1e-7, 'MaxIter', 300);
[C]= fminsearch(@(coeff) MichaelisMentis(v, S, coeff), [1,500], options);
 
%Storing the values of KM and Vmax that minimizes the residual sum of squares
Vmax_LS = C(1)
KM_LS = C(2)

%Part b: Plotting experimental velocity data and nonlinear regression model
S_vals = 1:15000;
v_vals=Vmax_LS*S_vals./(KM_LS+S_vals);
figure;
plot(S, v, 'o', S_vals, v_vals);
xlabel("Concentration of Substrate (μmol)");
ylabel("Velocity of Reaction (μmol/min)");
title("The Michaelis-Menten Model");

%Part c: Calculating R^2
RSS = MichaelisMentis(v, S, C);
TSS = sum((v-mean(v)).^2);
R_squared = 1-(RSS/TSS)

%Part d: Analyzing R^2
%See report.pdf

%Function to find the sum of the squared residuals of the reaction velocity
function [RSS] = MichaelisMentis(v, S, coeff)
%coeff(1): Vmax - maximum velocity achieved by the system
%coeff(2): KM - Michaelis constant
    v_theoretical=coeff(1)*S./(coeff(2)+S);
    RSS = sum((v_theoretical-v).^2);
end