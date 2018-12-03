
%% Cálculos auxiliares para resolver a Cinemática Inversa
% Porblema: normalmente ao usar a solve() dá em ordem a acos ou asin 
% queremos em ordem atan2

%% Resolver por ty/tx
equation = ty/tx == simplify( t0_2(2)/t0_2(1) );

theta1_sol = simplify( solve(equation, theta1) )


%NOTAS: 
% theta1_sol dá por:
% ty/tz => asin((L1 - (L2*tx + L3*tx*sin(theta2))/ty)/(L3*cos(theta2)))
% ty/tx => acos((tx*(L2 + L3*sin(theta2)))/(L3*ty*cos(theta2)))
% theta2_sol dá por:
% tz/tx => acos((L1*tx)/(L3*(ty*cos(theta1) + tx*sin(theta1))))


%% Resolver pela equação  tx² + ty² = tx'² + ty'²
equation2 = tx^2 + tx^2 == simplify( t0_2(1)^2 + t0_2(3)^2 );

% Pela equação facilmente extraímos o theta2:
theta1_sol = simplify( solve(equation2, theta2) )


%NOTAS: 
% theta1_sol dá por:
% tx² + ty² => acos((2*tx^2 - L2^2 - L3^2*sin(theta2)^2 - 2*L2*L3*sin(theta2))^(1/2)/(L3*cos(theta2)))
% theta2_sol dá por:
% tx² + tz² => -acos(((L1^2*sin(theta1)^2 - L1^2 + 2*tx^2)^(1/2) + L1*sin(theta1))/L3)



%% Resolver por ty/tx
equation = ty/tx == simplify( t0_2(2)/t0_2(1) )

theta1_sol = solve(equation, sin(theta2)/cos(theta1) )
% não funciona

%NOTAS: 
% theta1_sol dá por:









