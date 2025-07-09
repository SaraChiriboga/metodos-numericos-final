function [x, iter, errores] = jacobi(A, b, x0, tol, max_iter)
% Método de Jacobi con

    n = length(b);
    x = x0;
    errores = zeros(1, max_iter);

    for iter = 1:max_iter
        x_new = zeros(n,1);

        for i = 1:n
            suma = A(i, [1:i-1, i+1:n]) * x([1:i-1, i+1:n]);
            x_new(i) = (b(i) - suma) / A(i,i);
        end

        errores(iter) = norm(x_new - x, inf);

        if errores(iter) < tol
            x = x_new;
            errores = errores(1:iter);
            break;
        end

        x = x_new;
    end

    figure;
    plot(1:length(errores), errores, 'r-o', 'LineWidth', 1.5);
    grid on;
    xlabel('Iteración');
    ylabel('Error ||x_{n+1} - x_n||_\infty');
    title('Convergencia del Método de Jacobi');
end
