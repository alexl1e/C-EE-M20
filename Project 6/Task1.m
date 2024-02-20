%{
M20 - Introduction to Computer Programming with MATLAB
Instructor: Prof. Enrique López Droguett, Ph.D.
Teacher Assistants: M. Fidansoy, G. San Martín, M. Pishahang, V. Vela.
Fall 2023 – UCLA
Student: Alex Lie
UCLA ID: 905901892
Task 1: Linear Regression
%}

%Beginning of code
clear
close
clc

%Part a: Three Distinct Linear Regressions

%Importing data
data=readtable("data.xlsx");
year = data.Year;
fires = data.Fires;
acres = data.Acres;
cost = data.Cost;

%Running linear regressions

%Fire vs. Year
[a_f, r2_f, Ystd_f, Syx_f] = linReg(year, fires);
disp("Fires vs. Year");
fprintf("y = %8.3f * x + %8.3f\n", a_f(1), a_f(2));
fprintf("r-squared = %8.6f\n", r2_f);
fprintf("\n");

%Acres vs. Year
[a_a, r2_a, Ystd_a, Syx_a] = linReg(year, acres);
disp("Acres vs. Year");
fprintf("y = %8.3f * x + %8.3f\n", a_a(1), a_a(2));
fprintf("r-squared = %8.6f\n", r2_a);
fprintf("\n");

%Cost vs. Year
[a_c, r2_c, Ystd_c, Syx_c] = linReg(year, cost);
disp("Cost vs. Year");
fprintf("y = %8.3f * x + %8.3f\n", a_c(1), a_c(2));
fprintf("r-squared = %8.6f\n", r2_c);

%Creating plots
x_year=linspace(year(1), year(end), 100);
y_fires=a_f(1)*x_year+a_f(2);
y_acres=a_a(1)*x_year+a_a(2);
y_cost=a_c(1)*x_year+a_c(2);

%Fire vs. Year
figure;
subplot(3,1,1);
plot(year, fires, 'o', x_year, y_fires, 'linewidth', 1);
title("Fires vs. Year");
xlabel("Year");
ylabel("Fires");
xlim([year(1), year(end)]);

%Acres vs. Year
subplot(3,1,2);
plot(year, acres, 'o', x_year, y_acres, 'linewidth', 1);
title("Acres vs. Year");
xlabel("Year");
ylabel("Acres");
xlim([year(1), year(end)]);

%Cost vs. Year
subplot(3,1,3);
plot(year, cost, 'o', x_year, y_cost, 'linewidth', 1);
title("Cost vs. Year");
xlabel("Year");
ylabel("Cost");
xlim([year(1), year(end)]);

%Predicting values in 2025
fires_2025=a_f(1)*2025+a_f(2)
acres_2025=a_a(1)*2025+a_a(2)
cost_2025=a_c(1)*2025+a_c(2)

%Part b: Cost vs. Acres Linear Regression (1985-2022)

%Running linear regression
[a_1, r2_1, Ystd_1, Syx_1] = linReg(acres, cost);
disp("Cost vs. Acres (1985-2022)");
fprintf("y = %8.3f * x + %8.3f\n", a_1(1), a_1(2));
fprintf("r-squared = %8.6f\n", r2_1);
fprintf("\n");

%Creating plot
x_acres1=linspace(min(acres), max(acres), 100);
y_cost1=a_1(1)*x_acres1+a_1(2);
figure;
plot(acres, cost, 'o', x_acres1, y_cost1, 'linewidth', 1);
title("Cost vs. Acres (1985-2022)");
xlabel("Acres");
ylabel("Cost");
xlim([min(acres), max(acres)]);

%Predicting cost when 7.5 million acres are consumed
cost1_prediction=a_1(1)*75000001+a_1(2)

%Part c: Cost vs. Acres Linear Regression (1985-2020)

%Removing last 2 rows from the acres and cost data
acres2 = acres(1:end-2, :);
cost2 = cost(1:end-2, :);

%Running linear regression
[a_2, r2_2, Ystd_2, Syx_2] = linReg(acres2, cost2);
disp("Cost vs. Acres (1985-2020)");
fprintf("y = %8.3f * x + %8.3f\n", a_2(1), a_2(2));
fprintf("r-squared = %8.6f\n", r2_2);
fprintf("\n");

%Creating plot
x_acres2=linspace(min(acres2), max(acres2), 100);
y_cost2=a_2(1)*x_acres2+a_2(2);
figure;
plot(acres2, cost2, 'o', x_acres2, y_cost2, 'linewidth', 1);
title("Cost vs. Acres (1985-2020)");
xlabel("Acres");
ylabel("Cost");
xlim([min(acres2), max(acres2)]);

%Predicting cost when 7.5 million acres are consumed
cost2_prediction=a_2(1)*75000001+a_2(2)

%Linear Regression Function (from lecture)
function [a, r2, Ystd, Syx] = linReg(X, Y)

    % Mean of X
    Xmean = mean(X);

    % Mean of Y
    Ymean = mean(Y);

    % Sample size
    n = length(X);

    % Squares of residuals in relation to the mean
    St = sum( (Y - Ymean).^2 );

    % Standard deviation of Y
    Ystd = sqrt( St / (n - 1) );

    % Sum of X
    Xsum = sum( X );

    % Sum of Y
    Ysum = sum( Y );

    % Sum of Y^2
    Y2sum = sum( Y.^2 );

    % Sum of X^2
    X2sum = sum( X.^2);

    % Sum of XY
    XYsum = sum( X .* Y);

    % Slope estimate
    a(1) = ( n * XYsum - Xsum * Ysum  ) / ( n * X2sum - Xsum^2 );

    % Intercept estimate
    a(2) = Ymean - a * Xmean;
    
    % Coefficient of determinaton
    r2 = ( (n * XYsum - Xsum * Ysum) / (sqrt(n * X2sum - Xsum^2) * sqrt(n * Y2sum - Ysum^2)) ) ^ 2;

    % Alternatively, r2 can be obtained from the standard deviation around
    % mean of Y and standard error of Y around the regression line:

    % Squares of residuals for the regression
    Sr = sum( (Y - a(2) - a(1) * X).^2 );

    % Standard error of Y around regression line
    Syx = sqrt( Sr / (n - 2) );

    % Coeff of determination is
    % r2 = (St - Sr) / St;
    
end