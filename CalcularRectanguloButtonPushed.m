function CalcularRectanguloButtonPushed(app, event)
    try
        f_str = app.funcion_integral.Value;
        a = app.a_limite.Value;
        b = app.b_limite.Value;
        N = app.N_trapecio.Value;

        if a >= b
            error('El límite inferior debe ser menor que el superior.');
        end
        if N <= 0 || mod(N,1) ~= 0
            error('El número de subintervalos debe ser un entero positivo.');
        end

        f = str2func(['@(x)', f_str]);
        h = (b - a) / N;
        x = linspace(a, b - h, N);
        y = f(x);
        resultado = h * sum(y);

        % Gráfica
        cla(app.graficoTrapecio);
        hold(app.graficoTrapecio, 'on');
        for i = 1:N
            rectangle('Parent', app.graficoTrapecio, ...
                      'Position', [x(i), 0, h, y(i)], ...
                      'FaceColor', [0.7 1 0.7], ...
                      'EdgeColor', 'k');
        end
        x_plot = linspace(a, b, 500);
        plot(app.graficoTrapecio, x_plot, f(x_plot), 'b', 'LineWidth', 2);
        title(app.graficoTrapecio, 'Método de Rectángulos');
        xlabel(app.graficoTrapecio, 'x');
        ylabel(app.graficoTrapecio, 'f(x)');
        grid(app.graficoTrapecio, 'on');
        hold(app.graficoTrapecio, 'off');

        app.resultadoLabel.Text = sprintf('Resultado (Rectángulos): %.6f', resultado);
    catch ME
        uialert(app.UIFigure, ME.message, 'Error');
    end
end
