%{
M20 - Introduction to Computer Programming with MATLAB
Instructor: Prof. Enrique López Droguett, Ph.D.
Teacher Assistants: M. Fidansoy, G. San Martín, M. Pishahang, V. Vela.
Fall 2023 – UCLA
Student: Alex Lie
UCLA ID: 905901892
Task 2: Optimization over 3 variables 
%}

%Beginning of code
clear
close
clc

%Declaring variables
%k value units: N/m
k1=5000;
k2=1500;
k3=2000;
k4=1000;
k5=2500;
k6=500;
k7=3000;
k8=3500;
%P value units: N
P1=1000;
P2=2000;
P3=3000;

%Declaring matricies
K=  [k1+k4+k5, -k4, -k5;
    -k4, k2+k4+k6, -k6;
    -k5, -k6, k3+k5+k6+k7+k8];
P= [P1;
    P2;
    P3];

%Defining functions
fX1 = @(X) 1/2*[X(1); X(2); X(3)].'*K*[X(1); X(2); X(3)]-[X(1); X(2); X(3)].'*P;
fX2 = @(X1, X2, X3) 1/2*[X1; X2; X3].'*K*[X1; X2; X3]-[X1; X2; X3].'*P;

%Declaring variables for gradOpt3D function
X0= [0,0,0]; %Initial point
r = [-1e-4, -1e-4, -1e-4]; %Learning rate for minimization
tol = 1e-3; %Prescribed tolerance
imax = 100; %Maximum number of iterations

%Gradient Decent
tic
[xoptM1, fxoptM1, pointsM1, eaM1, iterM1] = gradOpt3D(fX1, X0, r, tol, imax);
xoptM1
toc

%Declaring variables for gridsearch3d function
lowerlim = -1;
upperlim = 1;
N = 100;

%Grid Search Method
tic
[xoptM2, fxoptM2] = gridsearch3d(fX2, lowerlim, upperlim, N);
xoptM2
toc

%gradOpt3D function (modified from the gradOpt2D function from lecture)
function [xopt, fxopt, x, ea, iter] = gradOpt3D(f, x0, r, tol, itermax, varargin)

    % x0 and r are vectors with the inital estimates for x1, x2, and x3 and the
    % corresponding step sizes for each direction

    % Notation for each independent variable column position: column 1 =
    % x1, column 2 = x2, and column 3 = x3
    x1 = 1;
    x2 = 2;
    x3 = 3;
    z = 4;

    % x1
    x(1, x1) = x0(x1) - 1e-6;
    x(2, x1) = x0(x1);

    % x2
    x(1, x2) = x0(x2) - 1e-6;
    x(2, x2) = x0(x2);

    % x3
    x(1, x3) = x0(x3) - 1e-6;
    x(2, x3) = x0(x3);

    % z
    x(1, z) = f([x(1, x1), x(1, x2), x(1, x3)], varargin{:});
    x(2, z) = f([x(2, x1), x(2, x2), x(2, x3)], varargin{:});

    iter = 2;
    ea = 100;
    
    while (iter <= itermax)

        xca = [x(iter, x1), x(iter - 1, x2), x(iter - 1, x3)];
        xc = [x(iter - 1, x1), x(iter - 1, x2), x(iter - 1, x3)];
        fprime_x1 = ( f(xca, varargin{:}) - f(xc, varargin{:}) ) / ( x(iter, x1) - x(iter - 1, x1) );
        x(iter + 1, x1) = x(iter, x1) + r(x1) * fprime_x1;

        xca = [x(iter - 1, x1), x(iter, x2), x(iter - 1, x3)];
        fprime_x2 = ( f(xca, varargin{:}) - f(xc, varargin{:}) ) / ( x(iter, x2) - x(iter - 1, x2) );
        x(iter + 1, x2) = x(iter, x2) + r(x2) * fprime_x2;

        xca = [x(iter - 1, x1), x(iter - 1, x2), x(iter, x3)];
        fprime_x3 = ( f(xca, varargin{:}) - f(xc, varargin{:}) ) / ( x(iter, x3) - x(iter - 1, x3) );
        x(iter + 1, x3) = x(iter, x3) + r(x3) * fprime_x3;

        x(iter + 1, z) = f([x(iter + 1, x1), x(iter + 1, x2), x(iter + 1, x3)], varargin{:});

        if x(iter) ~= 0
            ea(x1) = abs( (x(iter, x1) - x(iter + 1, x1)) / x(iter, x1) );
            ea(x2) = abs( (x(iter, x2) - x(iter + 1, x2)) / x(iter, x2) );
            ea(x3) = abs( (x(iter, x3) - x(iter + 1, x3)) / x(iter, x3) );
        end
%{
        if iter <= 2
            fprintf("Iteration\t X1\t          X2\t       X3\t\t        Error X1\t    Error X2\t    Error X3\n")
            fprintf("%6u\t %12.6f %12.6f %12.6f\n", iter - 1, x(iter - 1, x1), x(iter - 1, x2), x(iter - 1, x3))
            fprintf("%6u\t %12.6f %12.6f %12.6f\n", iter, x(iter, x1), x(iter, x2), x(iter, x3))
        else
            fprintf("%6u\t %12.6f %12.6f %12.6f \t%12.6f \t%12.6f \t%12.6f\n", iter, x(iter, x1), x(iter, x2), x(iter, x3), ea(x1), ea(x2), ea(x3));
        end
%}
        if( ea(x1) < tol && ea(x2) < tol && ea(x3) < tol )
            break
        end

        iter = iter + 1;

    end

    xopt = x(iter - 1, x1:x3);
    xc = [xopt(x1), xopt(x2), xopt(x3)];
    fxopt = f(xc, varargin{:});

end

%gridsearch3d function (modified from the gridsearch2d function from discussion)
function [X_OPT, F_Min] = gridsearch3d(func, lim_1, lim_2, N)

    dim1 = linspace(lim_1, lim_2, N);
    dim2 = linspace(lim_1, lim_2, N);
    dim3 = linspace(lim_1, lim_2, N);
    
    [ca, cb, cc] = ndgrid(dim1, dim2, dim3);
    combs = [ca(:), cb(:), cc(:)];
    
    for i = 1:length(combs)
        F_EVAL(i) = func(combs(i,1), combs(i,2), combs(i,3));
    end
    
    [F_Min, index] = min(F_EVAL);
    
    X_OPT = combs(index, :);

end
