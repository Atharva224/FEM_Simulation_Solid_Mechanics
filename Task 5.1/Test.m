% Define the integration limits
x1 = 0;  % Starting point of the interval
x2 = 1;  % Ending point of the interval

% Define the number of points (trapezoidal rule uses 2 points)
n = 2;

% Define the integration points and weights for the trapezoidal rule
zeta = [x1, x2];  % Integration points (start and end points)
lambda = [0.5, 0.5];  % Weights for trapezoidal rule

% Call the quadrature function
result = quadrature(x1, x2, n, lambda, zeta);

% Display the result
disp(['Result of integration: ', num2str(result)]);
