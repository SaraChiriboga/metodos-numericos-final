function biseccion(f, a, b, tol, max_iter)

    if f(a) * f(b) >= 0
        error('El intervalo no garantiza una raíz (f(a) * f(b) >= 0)');
    end

    % Inicializar vectores para guardar los datos
    iterVec = [];
    aVec = [];
    bVec = [];
    cVec = [];
    fcVec = [];

    for i = 1:max_iter
        c = (a + b) / 2;
        fc = f(c);

        % Guardar datos de la iteración
        iterVec(end+1) = i;
        aVec(end+1) = a;
        bVec(end+1) = b;
        cVec(end+1) = c;
        fcVec(end+1) = fc;

        % Criterio de parada
        if abs(fc) < tol || (b - a)/2 < tol
            break;
        end

        % Actualizar intervalo
        if f(a) * fc < 0
            b = c;
        else
            a = c;
        end
    end

    % Mostrar la tabla
    T = table(iterVec.', aVec.', bVec.', cVec.', fcVec.', ...
        'VariableNames', {'Iteración', 'a', 'b', 'c', 'f(c)'});
    disp(T);

    % Mostrar resultado final
    fprintf('\nRaíz aproximada en x = %.6f\n', cVec(end));
end
