%{
M20 - Introduction to Computer Programming with MATLAB
Instructor: Prof. Enrique López Droguett, Ph.D.
Teacher Assistants: M. Fidansoy, G. San Martín, M. Pishahang, V. Vela.
Fall 2023 – UCLA
Student: Alex Lie
UCLA ID: 905901892
Task 1: Re-implementing matrix operations
%}

%Beginning of code
clear
close
clc

%Declare matrix m
m =[0.5, 3, 3, 3.4;
    0.56, 4, 5, 6.5;
    1, 1, 0, 1;
    2, 2, 2.5, 2];

%Part a: Trace
c=matrix_trace(m)

%Part b: Transpose
mt=matrix_transpose(m)
