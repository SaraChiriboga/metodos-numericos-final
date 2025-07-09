function [x, y] = euler(f, x0, y0, h, n)
% Método de Euler

    x = zeros(1, n+1);
    y = zeros(1, n+1);

    x(1) = x0;
    y(1) = y0;

    for i = 1:n
        y(i+1) = y(i) + h * f(x(i), y(i));
        x(i+1) = x(i) + h;
    end

    plot(x, y, 'b-o', 'LineWidth', 1.5, 'MarkerSize', 5);
    grid on;
    xlabel('x');
    ylabel('y');
    title('Aproximación con el Método de Euler');
    legend('Euler');
end
