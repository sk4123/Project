% find the standard deviation of the fit
function f=dev(fit,data)
    a = size(fit);
    a = a(2);
    b = a(1);
    e = zeros(1,a);
    for i=1:a
        for j=1:b
            e(i) = e(i) + (fit(j,i) - data(j,i))^2;
        end
    end
    f = 1.96*sqrt(e/(length(fit)-2));
end