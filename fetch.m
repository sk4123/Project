% makes a matrix of the fit values along the y axis
function e=fetch(x,func)
    e = zeros(length(x),1);
    for i=1:length(func)
        e = [e,(func(1,i)*sin(func(2,i)*x+func(3,i))+func(4,i))'];
    end
    e = e(:,2:end);
end