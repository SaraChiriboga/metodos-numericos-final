%% Derivadas
function [dp, dr, dc] = calcularDerivadas(f_str, xi, h, orden)
    f = str2func(['@(x)', f_str]);

    if h <= 0
        error('El valor de h debe ser mayor que cero.');
    end

    switch orden
        case 1
            f_xi = f(xi);
            f_xi_ph = f(xi + h);
            f_xi_mh = f(xi - h);

            dp = (f_xi_ph - f_xi) / h;
            dr = (f_xi - f_xi_mh) / h;
            dc = (f_xi_ph - f_xi_mh) / (2*h);

        case 2
            dp = (f(xi + 2*h) - 2*f(xi + h) + f(xi)) / h^2;
            dr = (f(xi) - 2*f(xi - h) + f(xi - 2*h)) / h^2;
            dc = (f(xi + h) - 2*f(xi) + f(xi - h)) / h^2;

        case 3
            dp = (f(xi + 3*h) - 3*f(xi + 2*h) + 3*f(xi + h) - f(xi)) / h^3;
            dr = (f(xi) - 3*f(xi - h) + 3*f(xi - 2*h) - f(xi - 3*h)) / h^3;
            dc = (f(xi + 2*h) - 2*f(xi + h) + 2*f(xi - h) - f(xi - 2*h)) / (2*h^3);

        otherwise
            error('Orden no soportado (solo 1, 2 o 3).');
    end
end
