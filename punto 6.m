r = 1; 

area = 2*pi*r^2 + 1.2*pi*r + 0.08*pi + 4000/r;

df = @(r) 4*pi*r + 1.2*pi - 4000/r^2;

r_optimo = fzero(df, r);

area_minima = 2*pi*r_optimo^2 + 1.2*pi*r_optimo + 0.08*pi + 4000/r_optimo;
altura_optima = 2000 / (pi*r_optimo^2);

fprintf('El radio óptimo es: %.4f cm\n', r_optimo);
fprintf('La altura óptima es: %.4f cm\n', altura_optima);
fprintf('El área mínima es: %.4f cm^2\n', area_minima);