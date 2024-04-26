% outputs the magnitude ratio and phase shift of a second order system
% first column is the magnitude ratio, second is the phase shift
function d=secondvals(w,wn,zeta)
    a = (2*zeta*w/wn);
    b = (1-(w/wn).^2);

    d = zeros(6,2);
    d(:,1) = (1./sqrt(a.^2+b.^2))';
    d(:,2) = (-atan(a./b))';
end