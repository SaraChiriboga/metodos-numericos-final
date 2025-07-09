function [x, y, T] = euler_mejorado(f_anon, x0, y0, h, xn, app)
% euler_mejorado_gui: Resuelve una EDO usando el Método de Euler Mejorado.
%
%   Args:
%       f_anon (function_handle): Handle a la función f(x, y) de la EDO dy/dx = f(x, y).
%                                 Ejemplo: @(x, y) x + y
%       x0 (double): Valor inicial de x.
%       y0 (double): Valor inicial de y (condición inicial).
%       h (double): Tamaño de paso.
%       xn (double): Valor final de x.
%       app (obj): Objeto de la app para acceder a componentes (usado para uialert).
%
%   Returns:
%       x (vector): Vector de puntos x.
%       y (vector): Vector de soluciones y aproximadas en cada x.
%       T (table): Tabla con los resultados intermedios (x, y_aprox, k1, k2).

    % --- Validación de Argumentos ---
    if ~isa(f_anon, 'function_handle')
        uialert(app.UIFigure, 'El primer argumento debe ser un handle a una función anónima f(x, y).', 'Error de Entrada');
        return; % Salir si la función no es válida
    end
    if ~isnumeric(x0) || ~isscalar(x0) || ~isnumeric(y0) || ~isscalar(y0) || ...
       ~isnumeric(h) || ~isscalar(h) || h <= 0 || ~isnumeric(xn) || ~isscalar(xn) || xn <= x0
        uialert(app.UIFigure, 'x0, y0, h, y xn deben ser valores numéricos escalares válidos. h debe ser positivo y xn > x0.', 'Error de Entrada');
        return;
    end

    % Inicialización
    x_vec = x0:h:xn; % Renombro a x_vec para evitar confusión con la variable simbólica 'x'
    y_vec = zeros(1, length(x_vec));
    y_vec(1) = y0;

    % Guardar resultados para la tabla
    % Pre-asignar memoria para eficiencia
    tabla_datos = zeros(length(x_vec), 5); % columnas: iter, x, y, k1, k2
    
    % Asignar la primera fila de la tabla
    tabla_datos(1, :) = [0, x_vec(1), y_vec(1), NaN, NaN]; % Iteración 0, k1,k2 no aplicables

    for i = 1:length(x_vec)-1
        k1 = f_anon(x_vec(i), y_vec(i));
        y_pred = y_vec(i) + h * k1;  % Predicción con Euler simple
        k2 = f_anon(x_vec(i+1), y_pred);
        y_vec(i+1) = y_vec(i) + (h / 2) * (k1 + k2);
        
        % Guardar datos de la iteración actual en la tabla
        tabla_datos(i+1, :) = [i, x_vec(i+1), y_vec(i+1), k1, k2];
    end

    % Crear la tabla para retornar
    T = array2table(tabla_datos, ...
        'VariableNames', {'Iteracion', 'x', 'y_aprox', 'k1', 'k2'});

    disp(T)
    
    % Asignar resultados finales a las variables de salida
    x = x_vec;
    y = y_vec;
end