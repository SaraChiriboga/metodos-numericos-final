function metodoRectangulosIndependiente()
    % Solicitar datos al usuario para calcular la integral por el método de rectángulos
    preguntas = {'Función f(x):', 'Límite inferior:', 'Límite superior:', 'subintervalos:'};
    titulo = 'Integración: Método de Rectángulos';
    tamano = [1 50];
    valoresDefecto = {'sin(x) + 2', '0', '2', '26'};
    
    respuestas = inputdlg(preguntas, titulo, tamano, valoresDefecto);
    
    if isempty(respuestas)
        return; % Usuario canceló
    end
    
    try
        % Crear función anónima
        funcion = str2func(['@(x)', respuestas{1}]);
        
        limiteInferior = str2double(respuestas{2});
        limiteSuperior = str2double(respuestas{3});
        numSubintervalos = str2double(respuestas{4});
        
        % Validar entradas numéricas
        if isnan(limiteInferior) || isnan(limiteSuperior) || isnan(numSubintervalos) || numSubintervalos <= 0
            error('Los límites y número de subintervalos deben ser números válidos y n > 0.');
        end
        
        ancho = (limiteSuperior - limiteInferior) / numSubintervalos;
        puntos_x = limiteInferior:ancho:(limiteSuperior - ancho);
        suma_alturas = sum(funcion(puntos_x));
        area_aproximada = ancho * suma_alturas;
        
        % Mostrar resultado en consola
        fprintf('Resultado aproximado de la integral: %.6f\n', area_aproximada);
        
        % Graficar función y rectángulos
        figure('Name', 'Aproximación Integral - Rectángulos');
        x_vals = linspace(limiteInferior, limiteSuperior, 300);
        y_vals = arrayfun(funcion, x_vals);
        plot(x_vals, y_vals, 'b-', 'LineWidth', 2);
        hold on;
        
        % Dibujar rectángulos
        for i = 1:numSubintervalos
            xi = limiteInferior + (i-1)*ancho;
            altura = funcion(xi);
            fill([xi xi xi+ancho xi+ancho], [0 altura altura 0], 'g', 'FaceAlpha', 0.25, 'EdgeColor', 'k');
        end
        
        title('Integración por Método de Rectángulos');
        xlabel('x');
        ylabel('f(x)');
        grid on;
        hold off;
        
    catch ME
        fprintf('Error durante la ejecución: %s\n', ME.message);
    end
end
