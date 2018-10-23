%-------------------------------------------
%              normVector
%   2011179839 - João Pedro Pereira Palhinha         
%   2011151481 - Rui Pedro Rodrigues Baptista
%-------------------------------------------
function R_norm = normVector(r)
    R_norm(1,:) = r(1,1)/(sqrt(r(1,1)^2+r(2,1)^2+r(3,1)^2));
    R_norm(2,:) = r(2,1)/sqrt(r(1,1)^2+r(2,1)^2+r(3,1)^2);
    R_norm(3,:) = r(3,1)/sqrt(r(1,1)^2+r(2,1)^2+r(3,1)^2);
end