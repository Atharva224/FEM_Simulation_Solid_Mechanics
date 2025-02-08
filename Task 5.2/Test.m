% Define polynomials to test
f1 = @(x) x;        % Linear polynomial
f2 = @(x) x.^2;     % Quadratic polynomial
f3 = @(x) x.^3;     % Cubic polynomial
f4 = @(x) x.^4;     % Quartic polynomial

% Integration limits
x1 = 0;
x2 = 1;

% Test for each polynomial using different integration schemes
disp('Trapezoidal Rule (n=2):')
disp(['Linear: ', num2str(untitled(x1, x2, 2, f1))]);  % Should be exact
disp(['Quadratic: ', num2str(untitled(x1, x2, 2, f2))]); % Not exact
disp(['Cubic: ', num2str(untitled(x1, x2, 2, f3))]);     % Not exact
disp(['Quartic: ', num2str(untitled(x1, x2, 2, f4))]);   % Not exact

disp('Simpson''s Rule (n=3):')
disp(['Linear: ', num2str(untitled(x1, x2, 3, f1))]);  % Should be exact
disp(['Quadratic: ', num2str(untitled(x1, x2, 3, f2))]); % Should be exact
disp(['Cubic: ', num2str(untitled(x1, x2, 3, f3))]);     % Not exact
disp(['Quartic: ', num2str(untitled(x1, x2, 3, f4))]);   % Not exact

disp('3/8 Rule (n=4):')
disp(['Linear: ', num2str(untitled(x1, x2, 4, f1))]);  % Should be exact
disp(['Quadratic: ', num2str(untitled(x1, x2, 4, f2))]); % Should be exact
disp(['Cubic: ', num2str(untitled(x1, x2, 4, f3))]);     % Should be exact
disp(['Quartic: ', num2str(untitled(x1, x2, 4, f4))]);   % Not exact
