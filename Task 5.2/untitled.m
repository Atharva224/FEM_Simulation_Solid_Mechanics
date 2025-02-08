function result = untitled(x1, x2, n, f)
    % Input: 
    % x1, x2: limits of integration
    % n: number of integration points
    % f: function handle to integrate
    
    % Define weights (λ) and integration points (ζ) based on n
    switch n
        case 2  % Trapezoidal rule
            lambda = [1/2, 1/2];
            zeta = [x1, x2];
        case 3  % Simpson's rule
            lambda = [1/6, 4/6, 1/6];
            zeta = [x1, (x1 + x2)/2, x2];
        case 4  % 3/8 rule
            lambda = [1/8, 3/8, 3/8, 1/8];
            zeta = [x1, x1 + (x2 - x1)/3, x1 + 2*(x2 - x1)/3, x2];
        otherwise
            error('Unsupported value of n. Choose n = 2, 3, or 4.');
    end
    
    % Apply the quadrature formula
    result = 0;
    for i = 1:n
        result = result + lambda(i) * f(zeta(i));
    end
    
    % Multiply by (x2 - x1)
    result = result * (x2 - x1);
end
