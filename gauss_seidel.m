function [x, iter] = gauss_seidel(A, b, x0, tol, max_iter)
    % Verificación de diagonal dominante por filas
    n = length(A);
    es_dominante = true;
    for i = 1:n
        suma = sum(abs(A(i, :))) - abs(A(i, i));
        if abs(A(i, i)) < suma
            es_dominante = false;
            break;
        end
    end

    if es_dominante
        fprintf('✅ La matriz A es diagonalmente dominante por filas.\n');
    else
        fprintf('⚠️ La matriz A NO es diagonalmente dominante por filas. El método podría no converger.\n');
    end

    % Verificación de simetría (A = A')
    if isequal(A, A')
        fprintf('✅ La matriz A es simétrica (A = A transpuesta).\n');
    else
        fprintf('ℹ️ La matriz A NO es simétrica.\n');
    end

    % Método Gauss-Seidel
    x = x0;
    iter = 0;
    resultados = [];

    for k = 1:max_iter
        x_old = x;

        for i = 1:n
            suma = A(i, 1:i-1) * x(1:i-1) + A(i, i+1:n) * x_old(i+1:n);
            x(i) = (b(i) - suma) / A(i, i);
        end

        iter = iter + 1;
        resultados = [resultados; iter, x'];

        if norm(x - x_old, inf) < tol
            break;
        end
    end
    
    fprintf(resultados); %Solo para ver los resultados supongo que en lo grafico cambia la forma de imprimir

    if iter == max_iter
        warning('Se alcanzó el número máximo de iteraciones sin converger.');
    end
end
