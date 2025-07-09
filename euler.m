function [x_out, y_out, T] = euler(f_anon, x0, y0, h, xn, app)
% euler_gui: Resuelve una EDO usando el Método de Euler simple.
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
%       x_out (vector): Vector de puntos x.
%       y_out (vector): Vector de soluciones y aproximadas en cada x.
%       T (table): Tabla con los resultados intermedios (Iteracion, x, y_aprox).

    % --- Validación de Argumentos ---
    x_out = []; y_out = []; T = table(); % Initialize outputs to empty/default

    if ~isa(f_anon, 'function_handle')
        uialert(app.UIFigure, 'El primer argumento debe ser un handle a una función anónima f(x, y).', 'Error de Entrada');
        return;
    end
    if ~isnumeric(x0) || ~isscalar(x0) || ~isnumeric(y0) || ~isscalar(y0) || ...
       ~isnumeric(h) || ~isscalar(h) || h <= 0 || ~isnumeric(xn) || ~isscalar(xn)
        uialert(app.UIFigure, 'x0, y0, h, y xn deben ser valores numéricos escalares válidos. h debe ser positivo.', 'Error de Entrada');
        return;
    end
    if xn < x0
        uialert(app.UIFigure, 'El valor final de x (xn) debe ser mayor o igual que el valor inicial (x0).', 'Error de Entrada');
        return;
    end

    % --- Cálculo del número de pasos ---
    % Originalmente tu función tomaba 'n' (número de pasos).
    % Ahora tomamos 'xn' (x final) y 'h' (tamaño de paso) para calcular 'n'.
    n_steps = round((xn - x0) / h);
    if n_steps < 0
        n_steps = 0; % Ensure at least one point for x0, y0 if xn == x0
    end

    % Si xn es exactamente x0, solo tenemos un punto
    if xn == x0
        n_steps = 0;
    end
    
    % Inicialización de vectores (pre-asignación para eficiencia)
    x_vec = zeros(1, n_steps + 1);
    y_vec = zeros(1, n_steps + 1);
    
    x_vec(1) = x0;
    y_vec(1) = y0;

    % Para la tabla de resultados
    tabla_datos = zeros(n_steps + 1, 3); % columnas: Iteracion, x, y_aprox
    tabla_datos(1, :) = [0, x_vec(1), y_vec(1)]; % Primera fila (iteración 0)

    % Bucle principal del Método de Euler
    for i = 1:n_steps
        y_vec(i+1) = y_vec(i) + h * f_anon(x_vec(i), y_vec(i));
        x_vec(i+1) = x_vec(i) + h;
        
        tabla_datos(i+1, :) = [i, x_vec(i+1), y_vec(i+1)];
    end

    % Asignar resultados a las variables de salida
    x_out = x_vec;
    y_out = y_vec;
    T = array2table(tabla_datos, ...
        'VariableNames', {'Iteracion', 'x', 'y_aprox'});
end