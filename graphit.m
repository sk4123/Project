% graphs two functions, one being the actual data and the other being the fit
function b=graphit(data,fit,n)
    figure(n)
    plot(data(1,:),data(2,:));
    hold on
    fplot(@(x) fit(1)*sin(fit(2)*x+fit(3))+fit(4),[0 5])
    title("Experimental Values with Fit")
    ylabel("Voltage (V)")
    xlabel("Time (s)")
    legend("Experimental Data",['V = ' num2str(fit(1)) 'sin(' num2str(fit(2)) 't + ' num2str(fit(3)) ')+ ' num2str(fit(4))])
    hold off
end