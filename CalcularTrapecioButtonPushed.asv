function CalcularTrapecioButtonPushed(app, event)
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
        x = linspace(a, b, N+1);
        y = f(x);
        resultado = (h / 2) * (y(1) + 2*sum(y(2:end-1)) + y(end));

        % Gráfica
        cla(app.graficoTrapecio);
        hold(app.graficoTrapecio, 'on');
        x_plot = linspace(a, b, 500);
        plot(app.graficoTrapecio, x_plot, f(x_plot), 'b', 'LineWidth', 2);

        for i = 1:N
            fill(app.graficoTrapecio, ...
                [x(i), x(i+1), x(i+1), x(i)], ...
                [0, 0, y(i+1), y(i)], ...
                'c', 'FaceAlpha', 0.3, 'EdgeColor', 'k');
        end

        title(app.graficoTrapecio, 'Método del Trapecio');
        xlabel(app.graficoTrapecio, 'x');
        ylabel(app.graficoTrapecio, 'f(x)');
        grid(app.graficoTrapecio, 'on');
        hold(app.graficoTrapecio, 'off');

        app.resultadoLabel.Text = sprintf('Resultado (Trapecio): %.6f', resultado);
    catch ME
        uialert(app.UIFigure, ME.message, 'Error');
    end
end
