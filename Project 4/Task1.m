%{
M20 - Introduction to Computer Programming with MATLAB
Instructor: Prof. Enrique López Droguett, Ph.D.
Teacher Assistants: M. Fidansoy, G. San Martín, M. Pishahang, V. Vela.
Fall 2023 – UCLA
Student: Alex Lie
UCLA ID: 905901892
Task 1: Golden Search Method
%}

%Beginning of code
clear
close
clc

%Part a: Surface Area Function
V=2880*0.13;  %Units: ft^3
SA = @(D) pi*D^2/2+4*V/D; %Units: ft^2

%Part b: Golden Search Method
%Define variables for all 3 cases
xl=0;
xu=[1,5,10];
es=0.0001;
maxit=100;

%Golden Search Algorithm for all 3 cases
[Dmin1, SAmin1, ea1, iter1] = goldenSearch(SA, xl, xu(1), es, maxit);
[Dmin2, SAmin2, ea2, iter2] = goldenSearch(SA, xl, xu(2), es, maxit);
[Dmin3, SAmin3, ea3, iter3] = goldenSearch(SA, xl, xu(3), es, maxit);

%Putting optimized diamaters and heights for each case in a vector
Dmins = [Dmin1; Dmin2; Dmin3];
Hmins = V./(pi*(Dmins./2).^2);
Cases = [1;2;3];

%Table creation
t=table(Cases, Dmins, Hmins, 'VariableNames', {'Case', 'D (ft)', 'H (ft)'});
disp(t);

%Part c: Optimized tank diameter and height
SAmin1
SAmin2
SAmin3