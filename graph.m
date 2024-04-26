% graphs two functions, one being the actual data and the other being the fit
function b=graph(data,fit,n)
    figure(n)
    plot(data(1,:),data(2,:));
    hold on
    fplot(@(x) fit(1)*sin(fit(2)*x+fit(3))+fit(4),[0 5])
    hold off
end