% Define the number of elements
n_elements = 5;  % Change this to any number of elements for testing

% Define the number of nodes (should match the connectivity definition)
n_nodes = n_elements + 1;

% Define the local stiffness matrix for an element
element_stiffness = [1 -1; -1 1];  % For 2-node elements

% Define the connectivity matrix dynamically for 1D elements
connectivity = [1:n_elements; 2:n_elements+1]';

% Assemble the global stiffness matrix
K_global = assemble_global_stiffness(n_elements, element_stiffness, connectivity, n_nodes);

% Display the global stiffness matrix
disp('Global stiffness matrix:');
disp(K_global);
