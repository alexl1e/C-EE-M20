%{
M20 - Introduction to Computer Programming with MATLAB
Instructor: Prof. Enrique López Droguett, Ph.D.
Teacher Assistants: M. Fidansoy, G. San Martín, M. Pishahang, V. Vela.
Fall 2023 – UCLA
Student: Alex Lie
UCLA ID: 905901892
Function for Task 2: Recursive Functions
%}

function f = calc_fibonacci(n)
%n: input number
%f: nth number in the Fibonacci sequence
%This function that generates the nth number in the Fibonacci sequence.
    if mod(n,1)~=0
        f="Input must be an integer";
    elseif n<0
        f="Input must be non-negative";
    elseif n==0
          f=0;
    elseif n==1
          f=1;
    else
        f=calc_fibonacci(n-1)+calc_fibonacci(n-2);
    end
end