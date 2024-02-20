%{
M20 - Introduction to Computer Programming with MATLAB
Instructor: Prof. Enrique López Droguett, Ph.D.
Teacher Assistants: M. Fidansoy, G. San Martín, M. Pishahang, V. Vela.
Fall 2023 – UCLA
Student: Alex Lie
UCLA ID: 905901892
Function for Task 1: Re-implementing matrix operations
%}

function [c] = matrix_trace(m)
%m: 𝑁 × 𝑁 matrix (input matrix)
%c: number (trace of the input matrix)
%This function computes the trace of the input matrix.
    %Check if input is a matrix
    if ~ismatrix(m)
        c="Input is not a matrix";
    %Check if input is a square matrix
    elseif size(m,1)~=size(m,2)
        c="Input is not a square matrix";
    %Calcuate the trace of the matrix
    else
        c=0;
        for i= 1:width(m)
            c = c+m(i,i);
        end
    end
end
