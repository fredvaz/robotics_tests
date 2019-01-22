clear all
clc 

%% Part I

% Referencial Inicial
aTb = [ 1  0  0  0;
         0  1  0  0;
         0  0  1  0;
         0  0  0  1 ];
   
% Eixo de Rotação em A
br = [0 0 1]';

% IMPORTANTE: a vectorRot já faz a normalização
br_ = normVector(br);

%% 1)
alTa = aTb * transl(2 * br_)

alTb = alTa * aTb


%% 2)
ar = [0 -1 0]';
ar_ = normVector(ar);

bTbl = angvec2tr(-pi/2, ar_)

aTbl = aTb * bTbl

%% 3) 
ar = [1 0 0]';
ar__ = normVector(ar);

blTbll = angvec2tr(pi/2, ar__)

alTbll = (alTb * aTbl) * blTbll


%% b)

aTb_ = angvec2tr(pi/2, br_) * angvec2tr(-pi/2, ar__) * transl(-2 * br_) * alTbll


%% c) 
bllTblll = angvec2tr(pi/4, br_)

alTblll = alTbll * bllTblll

%% d) 

a = quarternionByR(alTbll(1:3,1:3))
b = quarternionByR(alTblll(1:3,1:3))







