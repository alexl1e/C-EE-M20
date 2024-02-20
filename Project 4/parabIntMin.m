function [xopt, fxopt, x, fx, ea, iter] = parabIntMin(f, x, es, maxit, varargin)
% This function performs Parabolic Interpolation Minimization of a
% univariate function
% Input arguments:
%   f: function (handle) to be minimized
%   x: vector with three initial guesses bracking the minimum
%   es: target approximation error
%   maxit: maximum number of iterations
%   varargin: additional parameters that might be required by the function f
% Return values:
%   xopt: optimum (minimum) of x
%   fxopt: minimum function value at xopt
%   x: vector with the three x values at the last iteration (the min among
%   them is xopt
%   fx: vector with the three function values corresponding to x vector
%   ea: approximation error at xopt
%   iter: iteration number at xopt

    % Compute function values for input argument x
    fx = f(x, varargin{:});

    iter = 0;
    ea = 100;
    
    % Use & instead of && as we have scalar statement: this improves performance
    while (iter <= maxit && ea >= es)
        
        % Saves current x minimum
        fxmin = min(fx); 
        
        % Estimates new minimum x and its function value
        xopt = x(2) - (1/2) * ( ( (x(2) - x(1))^2 * (fx(2) - fx(3)) - (x(2) - x(3))^2 * (fx(2) - fx(1)) ) / ( (x(2) - x(1)) * (fx(2) - fx(3)) - (x(2) - x(3)) * (fx(2) - fx(1)) ) );
        fxopt = f(xopt, varargin{:});
    
        % Calculates the distance between the bracketing three points and
        % the new x minimum
        dist = abs(x - xopt);

        % Gets the k (= 2) minima and corresponding indices
        [val, idx] = mink(dist, 2, 'ComparisonMethod', 'auto');
        
        % Creates a column vector with new set of x values
        keep = [x(idx(1)), x(idx(2)), xopt]';
        
        % Inserts a column with corresponding function values
        keep = [keep [fx(idx(1)), fx(idx(2)), fxopt]'];
        
        % Sorts matrix in ascending order based on the x values column
        keep = sortrows(keep, 1);
        
        % Extracts (slice) the new x values (triplets) and their function values
        x = keep(:, 1)';
        fx = keep(:, 2)';

        % Estimates the approximation error based on the current and new
        % minimum function values as well as increments iterations
        ea = abs((fxmin - fxopt) / fxmin);
        iter = iter + 1;

    end
    
end