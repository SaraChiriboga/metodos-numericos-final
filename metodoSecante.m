function [raiz, iteraciones, error_relativo] = metodoSecante(funcion_anonima, x_i_menos_1, x_i, tolerancia, max_iteraciones)
% secante: Encuentra una raíz de una función usando el método de la secante.
%
%   Args:
%       funcion_anonima (function_handle): Handle a la función cuya raíz se desea encontrar.
%                                         Ejemplo: @(x) x.^3 - x - 2
%       x_i_menos_1 (double): Primera aproximación inicial (x_i-1).
%       x_i (double): Segunda aproximación inicial (x_i).
%       tolerancia (double): Criterio de parada para el error relativo aproximado.
%       max_iteraciones (double): Número máximo de iteraciones permitidas.
%
%   Returns:
%       raiz (double): La raíz aproximada encontrada.
%       iteraciones (double): El número de iteraciones realizadas.
%       error_relativo (double): El error relativo aproximado final.

% --- Validación de Argumentos ---
if ~isa(funcion_anonima, 'function_handle')
    error('El primer argumento (funcion_anonima) debe ser un handle a una función anónima.');
end
if ~isnumeric(x_i_menos_1) || ~isscalar(x_i_menos_1) || ~isnumeric(x_i) || ~isscalar(x_i)
    error('Los argumentos x_i_menos_1 y x_i deben ser valores numéricos escalares.');
end
if x_i_menos_1 == x_i
    error('Las dos aproximaciones iniciales (x_i-1 y x_i) no deben ser iguales.');
end
if ~isnumeric(tolerancia) || ~isscalar(tolerancia) || tolerancia <= 0
    error('La tolerancia debe ser un valor numérico escalar positivo.');
end
if ~isnumeric(max_iteraciones) || ~isscalar(max_iteraciones) || max_iteraciones <= 0 || mod(max_iteraciones, 1) ~= 0
    error('El número máximo de iteraciones debe ser un entero positivo.');
end

% --- Inicialización de Variables ---
iteraciones = 0;
% x_actual y x_anterior se refieren a las dos últimas aproximaciones usadas
x_anterior = x_i_menos_1;
x_actual = x_i;
error_relativo = Inf; % Inicializar con un valor grande para asegurar al menos una iteración

% --- Bucle Principal del Método de la Secante ---
while iteraciones < max_iteraciones && error_relativo > tolerancia
    iteraciones = iteraciones + 1;

    f_x_anterior = funcion_anonima(x_anterior);
    f_x_actual = funcion_anonima(x_actual);

    % Verificar si el denominador es cero o muy cercano a cero
    % Esto indica que f(x_actual) es muy similar a f(x_anterior),
    % lo que puede causar división por cero o un paso muy grande.
    if abs(f_x_actual - f_x_anterior) < eps * 100
        error('La diferencia entre f(x_i) y f(x_i-1) es cero o muy cercana a cero. El método no puede continuar (posible tangente horizontal).');
    end

    % Aplicar la fórmula del método de la secante
    % x_nueva = x_actual - f(x_actual) * (x_actual - x_anterior) / (f(x_actual) - f(x_anterior))
    x_nueva = x_actual - f_x_actual * (x_actual - x_anterior) / (f_x_actual - f_x_anterior);

    % Calcular el error relativo aproximado
    if x_nueva ~= 0
        error_relativo = abs((x_nueva - x_actual) / x_nueva);
    else
        % Si la nueva raíz es 0, y la actual no fue 0, el error es infinito
        if x_actual ~= 0
            error_relativo = Inf;
        else % Si ambas son 0, la raíz es 0 con error 0
            error_relativo = 0;
        end
    end

    % Actualizar las aproximaciones para la siguiente iteración
    x_anterior = x_actual;
    x_actual = x_nueva;

    % --- Mensaje de progreso (opcional, útil para depuración en GUI) ---
    % fprintf('Iteración %d: Raíz = %.6f, Error Relativo = %.6e\n', iteraciones, x_nueva, error_relativo);
end

% --- Resultado Final ---
raiz = x_actual; % La última aproximación es nuestra raíz

% --- Verificar si la convergencia no se logró ---
if iteraciones >= max_iteraciones && error_relativo > tolerancia
    warning('El método de la Secante no convergió a la tolerancia deseada en el número máximo de iteraciones.');
    % Opcionalmente, lanzar un error en lugar de una advertencia
    % error('No se alcanzó la convergencia.');
end

end