function [K_mod, f_mod] = applyDirichletBC(K, f, dirichlet_nodes, dirichlet_displacements)
    % Modifies the stiffness matrix K and force vector f based on Dirichlet boundary conditions.
    %
    % Inputs:
    %   - K: Global stiffness matrix
    %   - f: Global force vector
    %   - dirichlet_nodes: Array of nodes with Dirichlet boundary conditions
    %   - dirichlet_displacements: Corresponding displacements for Dirichlet nodes
    %
    % Outputs:
    %   - K_mod: Reduced stiffness matrix
    %   - f_mod: Reduced force vector

    % Initialize modified matrix and vector
    K_mod = K;
    f_mod = f;

    % Apply each Dirichlet boundary condition
    for i = 1:length(dirichlet_nodes)
        node = dirichlet_nodes(i);
        displacement = dirichlet_displacements(i);

        % Adjust the force vector to account for the prescribed displacement
        f_mod = f_mod - K_mod(:, node) * displacement;

        % Remove rows and columns for the Dirichlet node
        K_mod(node, :) = 0;
        K_mod(:, node) = 0;

        % Update diagonal entry for Dirichlet node
        K_mod(node, node) = 1;

        % Update the force vector for the Dirichlet node
        f_mod(node) = displacement;
    end
end
