% fits the data to a sine curve
function c=fitin(data,vals)
    b = statset('MaxIter',100000);
    b.RobustWgtFun = 'bisquare';
    c = fitnlm(data(1,:),data(2,:),@(a,x) a(1)*sin(a(2)*x+a(3))+a(4),vals,'Options',b);
    c = table2array(c.Coefficients(:,1));
    if c(1) < 0
        c = c.*[-1;1;1;1]-[0;0;pi();0];
    end
end