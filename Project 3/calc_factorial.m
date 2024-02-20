%{
M20 - Introduction to Computer Programming with MATLAB
Instructor: Prof. Enrique López Droguett, Ph.D.
Teacher Assistants: M. Fidansoy, G. San Martín, M. Pishahang, V. Vela.
Fall 2023 – UCLA
Student: Alex Lie
UCLA ID: 905901892
Function for Task 2: Recursive Functions
%}

function f = calc_factorial(n)
%n: input number
%f: factorial of n
%This function calculates the factorial of a number.
    if mod(n,1)~=0
       f="Input must be an integer";
    elseif n < 0
        f="Input must be non-negative";
    elseif n > 1
       f=n*calc_factorial(n-1);
    else
       f=1;
    end
end