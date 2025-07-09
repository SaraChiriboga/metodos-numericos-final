function [raiz, iteraciones, error_relativo] = newtonRaphson(funcion_anonima, derivada_anonima, x0, tolerancia, max_iteraciones)
% newtonRaphson: Encuentra una raíz de una función usando el método de Newton-Raphson.
%
%   Args:
%       funcion_anonima (function_handle): Handle a la función f(x) cuya raíz se desea encontrar.
%                                         Ejemplo: @(x) x.^3 - x - 2
%       derivada_anonima (function_handle): Handle a la derivada f'(x) de la función.
%                                          Ejemplo: @(x) 3*x.^2 - 1
%       x0 (double): La aproximación inicial de la raíz.
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
if ~isa(derivada_anonima, 'function_handle')
    error('El segundo argumento (derivada_anonima) debe ser un handle a una función anónima (la derivada).');
end
if ~isnumeric(x0) || ~isscalar(x0)
    error('El tercer argumento (x0) debe ser un valor numérico escalar.');
end
if ~isnumeric(tolerancia) || ~isscalar(tolerancia) || tolerancia <= 0
    error('La tolerancia debe ser un valor numérico escalar positivo.');
end
if ~isnumeric(max_iteraciones) || ~isscalar(max_iteraciones) || max_iteraciones <= 0 || mod(max_iteraciones, 1) ~= 0
    error('El número máximo de iteraciones debe ser un entero positivo.');
end

% --- Inicialización de Variables ---
iteraciones = 0;
raiz_anterior = x0; % Inicialización para el cálculo del error relativo
error_relativo = Inf; % Inicializar con un valor grande para asegurar al menos una iteración

% --- Bucle Principal de Newton-Raphson ---
while iteraciones < max_iteraciones && error_relativo > tolerancia
    iteraciones = iteraciones + 1;

    fx = funcion_anonima(raiz_anterior);
    f_prima_x = derivada_anonima(raiz_anterior);

    % Verificar si la derivada es cero (o muy cercana a cero)
    if abs(f_prima_x) < eps * 100 % Usar un umbral pequeño basado en la precisión de la máquina
        error('La derivada es cero o muy cercana a cero en la iteración actual. El método no puede continuar.');
    end

    % Aplicar la fórmula de Newton-Raphson
    % x_nueva = x_anterior - f(x_anterior) / f'(x_anterior)
    raiz_actual = raiz_anterior - (fx / f_prima_x);

    % Calcular el error relativo aproximado
    if raiz_actual ~= 0
        error_relativo = abs((raiz_actual - raiz_anterior) / raiz_actual);
    else
        % Si la raíz actual es 0, y la anterior no fue 0, el error es infinito
        if raiz_anterior ~= 0
            error_relativo = Inf;
        else % Si ambas son 0, la raíz es 0 con error 0
            error_relativo = 0;
        end
    end

    % Actualizar la raíz anterior para la próxima iteración
    raiz_anterior = raiz_actual;

    % --- Mensaje de progreso (opcional, útil para depuración en GUI) ---
    % fprintf('Iteración %d: Raíz = %.6f, Error Relativo = %.6e\n', iteraciones, raiz_actual, error_relativo);
end

% --- Resultado Final ---
raiz = raiz_anterior; % La última aproximación es nuestra raíz

% --- Verificar si la convergencia no se logró ---
if iteraciones >= max_iteraciones && error_relativo > tolerancia
    warning('El método de Newton-Raphson no convergió a la tolerancia deseada en el número máximo de iteraciones.');
    % Opcionalmente, lanzar un error en lugar de una advertencia
    % error('No se alcanzó la convergencia.');
end

end