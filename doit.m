% Weighted linear regression. S is the standard deviation of the y data, 
% X is the x data, and y is the mean of the y data per x point.
function [g,h] = doit(s,x,y)

    u = 1.96*s/sqrt(500);

    w = 1./u.^2;
    ss = sum(w);

    a = 0;
    b = 0;
    c = 0;
    d = 0;

    for i = 1:length(x)
        a = a + w(i)*x(i)^2;
        b = b + w(i)*x(i);
        c = c + w(i)*y(i);
        d = d + w(i)*x(i)*y(i);
    end

    bs = ss*a-(b)^2;

    g = (a*c-b*d)/bs;
    h = (ss*d-b*c)/bs;
end