% Define the linear shape functions
shape_N1 = @(x, x1, x2) (x2 - x) / (x2 - x1); % Shape function N1
shape_N2 = @(x, x1, x2) (x - x1) / (x2 - x1); % Shape function N2

% Define the element's node positions
x1 = 0; % Node 1 position
x2 = 1; % Node 2 position

% Generate points between the nodes
x_vals = linspace(x1, x2, 5);

% Calculate the shape function values at each point
N1_vals = shape_N1(x_vals, x1, x2);
N2_vals = shape_N2(x_vals, x1, x2);

% Plot the shape functions
figure;
plot(x_vals, N1_vals, 'b', 'DisplayName', 'N1(x)', 'LineWidth', 2); hold on;
plot(x_vals, N2_vals, 'r', 'DisplayName', 'N2(x)', 'LineWidth', 2);
title('Linear Shape Functions N1(x) and N2(x)');
xlabel('x');
ylabel('Shape Function Value');
legend('N1(x)', 'N2(x)', 'Location', 'northeast', 'FontSize', 10);
grid on;

% Define the test functions
linear_func = @(x) 2*x + 3;
quadratic_func = @(x) x.^2 - 4*x + 6;
cubic_func = @(x) x.^3 - 2*x.^2 + x;

% Define function values at nodes
u1_linear = linear_func(x1);
u2_linear = linear_func(x2);

u1_quadratic = quadratic_func(x1);
u2_quadratic = quadratic_func(x2);

u1_cubic = cubic_func(x1);
u2_cubic = cubic_func(x2);

% Function approximation using shape functions
approx_func = @(N1, N2, u1, u2) N1 * u1 + N2 * u2;

% Approximate the functions using shape functions
linear_approx = approx_func(N1_vals, N2_vals, u1_linear, u2_linear);
quadratic_approx = approx_func(N1_vals, N2_vals, u1_quadratic, u2_quadratic);
cubic_approx = approx_func(N1_vals, N2_vals, u1_cubic, u2_cubic);

% Plot the original functions and the approximations
figure;
plot(x_vals, linear_func(x_vals), 'b--', 'DisplayName', 'Linear Function', 'LineWidth', 1.5); hold on;
plot(x_vals, linear_approx, 'b', 'DisplayName', 'Linear Approximation', 'LineWidth', 2);

plot(x_vals, quadratic_func(x_vals), 'g--', 'DisplayName', 'Quadratic Function', 'LineWidth', 1.5);
plot(x_vals, quadratic_approx, 'g', 'DisplayName', 'Quadratic Approximation', 'LineWidth', 2);

plot(x_vals, cubic_func(x_vals), 'r--', 'DisplayName', 'Cubic Function', 'LineWidth', 1.5);
plot(x_vals, cubic_approx, 'r', 'DisplayName', 'Cubic Approximation', 'LineWidth', 2);

title('Function Approximations Using Linear Shape Functions');
xlabel('x');
ylabel('Function Value');
legend('Location', 'northeast', 'FontSize', 5); % Adjust the legend size
grid on;


% Number of elements
num_elements = 6;

% Node positions
nodes = linspace(0, 6, num_elements + 1);

% Prepare figure
figure;
hold on;
grid on;
title('6 Elements with Shape Functions N1 and N2');
xlabel('Position');
ylabel('Shape Function Values');

% Plot the elements and shape functions
for i = 1:num_elements
    % Node coordinates for the current element
    x1 = nodes(i);
    x2 = nodes(i+1);
    
    % Linear shape functions
    N1 = @(x) (x2 - x) / (x2 - x1);  % Shape function N1
    N2 = @(x) (x - x1) / (x2 - x1);  % Shape function N2
    
    % Plot the element line
    plot([x1, x2], [0, 0], 'k', 'LineWidth', 2);
    
    % Plot N1 and N2 over the element
    fplot(N1, [x1, x2], 'b-', 'LineWidth', 1.5);  % N1 is linear, starts from 1 at x1 to 0 at x2
    fplot(N2, [x1, x2], 'r-', 'LineWidth', 1.5);  % N2 is linear, starts from 0 at x1 to 1 at x2
    
    % Mark the nodes
    plot(x1, 0, 'ko', 'MarkerFaceColor', 'k');
    plot(x2, 0, 'ko', 'MarkerFaceColor', 'k');
    
    % Text labels for shape functions at each node
    text(x1, 0.1, 'N1', 'Color', 'b', 'HorizontalAlignment', 'center');
    text(x2, 0.1, 'N2', 'Color', 'r', 'HorizontalAlignment', 'center');
end

% Limits and formatting
xlim([nodes(1)-0.5, nodes(end)+0.5]);
ylim([-0.1, 1.1]);
legend('Element', 'N1 (Shape Function)', 'N2 (Shape Function)', 'Location', 'Best');
hold off;


