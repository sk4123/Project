% finds the phase lag of elements in an array
function g = getlag(a)
    g = zeros(length(a)-1);
    for i = 2:length(a)
        g(i-1) = finddelay(a(i),a(i-1));
    end
end