function [raiz, iter, error] = regula_falsi(f, a, b, tol, max_iter)

    if f(a)*f(b) >= 0
        error('f(a) y f(b) deben tener signos opuestos');
    end

    for iter = 1:max_iter
        x = b - (f(b)*(b - a)) / (f(b) - f(a));
        fx = f(x);
        error = abs(fx);

        if error < tol
            raiz = x;
            return;
        end

        if f(a) * fx < 0
            b = x;
        else
            a = x;
        end
    end

    raiz = x;
end
