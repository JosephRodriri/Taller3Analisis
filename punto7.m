% Definición del volumen en litros
X = 1; % Ejemplo: 1 litro
V = 1000 * X; % Convertir a cm³

% Parámetros iniciales
x0 = 0.5; % Primer punto (ajustado)
x1 = 1.0; % Segundo punto (ajustado)
x2 = 1.5; % Tercer punto (ajustado)
tol = 1e-6; % Tolerancia
max_iter = 100; % Máximo número de iteraciones

% Llamada al método de Müller
[r_optimo, area_minima] = metodo_muller(V, x0, x1, x2, tol, max_iter);

% Verificar si se encontró una solución válida
if isnan(r_optimo)
    fprintf('No se encontró un radio óptimo válido.\n');
else
    % Calcular la altura óptima
    altura_optima = V / (pi * r_optimo^2);
    
    % Mostrar resultados
    fprintf('El radio óptimo es: %.4f cm\n', r_optimo);
    fprintf('La altura óptima es: %.4f cm\n', altura_optima);
    fprintf('El área mínima es: %.4f cm^2\n', area_minima);
end

% Método de Müller
function [r_optimo, area_minima] = metodo_muller(V, x0, x1, x2, tol, max_iter)
    % Definición de la función del área total dentro de la función
    A = @(r) 2*pi*(r + 0.2)^2 + (2*pi*(r + 0.2)) * (V / (pi * r^2));
    
    for iter = 1:max_iter
        % Evaluar la función en los puntos
        f0 = A(x0);
        f1 = A(x1);
        f2 = A(x2);
        
        % Imprimir valores para depuración
        fprintf('Iteración %d: f0 = %.4f, f1 = %.4f, f2 = %.4f\n', iter, f0, f1, f2);
        
        % Calcular la diferencia
        h0 = x1 - x0;
        h1 = x2 - x1;
        delta0 = (f1 - f0) / h0;
        delta1 = (f2 - f1) / h1;
        
        % Calcular el coeficiente cuadrático
        a = (delta1 - delta0) / (h1 + h0);
        b = a * h1 + delta1;
        c = f2;
        
        % Calcular el discriminante
        discriminante = b^2 - 4*a*c;
        
        % Calcular las dos posibles soluciones
        if discriminante >= 0
            r1 = x2 + (-2*c) / (b + sqrt(discriminante));
            r2 = x2 + (-2*c) / (b - sqrt(discriminante));
        else
            r1 = NaN; % No hay solución real
            r2 = NaN;
        end
        
        % Elegir la solución más cercana a x2
        if abs(r2 - x2) < abs(r1 - x2)
            r_optimo = r2;
        else
            r_optimo = r1;
        end
        
        % Verificar la convergencia
        if abs(A(r_optimo)) < tol
            break;
        end
        
        % Actualizar los puntos
        x0 = x1;
        x1 = x2;
        x2 = r_optimo;
    end
    
    % Calcular el área mínima usando el radio óptimo encontrado
    area_minima = A(r_optimo);
end