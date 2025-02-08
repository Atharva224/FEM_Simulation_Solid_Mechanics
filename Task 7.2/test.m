% Example stiffness matrix from Task 6.1
K = [ 1 -1  0  0;
     -1  2 -1  0;
      0 -1  2 -1;
      0  0 -1  1 ];

% Force vector
f = [0; 0; 0; -5];  % Von Neumann boundary condition

% Specify Dirichlet boundary conditions
dirichlet_nodes = [1];  % Node 1
dirichlet_displacements = [0];  % u1 = 0

% Apply Dirichlet boundary conditions using the routine
[K_mod, f_mod] = applyDirichletBC(K, f, dirichlet_nodes, dirichlet_displacements);

% Display modified matrices
disp('Modified stiffness matrix:');
disp(K_mod);

disp('Modified force vector:');
disp(f_mod);

% Solve the reduced system
solution = K_mod \ f_mod;

% Display the solution
disp('Solution vector:');
disp(solution);






% Additional Dirichlet condition at Node 4: u4 = 2
dirichlet_nodes = [1, 4];  % Nodes with Dirichlet conditions
dirichlet_displacements = [0, 2];  % Displacements at nodes

% Apply the boundary conditions dynamically
[K_mod, f_mod] = applyDirichletBC(K, f, dirichlet_nodes, dirichlet_displacements);

% Display the modified stiffness matrix and force vector
disp('Modified stiffness matrix for multiple Dirichlet conditions:');
disp(K_mod);

disp('Modified force vector for multiple Dirichlet conditions:');
disp(f_mod);

% Solve and display the solution
solution = K_mod \ f_mod;
disp('Solution vector:');
disp(solution);

