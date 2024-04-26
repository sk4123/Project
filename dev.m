% find the standard deviation of the fit
function f=dev(fit,data)
    a = length(fit);
    e = zeros(1,a);
        for j=1:a
            e(j+1) = e(j) + (data(1,j) - fit(1,j))^2;
        end
    f = 1.96*sqrt(e/(length(fit)-2));
    f = f(2:end);
end