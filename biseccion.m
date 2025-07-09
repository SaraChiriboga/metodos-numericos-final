function [raiz, iteraciones_finales, error_aprox] = biseccion(funcion_anonima, a, b, tolerancia, max_iteraciones)
% metodoBiseccion: Encuentra una raíz de una función usando el método de la bisección.
%
%   Args:
%       funcion_anonima (function_handle): Handle a la función f(x) cuya raíz se desea encontrar.
%                                         Ejemplo: @(x) x.^3 - x - 2
%       a (double): Límite inferior del intervalo.
%       b (double): Límite superior del intervalo.
%       tolerancia (double): Criterio de parada.
%       max_iteraciones (double): Número máximo de iteraciones permitidas.
%
%   Returns:
%       raiz (double): La raíz aproximada encontrada.
%       iteraciones_finales (double): El número de iteraciones realizadas.
%       error_aprox (double): Una estimación del error (ancho del intervalo final / 2).

% --- Validación de Argumentos (similar a los otros métodos) ---
if ~isa(funcion_anonima, 'function_handle')
    error('El primer argumento (funcion_anonima) debe ser un handle a una función anónima.');
end
if ~isnumeric(a) || ~isscalar(a) || ~isnumeric(b) || ~isscalar(b)
    error('Los límites del intervalo (a y b) deben ser valores numéricos escalares.');
end
if ~isnumeric(tolerancia) || ~isscalar(tolerancia) || tolerancia <= 0
    error('La tolerancia debe ser un valor numérico escalar positivo.');
end
if ~isnumeric(max_iteraciones) || ~isscalar(max_iteraciones) || max_iteraciones <= 0 || mod(max_iteraciones, 1) ~= 0
    error('El número máximo de iteraciones debe ser un entero positivo.');
end

% --- Validación del Criterio de Bisección ---
fa = funcion_anonima(a);
fb = funcion_anonima(b);

if fa * fb >= 0
    error('El método de la Bisección requiere que f(a) y f(b) tengan signos opuestos en el intervalo [a, b]. Verifique la función o el intervalo.');
end

% --- Bucle Principal del Método de Bisección ---
for i = 1:max_iteraciones
    c = (a + b) / 2;
    fc = funcion_anonima(c);
    
    % Criterio de parada
    if abs(fc) < tolerancia || (b - a)/2 < tolerancia
        iteraciones_finales = i;
        raiz = c;
        error_aprox = (b - a)/2; % Una estimación del error
        return; % Salir de la función una vez encontrada la raíz
    end

    % Actualizar intervalo para la siguiente iteración
    if fa * fc < 0 % Si f(a) y f(c) tienen signos opuestos, la raíz está en [a, c]
        b = c;
        fb = fc; % Actualizar fb para la próxima iteración
    else % Si f(a) y f(c) tienen el mismo signo, la raíz está en [c, b]
        a = c;
        fa = fc; % Actualizar fa para la próxima iteración
    end
end

% Si el bucle termina sin encontrar la raíz dentro de la tolerancia
% (es decir, alcanzó max_iteraciones)
iteraciones_finales = max_iteraciones;
raiz = c; % La última 'c' calculada
error_aprox = (b - a)/2; % Error final

warning('El método de la Bisección no convergió a la tolerancia deseada en el número máximo de iteraciones.');

end