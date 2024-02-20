%{
M20 - Introduction to Computer Programming with MATLAB
Instructor: Prof. Enrique López Droguett, Ph.D.
Teacher Assistants: M. Fidansoy, G. San Martín, M. Pishahang, V. Vela.
Fall 2023 – UCLA
Student: Alex Lie
UCLA ID: 905901892
Function for Task 1: Re-implementing matrix operations
%}

function [mt] = matrix_transpose(m)
%m: 𝑁 × 𝑀 matrix (input matrix)
%mt: 𝑀 × 𝑁 matrix (transpose of the input matrix)
%This function computes the transpose of the input matrix.
    %Check if input is a matrix
    if ~ismatrix(m)
            mt="Input is not a matrix";
            return
    end
    %Calculate the transpose of the input matrix
    mt=zeros(size(m,2),size(m,1));
    for i=1:size(mt,1)
        for j=1:size(mt,2)
            mt(i,j)=m(j,i);
        end
    end
end
