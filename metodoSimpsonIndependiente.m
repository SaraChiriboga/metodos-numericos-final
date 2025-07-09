function metodoSimpsonIndependiente()
    % Solicita al usuario la función y parámetros para integrar con Simpson
    preguntas = {'Función f(x):', 'Límite inferior:', 'Límite superior:', 'Número de subintervalos (SOLO PAR):'};
    titulo = 'Integración por Método de Simpson';
    tamano = [1 50];
    valoresDefecto = {'sin(x) + 2', '0', '2', '26'};
    
    respuestas = inputdlg(preguntas, titulo, tamano, valoresDefecto);
    
    if isempty(respuestas)
        return; % Usuario canceló
    end
    
    try
        % Convertir cadena a función anónima
        funcion = str2func(['@(x)', respuestas{1}]);
        
        limiteA = str2double(respuestas{2});
        limiteB = str2double(respuestas{3});
        numSubintervalos = str2double(respuestas{4});
        
        % Comprobar que n sea par
        if mod(numSubintervalos, 2) ~= 0
            error('El número de subintervalos debe ser un número par.');
        end
        
        paso = (limiteB - limiteA) / numSubintervalos;
        puntosX = limiteA:paso:limiteB;
        valoresF = funcion(puntosX);
        
        % Fórmula del método de Simpson
        resultadoIntegral = paso/3 * (valoresF(1) + 2*sum(valoresF(3:2:end-2)) + 4*sum(valoresF(2:2:end)) + valoresF(end));
        
        % Mostrar resultado en consola
        fprintf('Integral aproximada con método de Simpson: %.6f\n', resultadoIntegral);
        
        % Graficar función y áreas bajo las parábolas
        figura = figure('Name', 'Método de Simpson');
        xGrafica = linspace(limiteA, limiteB, 500);
        yGrafica = arrayfun(funcion, xGrafica);
        plot(xGrafica, yGrafica, 'b-', 'LineWidth', 2);
        hold on;
        
        % Dibujar las parábolas que aproximan el área
        for i = 1:2:numSubintervalos
            xi = puntosX(i:i+2);
            coeficientes = polyfit(xi, funcion(xi), 2);
            xx = linspace(xi(1), xi(3), 100);
            yy = polyval(coeficientes, xx);
            fill([xx fliplr(xx)], [yy zeros(size(yy))], [1 1 0], 'FaceAlpha', 0.25, 'EdgeColor', 'none');
        end
        
        title('Aproximación por Método de Simpson');
        xlabel('x');
        ylabel('f(x)');
        grid on;
        hold off;
        
    catch ME
        fprintf('Error: %s\n', ME.message);
    end
end
