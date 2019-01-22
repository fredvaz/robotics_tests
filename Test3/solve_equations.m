
%% Cálculos auxiliares para resolver a Cinemática Inversa
% Porblema: normalmente ao usar a solve() dá em ordem a acos ou asin 
% queremos em ordem atan2

%% Resolver por ty/tx
equation = ty/tx == simplify( t0_3(1)/t0_3(2) );

theta1_sol = simplify( solve(equation, theta1) )


%NOTAS: 
% theta1_sol dá por:
% ty/tz => asin((L1 - (L2*tx + L3*tx*sin(theta2))/ty)/(L3*cos(theta2)))
% ty/tx => acos((tx*(L2 + L3*sin(theta2)))/(L3*ty*cos(theta2)))
% theta2_sol dá por:
% tz/tx => acos((L1*tx)/(L3*(ty*cos(theta1) + tx*sin(theta1))))


%% d3 -> Resolver pela equação  tx² + ty² = tx'² + ty'²
equation2 = tx^2 + tx^2 == simplify( t0_3(1)^2 + t0_3(2)^2 );

% Pela equação facilmente extraímos o theta2:
sol = simplify( solve(equation2, d3) )


%NOTAS: 


%% Resolver por ty/tx
equation = ty/tx == simplify( t0_2(2)/t0_2(1) )

theta1_sol = solve(equation, sin(theta2)/cos(theta1) )
% não funciona

%NOTAS: 
% theta1_sol dá por:









