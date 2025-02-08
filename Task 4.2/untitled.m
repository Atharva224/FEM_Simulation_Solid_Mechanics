% Define the derivative of the linear shape functions
dN1 = @(x1, x2) -1 / (x2 - x1);  % Derivative of N1(x) with respect to x
dN2 = @(x1, x2)  1 / (x2 - x1);  % Derivative of N2(x) with respect to x

% Define the element's node positions
x1 = 0; % Node 1 position
x2 = 1; % Node 2 position

% Generate points between the nodes
x_vals = linspace(x1, x2, 5);

% Compute the constant derivatives of shape functions (since they are linear)
dN1_vals = dN1(x1, x2) * ones(size(x_vals));  % Constant derivative for N1
dN2_vals = dN2(x1, x2) * ones(size(x_vals));  % Constant derivative for N2

% Plot the derivatives of shape functions
figure;
plot(x_vals, dN1_vals, 'b', 'DisplayName', 'dN1/dx', 'LineWidth', 2); hold on;
plot(x_vals, dN2_vals, 'r', 'DisplayName', 'dN2/dx', 'LineWidth', 2);
title('Derivatives of Linear Shape Functions N1(x) and N2(x)');
xlabel('x');
ylabel('Shape Function Derivative Value');
legend('dN1/dx', 'dN2/dx', 'Location', 'northeast', 'FontSize', 10);
grid on;

% Define the test functions and their derivatives
linear_func = @(x) 2*x + 3;
quadratic_func = @(x) x.^2 - 4*x + 6;
cubic_func = @(x) x.^3 - 2*x.^2 + x;

linear_func_derivative = @(x) 2;  % Derivative of 2*x + 3 is constant 2
quadratic_func_derivative = @(x) 2*x - 4;  % Derivative of x^2 - 4*x + 6
cubic_func_derivative = @(x) 3*x.^2 - 4*x + 1;  % Derivative of cubic function

% Nodal values of functions' derivatives at nodes
u1_linear_deriv = linear_func_derivative(x1);
u2_linear_deriv = linear_func_derivative(x2);

u1_quadratic_deriv = quadratic_func_derivative(x1);
u2_quadratic_deriv = quadratic_func_derivative(x2);

u1_cubic_deriv = cubic_func_derivative(x1);
u2_cubic_deriv = cubic_func_derivative(x2);

% Function approximation using shape function derivatives
approx_deriv = @(dN1, dN2, u1, u2) dN1 * u1 + dN2 * u2;

% Approximate the derivatives using shape functions
linear_deriv_approx = approx_deriv(dN1_vals, dN2_vals, u1_linear_deriv, u2_linear_deriv);
quadratic_deriv_approx = approx_deriv(dN1_vals, dN2_vals, u1_quadratic_deriv, u2_quadratic_deriv);
cubic_deriv_approx = approx_deriv(dN1_vals, dN2_vals, u1_cubic_deriv, u2_cubic_deriv);

% Plot the original function derivatives and the approximations
figure;
plot(x_vals, linear_func_derivative(x_vals), 'b--', 'DisplayName', 'Linear Function Derivative', 'LineWidth', 1.5); hold on;
plot(x_vals, linear_deriv_approx, 'b', 'DisplayName', 'Linear Derivative Approximation', 'LineWidth', 2);

plot(x_vals, quadratic_func_derivative(x_vals), 'g--', 'DisplayName', 'Quadratic Function Derivative', 'LineWidth', 1.5);
plot(x_vals, quadratic_deriv_approx, 'g', 'DisplayName', 'Quadratic Derivative Approximation', 'LineWidth', 2);

plot(x_vals, cubic_func_derivative(x_vals), 'r--', 'DisplayName', 'Cubic Function Derivative', 'LineWidth', 1.5);
plot(x_vals, cubic_deriv_approx, 'r', 'DisplayName', 'Cubic Derivative Approximation', 'LineWidth', 2);

title('Function Derivative Approximations Using Linear Shape Function Derivatives');
xlabel('x');
ylabel('Function Derivative Value');
legend('Location', 'northeast', 'FontSize', 5);  % Adjust the legend size
grid on;
