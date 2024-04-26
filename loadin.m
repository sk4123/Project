% loads in the graphs of our data and returns the x and y values
function a=loadin(data) 
    c = openfig(data,'invisible');
    b = [findobj(c,'-property','XData'); findobj(c,'-property','YData')];
    a = [b(1).XData; b(2).YData];
end