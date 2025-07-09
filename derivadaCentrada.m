function [df_dx] = derivadaCentrada(funcion_anonima, x, h)
% derivadaCentrada: Calcula la derivada numérica de una función usando el método de diferencia centrada.
%
%   Args:
%       funcion_anonima (function_handle): Un handle a la función que se desea derivar.
%                                         Debe aceptar un solo argumento numérico (el valor de x).
%                                         Ejemplo: @(x) x.^2
%       x (double): El punto en el cual se desea calcular la derivada.
%       h (double): El tamaño del paso (paso de discretización).
%
%   Returns:
%       df_dx (double): El valor de la derivada numérica en el punto x.

% Validación básica de los argumentos de entrada
if ~isa(funcion_anonima, 'function_handle')
    error('El primer argumento debe ser un handle a una función anónima.');
end
if ~isnumeric(x) || ~isscalar(x)
    error('El segundo argumento (x) debe ser un valor numérico escalar.');
end
if ~isnumeric(h) || ~isscalar(h) || h <= 0
    error('El tercer argumento (h) debe ser un valor numérico escalar positivo.');
end

% Calcular los puntos vecinos para la diferencia centrada
x_mas_h = x + h;
x_menos_h = x - h;

% Evaluar la función en los puntos vecinos
f_x_mas_h = funcion_anonima(x_mas_h);
f_x_menos_h = funcion_anonima(x_menos_h);

% Aplicar la fórmula de la derivada numérica centrada
df_dx = (f_x_mas_h - f_x_menos_h) / (2 * h);

end