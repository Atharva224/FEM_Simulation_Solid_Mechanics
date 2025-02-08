% Clear the workspace
clear; clc;

% Problem parameters
E = 210000;  % Young's modulus in N/mm^2
A = 25;      % Cross-sectional area in mm^2
L = 50;      % Length of the bar in mm
F = 5;       % Force applied at x = L in N

% Call the function to compute the solution
[u, K] = solve_weakform(E, A, L, F);

% Display the results
disp('Displacement at each node:');
disp(u);
disp('Stiffness matrix:');
disp(K);
