function resultado = simpson13(f, a, b, N)
    h = (b - a) / N;
    x = a:h:b;
    y = f(x);
    resultado = (h / 3) * (y(1) + 4 * sum(y(2:2:end-1)) + 2 * sum(y(3:2:end-2)) + y(end));
end
