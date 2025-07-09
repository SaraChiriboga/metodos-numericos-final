function CalcularSimpsonButtonPushed(app, event)
    try
        % Obtener función como texto y convertir a función anónima
        syms x
        f_sym = str2sym(app.funcion_integral.Value);
        f = matlabFunction(f_sym);

        % Obtener límites y número de intervalos
        a = app.a_limite.Value;
        b = app.b_limite.Value;
        n = app.n_intervalo.Value;

        % Validar que n sea par
        if mod(n, 2) ~= 0
            uialert(app.UIFigure, 'n debe ser par para aplicar la regla de Simpson 1/3.', 'Error');
            return;
        end

        % Crear partición
        h = (b - a) / n;
        x_vals = a:h:b;
        y_vals = f(x_vals);

        % Calcular con regla de Simpson 1/3
        suma = y_vals(1) + y_vals(end);
        for i = 2:2:n
            suma = suma + 4 * y_vals(i);
        end
        for i = 3:2:n-1
            suma = suma + 2 * y_vals(i);
        end
        resultado = (h / 3) * suma;
        app.resultadoLabel.Text = ['Resultado: ', num2str(resultado)];

        % Graficar función y áreas sombreadas
        cla(app.graficoTrapecio);
        fplot(app.graficoTrapecio, f_sym, [a, b], 'LineWidth', 2);
        hold(app.graficoTrapecio, 'on');

        % Dibujar parabólicas (Simpson) con sombreado por cada par de intervalos
        for i = 1:2:n-1
            x_sub = linspace(x_vals(i), x_vals(i+2), 100);
            coeffs = polyfit(x_vals(i:i+2), y_vals(i:i+2), 2);
            y_sub = polyval(coeffs, x_sub);

            fill(app.graficoTrapecio, x_sub, y_sub, [0.2 0.6 0.8], ...
                'FaceAlpha', 0.3, 'EdgeColor', 'none');
        end

        title(app.graficoTrapecio, 'Aproximación por la regla de Simpson');
        xlabel(app.graficoTrapecio, 'x');
        ylabel(app.graficoTrapecio, 'f(x)');
        grid(app.graficoTrapecio, 'on');
        hold(app.graficoTrapecio, 'off');

    catch ME
        uialert(app.UIFigure, ME.message, 'Error');
    end
end
