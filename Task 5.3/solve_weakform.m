function [u, K] = solve_weakform(E, A, L, F)
    % Number of nodes (2 nodes for one element)
    num_nodes = 2;
    
    % Initialize stiffness matrix and force vector
    K = zeros(num_nodes);
    f = zeros(num_nodes, 1);
    
    % Shape functions N1 and N2 for linear 1D element
    syms x x1 x2;
    N1 = (x2 - x) / L;  % Shape function for node 1
    N2 = (x - x1) / L;  % Shape function for node 2
    
    % Derivatives of shape functions (strain-displacement relation)
    dN1_dx = diff(N1, x);
    dN2_dx = diff(N2, x);
    
    % Element stiffness matrix using shape function derivatives
    K(1,1) = E * A * int(dN1_dx * dN1_dx, x, x1, x2);
    K(1,2) = E * A * int(dN1_dx * dN2_dx, x, x1, x2);
    K(2,1) = E * A * int(dN2_dx * dN1_dx, x, x1, x2);
    K(2,2) = E * A * int(dN2_dx * dN2_dx, x, x1, x2);
    
    % Modify for Dirichlet boundary condition u(x = 0) = 0
    f(2) = F;  % Force at node 2
    
    % Solve the system [K]{u} = {f}
    K_reduced = K(2,2);  % Reduced stiffness matrix (1x1)
    f_reduced = f(2);    % Reduced force vector
    
    % Solve for displacement at node 2
    u2 = f_reduced / K_reduced;
    
    % Displacement vector [u1, u2]
    u = [0; u2];
end
