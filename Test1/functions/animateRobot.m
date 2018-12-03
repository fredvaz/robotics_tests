
%%

function animateRobot(T0, Ti, q, axis)

 
T0_1 = eval(subs(Ti(:,:,1), q(1,1))); 
T1_2 = eval(subs(Ti(:,:,2), q(1,2))); 
T2_3 = eval(subs(Ti(:,:,3), q(1,3)));
T3_4 = eval(subs(Ti(:,:,4), q(1,4)));

% Representação dos Elos do workspace (mundo)
%T0_1 = T0_1;
T0_2 = T0_1 * T1_2;
T0_3 = T0_1 * T1_2 * T2_3;
T0_4 = T0_1 * T1_2 * T2_3 * T3_4;

% Visualização
axis = [-8 8 -2 8 -2 8];

% Referencial Home 
trplot(T0, 'axis', axis, 'color', 'r', 'frame', 'T0', 'view', [75 10]);
hold on
trplot(T0_1, 'axis', axis, 'color', 'g', 'frame', 'T1');
hold on
trplot(T0_2, 'axis', axis, 'color', 'b', 'frame', 'T2');
hold on
%trplot(T0_3, 'axis', axis, 'color', 'm', 'frame', 'T3');
hold on
trplot(T0_4, 'axis', axis, 'color', 'k', 'frame', 'T4');
hold on

end

