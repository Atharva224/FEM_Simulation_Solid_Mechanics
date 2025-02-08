% Main function
function OneDimensionalFEM()
    % Default parameters from Task 5.3
    E = 210000; % Young's modulus [N/mm^2]
    A = 25; % Cross section area [mm^2]
    L = 50; % Length of bar [mm]
    n_elements = 6; % Number of elements

    % Create mesh
    n_nodes = n_elements + 1;
    nodes = linspace(0, L, n_nodes);

    % Initialize global stiffness matrix and force vector
    K = zeros(n_nodes, n_nodes);
    f = zeros(n_nodes, 1);

    % Assemble system
    for e = 1:n_elements
        % Get element nodes
        node1 = nodes(e);
        node2 = nodes(e+1);

        % Calculate element length
        le = node2 - node1;

        % Calculate element stiffness matrix
        Ke = (E * A / le) * [1 -1; -1 1];

        % Global indices
        indices = [e, e+1];

        % Assembly
        K(indices, indices) = K(indices, indices) + Ke;
    end

    % Apply boundary conditions (Change values as per preference)
    % Example: Dirichlet BC on node 4, von Neumann on last node
    %bc_type = 'fixed-other';
    %bc_values = struct('fixed_nodes', [4], 'fixed_values', [0.00002], 'force_nodes', n_nodes, 'force_values', 5);

    %For initial condition given in pdf, look below example
    bc_type = 'fixed-force';
    bc_values = struct('fixed_nodes', 1, 'fixed_values', 0, 'force_nodes', n_nodes, 'force_values', 5);


    [K_reduced, f_reduced, free_dofs] = apply_boundary_conditions(K, f, bc_type, bc_values, n_nodes);

    % Solve system
    u_reduced = K_reduced \ f_reduced;

    % Recover full displacement vector
    u = zeros(n_nodes, 1);
    u(free_dofs) = u_reduced;

    % Calculate stresses
    [stress, x_stress] = calculate_stress(nodes, u, E, A, n_elements);

    % Plot results
    plot_results(nodes, u, x_stress, stress, bc_type);
end

% Function to apply boundary conditions
function [K_reduced, f_reduced, free_dofs] = apply_boundary_conditions(K, f, bc_type, bc_values, n_nodes)
    switch bc_type
        case 'fixed-force'
            fixed_nodes = bc_values.fixed_nodes;
            force_nodes = bc_values.force_nodes;
            force_values = bc_values.force_values;

            % Apply force boundary condition
            f(force_nodes) = force_values;

            % Remove fixed DOFs
            free_dofs = setdiff(1:n_nodes, fixed_nodes);
            K_reduced = K(free_dofs, free_dofs);
            f_reduced = f(free_dofs);

        case 'fixed-other'
            fixed_nodes = bc_values.fixed_nodes; % Node with Dirichlet BC
            fixed_values = bc_values.fixed_values; % Value for the Dirichlet BC
            force_nodes = bc_values.force_nodes;
            force_values = bc_values.force_values;

            % Apply force boundary conditions
            f(force_nodes) = force_values;

            % Modify stiffness matrix and force vector for Dirichlet BC
            for i = 1:length(fixed_nodes)
                node = fixed_nodes(i);
                value = fixed_values(i);
                f = f - K(:, node) * value; % Adjust RHS
                f(node) = value; % Directly set RHS for fixed node
                K(node, :) = 0; % Zero row
                K(:, node) = 0; % Zero column
                K(node, node) = 1; % Diagonal set to 1
            end

            free_dofs = setdiff(1:n_nodes, fixed_nodes);
            K_reduced = K(free_dofs, free_dofs);
            f_reduced = f(free_dofs);
    end
end

% Function to calculate stresses
function [stress, x_stress] = calculate_stress(nodes, u, E, A, n_elements)
    x_stress = zeros(n_elements, 1);
    stress = zeros(n_elements, 1);
    for e = 1:n_elements
        % Element center for stress calculation
        x_stress(e) = (nodes(e) + nodes(e+1)) / 2;

        % Calculate strain and stress
        strain = (u(e+1) - u(e)) / (nodes(e+1) - nodes(e));
        stress(e) = E * strain;
    end
end

% Function to plot results
function plot_results(nodes, u, x_stress, stress, bc_type)
    figure('Position', [100 100 1000 400])

    % Plot displacement
    subplot(1, 2, 1)
    plot(nodes, u, 'b-o', 'LineWidth', 2)
    grid on
    xlabel('Position [mm]')
    ylabel('Displacement [mm]')
    title('Displacement Field')

    % Plot stress
    subplot(1, 2, 2)
    plot(x_stress, stress, 'r-o', 'LineWidth', 2)
    grid on
    xlabel('Position [mm]')
    ylabel('Stress [N/mm^2]')
    title('Stress Field')

    % Add title based on boundary conditions
    sgtitle(['1D FEM Analysis: ' strrep(bc_type, '-', ' ')]);
end
