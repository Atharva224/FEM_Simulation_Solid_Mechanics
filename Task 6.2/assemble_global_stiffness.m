function K_global = assemble_global_stiffness(n_elements, element_stiffness, connectivity, n_nodes)
    % Initialize the global stiffness matrix with zeros
    K_global = zeros(n_nodes, n_nodes);
    
    % Loop through each element to assemble the global stiffness matrix
    for i = 1:n_elements
        % Get the nodes associated with the current element from connectivity
        element_nodes = connectivity(i, :);
        
        % Add the local stiffness matrix to the corresponding positions in the global matrix
        for a = 1:size(element_stiffness, 1)
            for b = 1:size(element_stiffness, 2)
                K_global(element_nodes(a), element_nodes(b)) = ...
                    K_global(element_nodes(a), element_nodes(b)) + element_stiffness(a, b);
            end
        end
    end
end
