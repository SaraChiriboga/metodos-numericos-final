function [integral_aprox, num_intervalos] = metodoTrapecio(funcion_anonima, a, b, N)
% metodoTrapecio: Aproxima la integral definida de una función usando el método del trapecio.
%
%   Args:
%       funcion_anonima (function_handle): Handle a la función cuya integral se desea aproximar.
%                                         Debe aceptar un solo argumento numérico (el valor de x).
%                                         Ejemplo: @(x) x.^2
%       a (double): Límite inferior de integración.
%       b (double): Límite superior de integración.
%       N (double): Número de subintervalos (también conocido como número de trapecios).
%                   Cuanto mayor sea N, más precisa será la aproximación.
%
%   Returns:
%       integral_aprox (double): El valor aproximado de la integral.
%       num_intervalos (double): El número real de subintervalos utilizados (igual a N).

% --- Validación de Argumentos ---
if ~isa(funcion_anonima, 'function_handle')
    error('El primer argumento (funcion_anonima) debe ser un handle a una función anónima.');
end
if ~isnumeric(a) || ~isscalar(a) || ~isnumeric(b) || ~isscalar(b)
    error('Los argumentos a y b deben ser valores numéricos escalares.');
end
if a >= b
    error('El límite inferior de integración (a) debe ser menor que el límite superior (b).');
end
if ~isnumeric(N) || ~isscalar(N) || N <= 0 || mod(N, 1) ~= 0
    error('El número de subintervalos (N) debe ser un entero positivo.');
end

% --- Cálculo de la integral por el Método del Trapecio ---

% 1. Calcular el ancho de cada subintervalo (h)
h = (b - a) / N;

% 2. Crear los puntos x a lo largo del intervalo [a, b]
% Estos puntos son los vértices de los trapecios.
x_puntos = a : h : b; % Crea un vector desde 'a' hasta 'b' con incrementos de 'h'.

% 3. Evaluar la función en cada uno de estos puntos
f_x_puntos = funcion_anonima(x_puntos);

% 4. Aplicar la fórmula del método del trapecio
% La fórmula es: h/2 * [f(x0) + 2*f(x1) + 2*f(x2) + ... + 2*f(xN-1) + f(xN)]
% Sumamos los términos intermedios (multiplicados por 2)
sum_intermedios = sum(f_x_puntos(2:end-1));

% La suma total es el primer término + el último término + 2 * la suma de los intermedios
integral_aprox = (h / 2) * (f_x_puntos(1) + 2 * sum_intermedios + f_x_puntos(end));

% --- Asignar el número de intervalos para el retorno ---
num_intervalos = N;

end