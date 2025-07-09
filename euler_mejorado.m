function euler_mejorado(f, x0, y0, h, xn)

    % Inicialización
    x = x0:h:xn;
    y = zeros(1, length(x));
    y(1) = y0;

    % Guardar resultados para la tabla
    tabla = zeros(length(x), 4);  % columnas: x, y, k1, k2

    for i = 1:length(x)-1
        k1 = f(x(i), y(i));
        y_pred = y(i) + h * k1;  % Predicción con Euler simple
        k2 = f(x(i+1), y_pred);
        y(i+1) = y(i) + (h / 2) * (k1 + k2);

        tabla(i, :) = [x(i), y(i), k1, k2];
    end

    tabla(end, :) = [x(end), y(end), NaN, NaN];

    % Mostrar tabla
    T = array2table(tabla, ...
        'VariableNames', {'x', 'y_aprox', 'k1', 'k2'});
    disp(T);

    % Gráfica de la solución aproximada
    plot(x, y, 'o-', 'LineWidth', 2);
    title('Método de Euler Mejorado');
    xlabel('x');
    ylabel('y');
    grid on;
end
