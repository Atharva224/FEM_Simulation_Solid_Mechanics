function result = quadrature(x1, x2, n, lambda, zeta)

    if n ~= 2
        error('This implementation is for n = 2 (trapezoidal rule) only.');
    end
    
    % Define the function to integrate. Example: f(x) = x^2
    f = @(x) x.^2; 
    
    % Calculate the function values at the integration points
    f_zeta = f(zeta);
    
    % Perform the integration using the trapezoidal rule
    result = (x2 - x1) * sum(lambda .* f_zeta);
end

