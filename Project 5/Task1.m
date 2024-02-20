%{
M20 - Introduction to Computer Programming with MATLAB
Instructor: Prof. Enrique López Droguett, Ph.D.
Teacher Assistants: M. Fidansoy, G. San Martín, M. Pishahang, V. Vela.
Fall 2023 – UCLA
Student: Alex Lie
UCLA ID: 905901892
Task 1: Gradient descent visualization over 2 variables
%}

%Beginning of code
clear
close
clc

%Defining the function
fx= @(x) 0.6382*x(1).^2+0.3191*x(2).^2-0.2809*x(1).*x(2)-67.906*x(1)-14.290*x(2);
fx_mesh= @(x1, x2) 0.6382*x1.^2+0.3191*x2.^2-0.2809*x1.*x2-67.906*x1-14.290*x2;

%Creating x, y, and z coordinates
x = linspace(20, 145, 100);
y = linspace(20, 145, 100);
[X, Y] = meshgrid(x, y);
Z = fx_mesh(X, Y);

%Creating contour graph
figure;
cs = contourf(X, Y, Z, 20);
xlabel("Temperature at Point 1, Middle of Fin (C°)");
ylabel("Temperature at Point 2, end of Fin (C°)");
title("Temperature Contour Plot of Aluminum Fin");
grid;

%Declaring variables for gradOpt2D function
r = [-0.1, -0.1]; %Learning rate for minimization
S1=[30, 30]; %Initial point #1
S2=[135, 135]; %Initial point #2
tol = 1e-3; %Prescribed tolerance
imax = 1000; %Maximum number of iterations

%Calling gradOpt2D function twice for both initial positions
[xopt1, fxopt1, points1, ea1, iter1] = gradOpt2D(fx, S1, r, tol, imax);
fprintf("Optimum x starting at s1 = [%8.4f %8.4f]\nf(x) starting at S1 = %8.4f", xopt1(1), xopt1(2), fxopt1);
fprintf('\n')
[xopt2, fxopt2, points2, ea2, iter2] = gradOpt2D(fx, S2, r, tol, imax);
fprintf("Optimum x starting at s2 = [%8.4f %8.4f]\nf(x) starting at S2 = %8.4f", xopt2(1), xopt2(2), fxopt2);
fprintf('\n')

% Plot the path of points on contour
hold on;
plot(points1(:,1), points1(:,2), 'r->');
plot(points2(:,1), points2(:,2), 'g-o');

%gradOpt2D function (from class)
function [xopt, fxopt, x, ea, iter] = gradOpt2D(f, x0, r, tol, itermax, varargin)

    % x0 and r are vectors with the inital estimates for x1 and x2 and the
    % corresponding step sizes for each direction

    % Notation for each independent variable column position: column 1 =
    % x1, and column 2 = x2
    x1 = 1;
    x2 = 2;
    z = 3;

    % x1
    x(1, x1) = x0(x1) - 1e-6;
    x(2, x1) = x0(x1);

    % x2
    x(1, x2) = x0(x2) - 1e-6;
    x(2, x2) = x0(x2);

    % z
    x(1, z) = f([x(1, x1), x(1, x2)], varargin{:});
    x(2, z) = f([x(2, x1), x(2, x2)], varargin{:});


    iter = 2;
    ea = 100;
    
    while (iter <= itermax)

        xca = [x(iter, x1), x(iter - 1, x2)];
        xc = [x(iter - 1, x1), x(iter - 1, x2)];
        fprime_x1 = ( f(xca, varargin{:}) - f(xc, varargin{:}) ) / ( x(iter, x1) - x(iter - 1, x1) );
        x(iter + 1, x1) = x(iter, x1) + r(x1) * fprime_x1;

        xca = [x(iter - 1, x1), x(iter, x2)];
        fprime_x2 = ( f(xca, varargin{:}) - f(xc, varargin{:}) ) / ( x(iter, x2) - x(iter - 1, x2) );
        x(iter + 1, x2) = x(iter, x2) + r(x2) * fprime_x2;

        x(iter + 1, z) = f([x(iter + 1, x1), x(iter + 1, x2)], varargin{:});

        if x(iter) ~= 0
            ea(x1) = abs( (x(iter, x1) - x(iter + 1, x1)) / x(iter, x1) );
            ea(x2) = abs( (x(iter, x2) - x(iter + 1, x2)) / x(iter, x2) );
        end
%{
        if iter <= 2
            fprintf("Iteration\t X1\t    X2\t\tError X1\tError X2\n")
            fprintf("%6u\t %12.6f %12.6f\n", iter - 1, x(iter - 1, x1), x(iter - 1, x2))
            fprintf("%6u\t %12.6f %12.6f\n", iter, x(iter, x1), x(iter, x2))
        else
            fprintf("%6u\t %12.6f %12.6f \t%12.6f \t%12.6f\n", iter, x(iter, x1), x(iter, x2), ea(x1), ea(x2))
        end
%}
        if( ea(x1) < tol && ea(x2) < tol )
            break
        end

        iter = iter + 1;

    end

    xopt = x(iter - 1, x1:x2);
    xc = [xopt(x1), xopt(x2)];
    fxopt = f(xc, varargin{:});

end